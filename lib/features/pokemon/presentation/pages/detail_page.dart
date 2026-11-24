import 'package:flutter/material.dart';

import '../../../../core/theme/app_theme.dart';
import '../../../../core/utils/texto.dart';
import '../../../../core/widgets/pokemon_image.dart';
import '../../domain/entities/pokemon.dart';
import '../../domain/entities/pokemon_detail.dart';
import '../../domain/entities/pokemon_stat.dart';
import '../widgets/chip_tipo.dart';
import '../widgets/indicador_conexion.dart';
import '../widgets/type_colors.dart';

// La API manda los nombres de las estadísticas en inglés
const _nombresEstadisticas = {
  'hp': 'PS',
  'attack': 'Ataque',
  'defense': 'Defensa',
  'special-attack': 'At. esp.',
  'special-defense': 'Def. esp.',
  'speed': 'Velocidad',
};

// Pantalla de detalle, solo dibuja lo que recibe
class DetailPage extends StatelessWidget {
  const DetailPage({
    super.key,
    required this.pokemon,
    required this.detalle,
    required this.etiquetaHero,
  });

  final Pokemon pokemon;
  final PokemonDetail? detalle;
  final String etiquetaHero;

  @override
  Widget build(BuildContext context) {
    // La imagen oficial si existe, si no el sprite (RF-DET-01)
    final imagen = detalle?.artwork ?? pokemon.artworkUrl ?? pokemon.imageUrl;
    // Las estadísticas ya vienen con el catálogo, así se ven al instante y sin conexión
    final estadisticas = pokemon.stats.isNotEmpty
        ? pokemon.stats
        : (detalle?.estadisticas ?? const <PokemonStat>[]);

    return Scaffold(
      appBar: AppBar(actions: const [IndicadorConexion()]),
      // Con slivers, las secciones largas que vienen después se construyen solo cuando se ven
      body: CustomScrollView(
        slivers: [
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(16, 0, 20, 16),
              child: _Cabecera(
                pokemon: pokemon,
                imagen: imagen,
                etiquetaHero: etiquetaHero,
              ),
            ),
          ),
          SliverPadding(
            padding: const EdgeInsets.fromLTRB(16, 0, 16, 24),
            sliver: SliverList.list(
              children: [
                _PanelEstadisticas(estadisticas: estadisticas),
                const SizedBox(height: 16),
                _PanelDatos(detalle: detalle),
              ],
            ),
          ),
        ],
      ),
    );
  }
}


// Número, imagen grande, nombre y tipos, con el borde y la sombra del tipo
class _Cabecera extends StatelessWidget {
  const _Cabecera({
    required this.pokemon,
    required this.imagen,
    required this.etiquetaHero,
  });

  final Pokemon pokemon;
  final String? imagen;
  final String etiquetaHero;

  @override
  Widget build(BuildContext context) {
    final temaTexto = Theme.of(context).textTheme;
    final nombre = capitalizar(pokemon.name);
    final numero = '#${pokemon.nationalDexNumber.toString().padLeft(4, '0')}';
    final colorBorde = pokemon.types.isEmpty
        ? Paleta.borde
        : colorBordeTipo(colorDeTipo(pokemon.types.first.name));

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Paleta.superficie,
        borderRadius: BorderRadius.circular(6),
        border: Border.all(color: colorBorde, width: 2),
        boxShadow: [BoxShadow(color: colorBorde, offset: const Offset(4, 4))],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            numero,
            style: temaTexto.labelLarge?.copyWith(
              fontWeight: FontWeight.w600,
              color: Paleta.textoSecundario,
            ),
          ),
          Center(
            // Misma etiqueta que la tarjeta, así la imagen vuela del catálogo al detalle
            child: Hero(
              tag: etiquetaHero,
              child: PokemonImage(
                url: imagen,
                size: 240,
                semanticLabel: nombre,
              ),
            ),
          ),
          // El nombre se achica para caber completo con texto grande (RNF-ACC-04)
          FittedBox(
            fit: BoxFit.scaleDown,
            alignment: Alignment.centerLeft,
            child: Semantics(
              header: true,
              child: Text(
                nombre,
                maxLines: 1,
                style: temaTexto.headlineMedium?.copyWith(
                  fontWeight: FontWeight.w800,
                ),
              ),
            ),
          ),
          const SizedBox(height: 8),
          Wrap(
            spacing: 8,
            runSpacing: 6,
            children: pokemon.types.map((t) {
              return ChipTipo(
                etiqueta: capitalizar(t.name),
                color: colorDeTipo(t.name),
              );
            }).toList(),
          ),
        ],
      ),
    );
  }
}

// Caja con título que usan todas las secciones del detalle
class _Panel extends StatelessWidget {
  const _Panel({required this.titulo, required this.hijo});

