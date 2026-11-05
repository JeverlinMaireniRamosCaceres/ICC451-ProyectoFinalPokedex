import 'features/pokemon/data/datasources/local/pokemon_local_datasource.dart';
import 'features/pokemon/domain/entities/pokemon.dart';
import 'features/pokemon/domain/entities/pokemon_type.dart';

// TEMPORAL: datos de prueba para ver el catálogo, borrar cuando funcione el sync real
const _grass = PokemonType(id: 12, name: 'grass');
const _poison = PokemonType(id: 4, name: 'poison');
const _fire = PokemonType(id: 10, name: 'fire');
const _water = PokemonType(id: 11, name: 'water');
const _bug = PokemonType(id: 7, name: 'bug');
const _normal = PokemonType(id: 1, name: 'normal');
const _flying = PokemonType(id: 3, name: 'flying');
const _electric = PokemonType(id: 13, name: 'electric');

const _base =
    'https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon';

Future<void> sembrarDatosDePrueba(PokemonLocalDataSource local) {
  return local.upsertPokemons(const [
    Pokemon(
      id: 1,
      name: 'bulbasaur',
      nationalDexNumber: 1,
      types: [_grass, _poison],
      imageUrl: '$_base/1.png',
      generationId: 1,
    ),
    Pokemon(
      id: 4,
      name: 'charmander',
      nationalDexNumber: 4,
      types: [_fire],
      imageUrl: '$_base/4.png',
      generationId: 1,
    ),
    Pokemon(
      id: 7,
      name: 'squirtle',
      nationalDexNumber: 7,
      types: [_water],
      imageUrl: '$_base/7.png',
      generationId: 1,
    ),
    Pokemon(
      id: 10,
      name: 'caterpie',
      nationalDexNumber: 10,
      types: [_bug],
      imageUrl: '$_base/10.png',
      generationId: 1,
    ),
    Pokemon(
      id: 16,
      name: 'pidgey',
      nationalDexNumber: 16,
      types: [_normal, _flying],
      imageUrl: '$_base/16.png',
      generationId: 1,
    ),
    Pokemon(
      id: 25,
      name: 'pikachu',
      nationalDexNumber: 25,
      types: [_electric],
      imageUrl: '$_base/25.png',
      generationId: 1,
    ),
  ]);
}