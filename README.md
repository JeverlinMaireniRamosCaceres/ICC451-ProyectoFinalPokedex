# Pokédex Flutter

App en Flutter que muestra el catálogo de Pokémon con la API GraphQL de PokeAPI. Funciona con y sin internet, porque los datos se guardan en una base local y la pantalla siempre lee de ahí.

**Integrantes** Jeverlin Ramos y Esmery Vásquez

## Cómo ejecutarlo

```bash
flutter pub get
dart run build_runner build
flutter run
```

## Tecnologías

- **dio** para las consultas GraphQL
- **drift** para la base de datos local
- **flutter_riverpod** para el estado
- **connectivity_plus** para detectar la red
- **cached_network_image** para las imágenes sin conexión

## Arquitectura

- **presentation**, las pantallas y el estado
- **domain**, las entidades y el contrato del repositorio
- **data**, la API, la base local y la sincronización

## Sincronización

La app pide los Pokémon a PokeAPI de 20 en 20, los guarda en la base local y la pantalla se actualiza sola. El avance se guarda en la tabla SyncMetadata, así continúa donde quedó aunque se cierre la app.

## Decisiones

Están en el adr.