  final String titulo;
  final Widget hijo;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Paleta.superficie,
        borderRadius: BorderRadius.circular(6),
        border: Border.all(color: Paleta.borde, width: 2),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Semantics(
            header: true,
            child: Text(
              titulo,
              style: Theme.of(context).textTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.w800,
              ),
            ),
          ),
          const SizedBox(height: 12),
          hijo,
        ],
      ),
    );
  }
}

// Una barra por estadística y el total abajo
class _PanelEstadisticas extends StatelessWidget {
  const _PanelEstadisticas({required this.estadisticas});

  final List<PokemonStat> estadisticas;

  @override
  Widget build(BuildContext context) {
    final total = estadisticas.fold<int>(0, (suma, s) => suma + s.baseStat);

    return _Panel(
      titulo: 'Estadísticas base',
      hijo: estadisticas.isEmpty
          ? const Text('Las estadísticas todavía no están disponibles')
          : Column(
        children: [
          for (final s in estadisticas)
            _FilaEstadistica(nombre: s.name, valor: s.baseStat),
          const Divider(color: Paleta.borde, height: 20),
          MergeSemantics(
            child: Row(
              children: [
                const Expanded(
                  child: Text(
                    'Total',
                    style: TextStyle(fontWeight: FontWeight.w800),
                  ),
                ),
                Text(
                  '$total',
                  style: const TextStyle(fontWeight: FontWeight.w800),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _FilaEstadistica extends StatelessWidget {
  const _FilaEstadistica({required this.nombre, required this.valor});

  final String nombre;
  final int valor;

  // 255 es el valor base más alto que puede tener una estadística
  // El porcentaje y el largo de la barra se calculan contra ese máximo
  static const _maximo = 255;

  @override
  Widget build(BuildContext context) {
    final fraccion = (valor / _maximo).clamp(0.0, 1.0);
    final porcentaje = (fraccion * 100).round();
    final etiqueta = _nombresEstadisticas[nombre] ?? capitalizar(nombre);

    // El lector de pantalla lee la fila entera, el valor también está en texto
    // así que no depende solo de la barra ni del color (RNF-ACC-05)
    return Semantics(
      label: '$etiqueta: $valor de $_maximo, $porcentaje por ciento',
      excludeSemantics: true,
      child: Padding(
        padding: const EdgeInsets.only(bottom: 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Expanded(child: Text(etiqueta)),
                Text(
                  '$valor ($porcentaje%)',
                  style: const TextStyle(fontWeight: FontWeight.w700),
                ),
              ],
            ),
            const SizedBox(height: 4),
            // La barra se llena al abrir la pantalla
            TweenAnimationBuilder<double>(
              tween: Tween(begin: 0, end: fraccion),
              duration: const Duration(milliseconds: 600),
              curve: Curves.easeOut,
              builder: (_, progreso, _) => LinearProgressIndicator(
                value: progreso,
                minHeight: 10,
                color: Paleta.rosa,
                backgroundColor: Paleta.fondo,
                borderRadius: BorderRadius.circular(2),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// Altura, peso y grupos huevo, vienen del detalle descargado
class _PanelDatos extends StatelessWidget {
  const _PanelDatos({required this.detalle});

  final PokemonDetail? detalle;

  @override
  Widget build(BuildContext context) {
    final d = detalle;

    return _Panel(
      titulo: 'Datos',
      hijo: d == null
          ? const Text(
        'El detalle todavía no se ha descargado, aparecerá cuando haya conexión',
      )
          : Column(
        children: [
          // La API manda la altura en decímetros y el peso en hectogramos
          _Dato(
            etiqueta: 'Altura',
            valor: '${(d.altura / 10).toStringAsFixed(1)} m',
          ),
          _Dato(
            etiqueta: 'Peso',
            valor: '${(d.peso / 10).toStringAsFixed(1)} kg',
          ),
          _Dato(
            etiqueta: 'Grupos huevo',
            valor: d.gruposHuevo.isEmpty
                ? 'Ninguno'
                : d.gruposHuevo
                .map((g) => capitalizar(g.replaceAll('-', ' ')))
                .join(', '),
          ),
        ],
      ),
    );
  }
}

class _Dato extends StatelessWidget {
  const _Dato({required this.etiqueta, required this.valor});

  final String etiqueta;
  final String valor;

  @override
  Widget build(BuildContext context) {
    return MergeSemantics(
      child: Padding(
        padding: const EdgeInsets.only(bottom: 8),
        child: Wrap(
          alignment: WrapAlignment.spaceBetween,
          crossAxisAlignment: WrapCrossAlignment.start,
          spacing: 16,
          runSpacing: 2,
          children: [
            Text(
              etiqueta,
              style: const TextStyle(color: Paleta.textoSecundario),
            ),
            Text(
              valor,
              style: const TextStyle(fontWeight: FontWeight.w600),
            ),
          ],
        ),
      ),
    );
  }
}