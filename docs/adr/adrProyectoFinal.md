[ADR - Proyecto Final.md](https://github.com/user-attachments/files/34943930/ADR.-.Proyecto.Final.md)
***ADR-001:** Modelo de datos local con Drift*

***Contexto:***

La aplicación debe funcionar sin conexión, así que necesita una base local estructurada que sea la fuente de verdad de la interfaz. Esa base tiene que guardar el catálogo, soportar búsqueda, filtros y orden sin conexión, y guardar aparte los datos del usuario (favoritos, puntuaciones), que no tienen equivalente remoto y no se pueden perder cuando el catálogo se sincroniza. También hace falta que la interfaz se actualice sola cuando la base cambia, que las escrituras no dejen datos parciales ante una interrupción, y que sincronizar varias veces no genere duplicados.

La entrega final pide mostrar las estadísticas base en el detalle, ordenar el catálogo por el total de estadísticas sin conexión y mostrar el artwork oficial en el detalle. Por eso esos datos se decidieron antes del avance.

***Decisión:***

Se usó Drift sobre SQLite, con las siguientes tablas:

* *Pokemons:* el catálogo, con el id de PokeAPI como clave primaria. Guarda imageUrl (el sprite, que usa el catálogo), artworkUrl (la imagen oficial, que usará el detalle), generationId y baseStatTotal (la suma de las 6 estadísticas base).   
* *Types:* los tipos de Pokémon. PokemonTypes: relación entre Pokémon y tipos, con clave compuesta (pokemonId, typeId) y una columna slot que indica si es el tipo principal o el secundario.   
* *PokemonStats:* las 6 estadísticas base de cada Pokémon, con clave compuesta (pokemonId, statName).   
* *Favorites:* favoritos del usuario, en una tabla aparte.   
* *SyncMetadata:* última sincronización exitosa, estado y siguiente offset por recurso. 

***Puntos clave:***

* Se usa el id de PokeAPI como clave primaria, porque es estable entre sincronizaciones y permite hacer upsert sin duplicar.   
    
* Favorites y SyncMetadata están separadas del catálogo, para que la sincronización nunca las modifique. Las tablas están en tres archivos por tema: catálogo, usuario y sincronización.   
    
* Se crearon índices sobre name, nationalDexNumber, generationId y baseStatTotal, que son los campos de búsqueda, orden y filtro sin conexión.   
    
* baseStatTotal se guarda ya calculado en la tabla de Pokémon. Así ordenar por total es un orden simple sobre un índice, sin sumar las estadísticas con un join en cada consulta. El catálogo tampoco necesita leer las 6 estadísticas, solo el detalle.   
    
* artworkUrl se guarda aparte de imageUrl. El catálogo usa el sprite porque pesa mucho menos y permite guardar en caché todo el catálogo para verlo sin conexión (ADR-003). El detalle usa el artwork y, si falta, el sprite.   
    
* generationId se guarda desde ahora, para no tener que hacer una migración al agregar el filtro por generación.   
    
* upsertPokemons vive en PokemonLocalDataSource, recibe List\<Pokemon\> y corre en una transacción con batch. Antes de insertar borra los tipos y las estadísticas de esos Pokémon, para que la base quede igual que PokeAPI si cambian.  
    
* AppDatabase solo tiene las tablas, la versión del esquema y la conexión. Acepta un ejecutor opcional por constructor, para poder usar una base en memoria en pruebas.   
    
* Se usa @DataClassName (PokemonRow, TypeRow, PokemonTypeRow, PokemonStatRow) para que las clases generadas por Drift no choquen con las entidades del dominio ni con Type de Dart. 


  
***Alternativas consideradas***

* Una caché de respuestas HTTP: no permite búsquedas ni filtros nuevos sin conexión, y no guarda datos del usuario  
* SQLite directo con sqflite: funciona, pero sin Streams reactivos ni tablas tipadas habría que escribir más código y la interfaz no se actualizaría sola.  
* Calcular el total de estadísticas con un SUM en cada consulta: evita una columna repetida, pero cada orden por total tendría que hacer un join y sumar. Se prefirió la columna ya calculada.   
* Guardar las estadísticas como 6 columnas de la tabla de Pokémon: serían columnas fijas. Se prefirió una tabla aparte, que sigue el Diagrama 6 y permite agregar otras estadísticas sin cambiar la tabla principal. 

***Consecuencias***

*Positivas:*

La interfaz observa Streams de la base y se actualiza sola.  
Las escrituras son atómicas, y una interrupción no deja datos parciales.  
Sincronizar varias veces no duplica registros.  
Los favoritos no se ven afectados por la sincronización.  
Las búsquedas, filtros y orden por nombre, número, generación y total funcionan sin conexión.   
El detalle ya tiene de dónde sacar el artwork y las estadísticas sin cambiar el esquema. 

*Negativas:*

Drift necesita generar código con build\_runner, y hay que volver a correrlo cada vez que cambia una tabla.  
Cambiar el esquema obliga a subir schemaVersion y escribir una migración.  
baseStatTotal es un dato repetido, porque se puede calcular desde PokemonStats.   
Si alguien cambia una estadística sin recalcular el total, quedan desincronizados. Por eso el total se calcula en un solo lugar (el mapper de DTOs) y siempre se guarda junto con las estadísticas dentro de la misma transacción.  
Se guardan las estadísticas de los 1025 Pokémon aunque la lista no las use, y eso ocupa más espacio.

***ADR-002***: *Consulta GraphQL del catálogo y estrategia de paginación* 

***Contexto:*** 

La aplicación necesita obtener el catálogo de Pokémon desde PokeAPI para guardarlo en la base de datos local. El catálogo tiene 1025 Pokémon en su forma principal. Para cada uno, la lista necesita el nombre, el número de Pokédex, los tipos y la imagen. 

Además, la entrega final pide filtrar por generación y ordenar por el total de estadísticas sin conexión, por lo que los datos deben estar guardados localmente.

PokeAPI ofrece un endpoint GraphQL gratuito en *https\://graphql.pokeapi.co/v1beta2*. 

Este endpoint solo acepta peticiones POST y tiene límite de tasa, por lo que no conviene hacer muchas peticiones seguidas.

***Decisión:*** 

Se usó una sola consulta en GraphQL, llamada *CatalogoPokemon*, con paginación por limit y offset:

query CatalogoPokemon(\$limit: Int\!, \$offset: Int\!) {  
  pokemon(  
    limit: \$limit  
    offset: \$offset  
    order\_by: { id: asc }  
    where: { is\_default: { \_eq: true } }  
  ) {  
    id  
    name  
    pokemon\_species\_id  
    pokemontypes(order\_by: { slot: asc }) {  
      slot  
      type { id name }  
    }  
    pokemonsprites {  
      sprite: sprites(path: "front\_default")  
      artwork: sprites(path: "other.official-artwork.front\_default")  
    }  
    pokemonspecy {  
      generation\_id  
    }  
    pokemonstats {  
      base\_stat  
      stat { name }  
    }  
  }  
  pokemon\_aggregate(where: { is\_default: { \_eq: true } }) {  
    aggregate { count }  
  }  
}

***Puntos claves de la decisión:*** 

* Páginas de 20 Pokémon. Las páginas se piden a medida que el usuario hace scroll, no todas de una vez.  
    
* order\_by: { id: asc } garantiza un orden estable, para que las páginas no se mezclen entre peticiones.  
    
* is\_default: true trae solo la forma principal de cada Pokémon. Las formas regionales y variantes se consultarán en el detalle.  
    
* sprites(path: ...) extrae solo las dos URLs de imagen necesarias, en lugar del JSON completo con todos los sprites.  
    
* generation\_id y pokemonstats se incluyen desde ahora para permitir el filtro por generación y el orden por estadísticas sin conexión, sin tener que cambiar el modelo de datos después.  
    
* pokemon\_aggregate devuelve el total de Pokémon disponibles, para saber si el catálogo local está completo.  
    
* Variables \$limit y \$offset, para reutilizar la misma consulta en todas las páginas.

***Alternativas consideradas***

* Se descartó porque obtener los tipos, la imagen y las estadísticas de cada Pokémon requiere una petición por Pokémon, y devuelve muchos campos que no se usan. GraphQL trae todo lo necesario de 20 Pokémon en una sola petición.  
    
* Descargar los 1025 Pokémon en una sola petición. Se descartó por el límite de tasa de la API, el tamaño de la respuesta y porque bloquearía la primera carga.  
    
* Paginación por clave (where id mayor que el último id). Es más resistente si la API agrega registros intermedios, pero para un catálogo que cambia muy poco, offset es más simple y suficiente. Los posibles duplicados se evitan con el upsert por id.  
    
* Traer el campo sprites completo. Se descartó porque es un JSON grande con decenas de URLs, cuando la app solo usa dos.

***Consecuencias***

*Positivas:*

* Una petición trae todos los datos de 20 Pokémon, sin pedir de más.  
    
* El filtro por generación y el orden por estadísticas funcionarán sin conexión.  
    
* Con el total de Pokémon se puede avisar al usuario si el catálogo local está incompleto.

*Negativas:*

* Cada respuesta es más pesada por incluir las estadísticas.  
    
* Si la API agregara Pokémon en medio del orden, offset podría desplazar páginas. Se mitiga con el upsert por id.  
    
* El endpoint está en versión beta (v1beta2), así que los nombres de los campos podrían cambiar en el futuro.

***ADR-003:*** *DTOs para la respuesta de la API*

***Contexto***

La consulta *CatalogoPokemon* devuelve un JSON con una estructura que depende de PokeAPI. Algunas partes son incómodas de usar. Los sprites llegan dentro de una lista aunque haya un solo elemento, los tipos vienen anidados dentro de pokemontypes.type, la especie se llama pokemonspecy y varios campos pueden venir null. 

La arquitectura del proyecto exige que la capa de datos tenga DTOs y mapeadores, y que no exponga DTOs a la presentación. Además, el JSON debe leerse de forma segura para que un campo faltante no haga fallar la aplicación.

***Decisión***

Se crearon DTOs escritos a mano, con un constructor *fromJson*, en *lib/features/pokemon/data/dtos/pokemon\_dto.dart*. Hay una clase por cada parte de la respuesta.

* PokemonPageDto representa la respuesta completa, con la lista de Pokémon de la página y el total disponible (totalCount).  
    
* PokemonDto representa un Pokémon.  
    
* PokemonTypeDto representa un tipo, con su slot.  
    
* PokemonStatDto representa una estadística base.

Los DTOs siguen estas reglas.

* Respetan la estructura del JSON y solo lo convierten en objetos de Dart. No tienen lógica de la aplicación.  
    
* Los campos que pueden faltar (sprite, artwork, generationId) son opcionales (String?, int?).  
    
* Si una lista no llega, se usa una lista vacía en lugar de fallar.  
    
* Los nombres se adaptan a la convención de Dart, por ejemplo pokemon\_species\_id pasa a speciesId.  
    
* Los DTOs solo se usan dentro de la capa de datos. Un mapper los convierte en la entidad Pokemon del dominio, que es lo que usan la base local y las pantallas.

El mapper está en lib/features/pokemon/data/mappers/pokemon\_dto\_mapper.dart y se implementa con extensiones de Dart (toEntity() y toEntities()), para no modificar las clases DTO. Al convertir los datos se aplican estas reglas.

* speciesId pasa a nationalDexNumber, y typeId y typeName pasan a la entidad PokemonType.  
* Los tipos se ordenan por slot, para que el tipo principal quede siempre primero. La consulta ya los pide en ese orden, pero se ordenan de nuevo como protección.  
* Para imageUrl se usa el sprite y, si no existe, el artwork oficial. Se prefiere el sprite porque pesa mucho menos, lo que permite guardar en caché las imágenes de todo el catálogo para verlas sin conexión. El artwork queda para la pantalla de detalle.  
* Las estadísticas todavía no se convierten, porque la entidad Pokemon aún no tiene un campo para ellas.

El mapper que convierte las filas de la base de datos en entidades es un archivo distinto (pokemon\_row\_mapper.dart), para que cada uno conozca un solo formato externo.

***Alternativas consideradas***

* Usar el JSON directamente (Map de String a dynamic) en el resto de la app. Se descartó porque los errores de nombres de campos solo aparecerían al ejecutar, y cualquier cambio en la API obligaría a modificar pantallas y base de datos.  
    
* Convertir el JSON directamente en la entidad Pokemon. Se descartó porque mezclaría el formato de PokeAPI con el dominio. Si la API cambia, el dominio no debe enterarse.  
    
* Generar los DTOs con json\_serializable o freezed. Reducen código repetido, pero requieren anotaciones y ejecutar build\_runner. Con cuatro clases pequeñas, escribirlas a mano es más simple y más fácil de explicar en la defensa.  
    
* Generar tipos desde el esquema GraphQL (por ejemplo con graphql\_codegen). Da tipos exactos, pero agrega dependencia de herramientas y del esquema v1beta2, que todavía es beta.

***Consecuencias***

*Ventajas*

* Si PokeAPI cambia el nombre o la forma de un campo, solo se modifican el DTO y el mapper.  
    
* Los datos faltantes no hacen fallar la aplicación.  
    
* Se cumple la separación de capas, ya que la presentación nunca ve un DTO.

*Desventajas*

* Hay más código que escribir y mantener, porque cada campo nuevo de la consulta debe agregarse a mano en el DTO.  
    
* Hace falta un paso más (el mapper) para llegar a la entidad del dominio.  
* Un error de tipo en el fromJson (por ejemplo esperar int y recibir String) solo se detecta al ejecutar. Se mitiga probando con respuestas reales de la API.


***ADR-004:*** *Cliente HTTP y data source remoto*

***Contexto***

La aplicación necesita enviar la consulta *CatalogoPokemon* a la API GraphQL de PokeAPI, en graphql.pokeapi.co/v1beta2. Esta API solo acepta peticiones POST y tiene límite de tasa.

El proyecto exige que las peticiones de red tengan un timeout explícito, para que la aplicación no quede esperando indefinidamente si la API no responde. También es necesario distinguir entre dos tipos de fallo, cuando no hay conexión o la petición no llega a tiempo, y cuando la API sí responde pero con una respuesta que no se puede usar. Esta diferencia será necesaria para el indicador de conectividad.

Además, en GraphQL una petición fallida puede llegar con código HTTP 200 y el error dentro del JSON, en el campo errors. Y puede llegar una respuesta con datos y errores a la vez (errores parciales).

Por último, la base de datos local es la única fuente de verdad de la aplicación, así que la capa remota no debe guardar su propia caché de los datos.

***Decisión***

Se creó la clase PokemonRemoteDataSource en *lib/features/pokemon/data/datasources/remote/*, que usa el paquete dio para las peticiones.

* El método fetchPokemonPage(limit, offset) envía la consulta por POST con sus variables y devuelve un PokemonPageDto.  
    
* Se configuran connectTimeout y receiveTimeout de 10 segundos.  
    
* Cada consulta se imprime en consola con debugPrint, para poder mostrarla durante la demostración.  
    
* Si la respuesta no trae data, se lanza una PokemonApiException con el mensaje del primer error que envió la API.  
    
* Si la respuesta trae data y errors a la vez, se registran los errores en consola y se usan los datos que sí llegaron.  
    
* Los fallos de red (sin conexión, timeout) no se capturan aquí. Los lanza dio como DioException, y el repositorio decidirá cómo tratarlos.  
    
* La instancia de Dio se puede pasar desde fuera por el constructor (inyección de dependencias), lo que permite usar otra configuración en las pruebas.


***Alternativas consideradas***

* Paquete http. Es más simple, pero el timeout se configura en cada petición por separado y no tiene interceptores. Se descartó porque dio permite definir los timeouts una sola vez y facilita agregar reintentos más adelante.  
    
* Cliente GraphQL completo (graphql\_flutter o graphql). Ofrece consultas tipadas y manejo de errores incluido, pero trae su propia caché de respuestas. Se descartó porque podría confundirse con la persistencia, y el proyecto exige que la base local sea la única fuente de verdad.  
    
* Generación de código desde el esquema (ferry o graphql\_codegen). Da tipos exactos, pero agrega herramientas de compilación y depende de un esquema que todavía está en versión beta.  
* Dejar el timeout por defecto. Se descartó porque el proyecto pide un timeout explícito, y sin él la aplicación podría quedar esperando mucho tiempo si la API no responde.

***Consecuencias***

*Ventajas*

* Los timeouts se definen en un solo lugar y aplican a todas las peticiones.  
    
* Se distinguen los fallos de red de los fallos de la API, lo que permite mostrar el estado correcto en el indicador.  
    
* Los errores parciales no hacen perder los datos que sí llegaron.  
    
* Se puede mostrar la consulta enviada durante la defensa.  
    
* La clase se puede probar pasándole otra instancia de Dio.

*Desventajas*

* Se agrega una dependencia externa al proyecto.  
    
* Todavía no hay reintentos. Se agregarán con backoff exponencial como parte de la estrategia de sincronización.  
    
* Un timeout de 10 segundos puede sentirse largo con una red lenta, pero como la sincronización ocurre en segundo plano, no bloquea la interfaz.  
    
* El repositorio tendrá que traducir DioException y PokemonApiException a errores del dominio, para que la presentación no dependa de dio.

***ADR-005:*** *Estrategia de sincronización del catálogo*

***Contexto***

La aplicación es Offline-First. La interfaz solo lee de la base de datos local, que es la fuente de verdad, y PokeAPI es la fuente autoritativa de los datos del catálogo. Hace falta una forma de llevar los datos de la API a la base local que cumpla varias condiciones.

* No debe bloquear la interfaz mientras descarga.  
* No debe crear Pokémon duplicados aunque una página se pida varias veces.  
* Debe recordar hasta dónde llegó, incluso después de cerrar la app, para continuar desde ahí.  
* No debe dejar datos a medias si la red se corta durante una escritura.  
* No debe ejecutar dos sincronizaciones del mismo recurso a la vez.  
* No debe tocar los datos propios del usuario, como los favoritos.

El catálogo tiene 1025 Pokémon y la API tiene límite de peticiones, así que no conviene descargarlo todo de una vez (ADR-002).

***Decisión***

Creamos la clase PokemonSyncCoordinator en lib/features/pokemon/data/sync/. Usa el data source remoto (ADR-004) para pedir páginas, el mapper (ADR-003) para convertirlas en entidades y el upsertPokemons del data source local para guardarlas. La sincronización es unidireccional, de la API hacia la base local.

* Páginas de 20 Pokémon. El método fetchNextPage() pide la siguiente página pendiente. Lo usarán el scroll infinito y el botón Reintentar.  
* Refresco al abrir la app. El método refreshCatalog() vuelve a pedir la primera página para actualizar lo primero que ve el usuario. Se llamará sin esperar su resultado, para que la pantalla muestre de inmediato los datos locales.  
* Avance guardado en la tabla SyncMetadata. Se guardan el siguiente offset (nextOffset), la fecha de la última sincronización exitosa (lastSuccessAt) y el estado (idle, syncing, complete o error), con la clave pokemon\_catalog.  
* El avance nunca retrocede. Al refrescar la primera página, nextOffset se mantiene en el valor más alto alcanzado.  
* Una transacción por página. Los Pokémon y la actualización de SyncMetadata se guardan en la misma transacción. Si algo falla, no se guarda ninguno de los dos.  
* Upsert por id. upsertPokemons inserta o actualiza cada Pokémon según su id, así que pedir una página otra vez la actualiza en lugar de duplicarla.  
* Control de concurrencia. Si se pide una sincronización mientras otra está en curso, se devuelve la que ya está corriendo en lugar de empezar una nueva.  
* Fin del catálogo. Cuando nextOffset alcanza el total que informa la API, el estado pasa a complete y fetchNextPage() deja de hacer peticiones.  
* Errores. Si una petición falla, el estado pasa a error, el avance no cambia y el error se propaga para que la interfaz pueda ofrecer Reintentar.  
* Favoritos separados. Los favoritos viven en su propia tabla, que la sincronización no toca.

***Alternativas consideradas***

* Descargar todo el catálogo al iniciar. Se descartó porque son 52 peticiones seguidas, lo que choca con el límite de la API y hace esperar mucho en la primera apertura.  
    
* Sincronizar en segundo plano con el sistema operativo (por ejemplo con WorkManager). Permite actualizar con la app cerrada, pero agrega configuración específica de cada plataforma. Para el avance basta con sincronizar mientras la app está abierta.  
    
* Guardar el avance solo en memoria. Se descartó porque al cerrar la app se perdería y habría que empezar desde el principio.  
    
* Guardar los Pokémon y el avance por separado. Se descartó porque, si la app se cierra entre las dos escrituras, el avance podría apuntar a páginas que no se guardaron.  
    
* Reiniciar el offset en cada refresco. Se descartó porque obligaría a volver a descargar todo el catálogo cada vez que se abre la app.  
    
* Cancelar la sincronización en curso al pedir otra. Se descartó porque podría dejar peticiones a medias. Reutilizar la que ya corre es más simple y seguro.

***Consecuencias***

*Ventajas*

* La interfaz nunca espera a la red, porque siempre muestra lo que hay en la base local.  
* Pedir la misma página varias veces no crea duplicados.  
* La descarga continúa donde quedó, incluso después de cerrar la app.  
* Una página nunca queda guardada a medias.  
* Se respeta el límite de la API, porque solo se piden páginas cuando hacen falta.

*Desventajas*

* El catálogo completo solo está disponible sin conexión después de que el usuario haya recorrido todas las páginas con conexión.  
* El refresco solo actualiza la primera página. Los cambios de la API en páginas ya descargadas no se ven hasta volver a pedirlas.  
* Todavía no hay reintentos automáticos con backoff exponencial. Se agregarán para la entrega final.  
* El estado Sincronizando del indicador todavía no está conectado al coordinador. Se conectará cuando esté listo el monitor de conectividad.  
* La detección y restauración de datos alterados en la base local (OF-19) todavía no está implementada.

***ADR-006*****:** *Monitor de conectividad e indicador global*

***Contexto***

La aplicación debe informar en todo momento el estado de la conexión con un indicador visible. El proyecto distingue cuatro estados, Online, Offline, Servicio no disponible y Sincronizando.

Saber si el teléfono tiene Wi-Fi o datos móviles no basta. Puede haber red y que PokeAPI no responda, por ejemplo si el servidor está caído o muy lento. Por eso hace falta comprobar la disponibilidad real de la API y no solo la presencia de red.

Además, el indicador no debe parpadear cuando la red cambia varias veces seguidas, las comprobaciones no deben gastar el límite de peticiones de la API y el indicador debe ser accesible, sin depender solo del color y con contraste suficiente.

***Decisión***

Creamos la clase ConnectivityMonitor en lib/core/network/, junto al enum ConnectivityStatus con los cuatro estados.

* El paquete connectivity\_plus indica si hay alguna red. Si la hay, se envía a PokeAPI la consulta GraphQL más pequeña posible, { \_\_typename }, con un timeout de 5 segundos. Sin red el estado es Offline, con red y sin respuesta de la API es Servicio no disponible y con ambas es Online.  
    
* Si el ping falla, se repite una vez. Al abrir la app el ping coincide con la primera sincronización y a veces tardaba más de 5 segundos, lo que mostraba un Servicio no disponible falso por un momento.  
    
* Si la red cambia varias veces seguidas, solo se evalúa el último cambio.  
    
* Detecta cuando la API cae o vuelve aunque la red no cambie. No es más frecuente para no gastar el límite de peticiones.  
    
* El coordinador de sincronización avisa al monitor con setSyncing (ADR-005). Si hay conexión y se está sincronizando, el estado es Sincronizando.  
    
* El monitor no emite nada hasta terminar su primera comprobación, para no mostrar Sin conexión por un instante al abrir la app.  
    
* El estado se publica en un Stream únicamente cuando cambia, para no redibujar el indicador sin motivo.

El widget ConnectivityIndicator, en lib/core/widgets/, escucha ese Stream con un StreamBuilder y muestra para cada estado un texto, un icono y un color, así que el estado no depende solo del color. Usa Semantics con liveRegion, para que el lector de pantalla anuncie los cambios, y excludeSemantics, para que no lea dos veces el mismo texto. Los colores son tonos oscuros (verde, rojo y azul 800 y naranja 900\) para alcanzar el contraste que pide WCAG 2.1 AA. Por ahora el indicador está en la barra superior del catálogo.

El comportamiento se verificó en el emulador. Al activar el modo avión el estado pasó de Online a Offline, al desactivarlo volvió a Online después de confirmar con el ping que la API responde, y durante cada descarga de página se mostró Sincronizando.

***Alternativas consideradas***

* Usar solo connectivity\_plus. Se descartó porque solo indica si hay red, no si la API responde, y no permitiría distinguir Offline de Servicio no disponible.  
    
* Hacer ping a otro sitio, como un buscador. Se descartó porque confirma que hay internet, pero no que PokeAPI esté disponible.  
    
* Comprobar la API cada pocos segundos. Detectaría los cambios más rápido, pero gastaría el límite de peticiones de la API sin necesidad.  
    
* Deducir el estado solo de los resultados de la sincronización. No requiere peticiones extra, pero no detectaría que la API volvió mientras el usuario no pida datos nuevos.  
    
* Mostrar el estado con un mensaje temporal (SnackBar). Se descartó porque el proyecto pide un indicador visible en todo momento, no un aviso que desaparece.

***Consecuencias***

*Ventajas*

* Se distingue la falta de red de la caída de la API.  
    
* El indicador no parpadea con cambios rápidos de red ni con un ping lento al abrir la app.  
    
* Se respeta el límite de peticiones de la API.  
    
* El indicador es accesible para lectores de pantalla y no depende solo del color.  
    
* El coordinador y el monitor no se conocen entre sí, así que cada uno se puede cambiar o probar por separado.

*Desventajas*

* Si la API cae o vuelve sin que cambie la red, el indicador puede tardar hasta 2 minutos en reflejarlo.  
    
* Las comprobaciones agregan algunas peticiones a la API.  
    
* Un segundo intento hace que detectar una caída real tarde unos segundos más.  
    
* El indicador está solo en la barra superior del catálogo. Para la entrega final se moverá al layout global, para que se vea en todas las pantallas.  
    
* El estado Servicio no disponible todavía no se ha probado en el emulador. Para la entrega final se agregará una forma de simular la caída de la API.

***ADR-007*****:** *Lectura del catálogo, repositorio y estado de pantalla* 

***Contexto***

La interfaz debe observar solo la base local. Los widgets no pueden acceder a Drift ni a GraphQL, y el dominio no puede depender de la infraestructura. Además, las pantallas necesitan estados explícitos de carga, éxito, vacío y error.

La consulta del catálogo usa un join entre Pokémon, tipos y la tabla que los une, así que devuelve una fila por cada tipo de cada Pokémon. Un Pokémon con dos tipos aparece dos veces.

También hay un problema con el estado vacío. Una lista vacía puede significar tres cosas distintas: la app está descargando por primera vez, la descarga falló, o de verdad no hay datos. Si la pantalla solo mira la lista, las tres se ven igual, y en la primera ejecución saldría «vacío» mientras se descarga.

***Decisión***

AppDatabase solo tiene tablas, versión y conexión. Las consultas del catálogo están en PokemonLocalDataSource, dentro de features/pokemon/data/datasources/local. Así core no importa entidades de una funcionalidad, y la fuente local queda en la capa Data, como en el Diagrama 4\. 

watchCatalog() usa un solo join con leftOuterJoin, ordenado por número de Pokédex y por slot. El leftOuterJoin evita que un Pokémon sin tipos desaparezca. 

El data source agrupa las filas en una lista de PokemonWithTypes en una sola pasada con un Map. Saber que el join repite filas es un detalle de cómo se consulta la base, y esa capa ya conoce Drift. 

Hay dos mappers separados, el de DTOs convierte lo que viene de la API, y el de filas convierte lo que viene de la base. Cada uno conoce un solo formato externo, y ninguno recibe AppDatabase. 

PokemonRepositoryImpl implementa el contrato del dominio y devuelve entidades Pokemon. Recibe el data source local y el coordinador de sincronización por constructor. 

El estado del sync también se observa desde la base. El data source expone watchSyncMetadata(), que lee la tabla sync\_metadata como un Stream. El contrato del dominio tiene watchSyncState(), que devuelve un SyncState (idle, syncing, complete, error). 

SyncState es un enum del dominio, definido en el mismo archivo que el contrato PokemonRepository, porque solo existe para ser lo que devuelve ese método. El repositorio traduce los strings que guarda la base ("syncing", "complete", etc.) a ese enum, así la presentación nunca conoce nombres de columnas ni valores de Drift. 

El data source recibe la clave del recurso por parámetro. El coordinador ya importa al data source, y si el data source importara al coordinador quedaría un import circular. 

El estado de pantalla es CatalogState, una clase sealed con cuatro casos: cargando, éxito, vacío y error. Un provider combina la lista con el SyncState de esta forma:   
Si la lista tiene Pokémon, con cualquier estado del sync, la pantalla muestra la lista.   
Si la lista está vacía y el sync está en idle o syncing, la pantalla muestra Cargando.   
Si la lista está vacía y el sync está en error, la pantalla muestra el error con "Reintentar".   
Si la lista está vacía y el sync está en complete, la pantalla muestra Vacío. 

Con datos locales siempre se muestra la lista, aunque el sync falle. Un error remoto nunca tapa ni borra lo que ya está guardado. 

CatalogPage solo dibuja: recibe el estado y los callbacks onRetry y onLoadMore por parámetro. Solo CatalogScreen conoce Riverpod. 

Riverpod se usa con un provider por pieza (base, data sources, coordinador, repositorio, Streams y estado). El repositorio se expone con el tipo del contrato, no de la clase concreta. 

***Alternativas consideradas***

* Dejar las consultas dentro de AppDatabase. Es más corto, pero obliga a core a importar entidades de una funcionalidad.  
    
* Un mapper que reciba AppDatabase como parámetro. Funciona, pero acopla el mapper a toda la base y lo hace difícil de probar.  
    
* Una consulta por Pokémon para traer sus tipos. Es el problema N+1. Con 20 o más tarjetas se nota.  
    
* Usar AsyncValue directo en la pantalla. Es menos código, pero no tiene un estado vacío, y la rúbrica pide estados modelados explícitamente.  
    
* Que la pantalla use directamente los strings de SyncStatus. El dominio y la presentación quedarían dependiendo de la capa Data. Se prefirió un enum propio del dominio.

***Consecuencias***

*Ventajas*

* La presentación solo ve entidades del dominio y estados propios. Nunca ve Drift, DTOs ni excepciones de red.  
    
* La primera ejecución muestra "cargando" y no "vacío" mientras se descarga, y un fallo con la base vacía muestra el error con "Reintentar".  
    
* Si cambia la forma de la consulta, solo se tocan el data source y su mapper.  
    
* El switch sobre un tipo sealed obliga a cubrir todos los estados.  
    
* Todo lo que ve la pantalla viene de la base local, también el estado del sync

*Desventajas*

Hay más archivos y más piezas que una solución directa. watchCatalog() vuelve a emitir todo el catálogo (unas 1025 filas) cada vez que se escribe una página durante la sincronización. Es aceptable para el avance. Cuando se agreguen búsqueda y filtros, se acotará con where en SQL. 

CatalogState repite parte de lo que ya hace AsyncValue. 

sync\_metadata solo guarda que hubo un error, no de qué tipo. Por eso, con la base vacía, el mensaje de error es genérico. La traducción de excepciones a Failure (timeout, sin red, límite de tasa) sigue pendiente para la entrega final. 

Sin conexión, en una instalación nueva, la pantalla muestra el error con "Reintentar" y no el estado vacío. Explica qué pasó y sugiere una acción, pero no es literalmente el estado vacío. Si se quiere el vacío, es cambiar un caso del provider. 
