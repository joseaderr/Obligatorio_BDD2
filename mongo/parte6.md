# Parte 6 - Preguntas sobre el diseño en MongoDB

## Letra

Después de haber diseñado el modelo de datos en MongoDB, responder las siguientes preguntas:

- ¿Cómo aplicaron los conceptos vistos en el curso en su diseño? Mencionar ejemplos específicos.
- Considerando los conceptos vistos en el curso, comentar las ventajas y desventajas de haber utilizado MongoDB en este subsistema. ¿Encuentran algún subsistema o caso de uso del obligatorio que se hubiese visto beneficiado por usar este tipo de base de datos?

Para realizar esta parte se pide un video de máximo 3 minutos en el cual se explique brevemente el modelado de datos de la Parte 4 y se respondan las preguntas de la Parte 6. En el video deben participar la totalidad de los integrantes del equipo.

## 1. ¿Cómo aplicamos los conceptos del curso?

**Modelado según las consultas, no según las entidades.** Partimos de los requerimientos 5.1 a 5.4 y de la carga estimada (30.000 vehículos reportando cada 5 segundos). De ahí salió la estructura, y por eso quedaron dos colecciones y no una por entidad.

**Embeber y referenciar según volumen y ciclo de vida.**
- El historial de líneas de un vehículo va **embebido** en `vehiculos.lineas`. Son pocos datos, dependen del vehículo y siempre se leen junto con él.
- Las mediciones van en una colección **aparte**, `reportes`. Un arreglo de mediciones dentro del vehículo crecería sin límite y haría los documentos enormes y lentos.
- Los reportes referencian al vehículo con `id_vehiculo`. Es una referencia manual, porque Mongo no tiene claves foráneas.

**Desnormalización.** Cada reporte guarda `linea`. Así el requerimiento 5.1 filtra los reportes por línea sin hacer `$lookup`. Se duplica un dato a cambio de una lectura más simple y rápida.

**Esquema flexible con validación (schema validator).**
- `reportes` usa `additionalProperties: true`. Un vehículo puede enviar `ocupacion`, `temperaturaInterior`, `puertasAbiertas` o un campo nuevo sin migrar nada. Eso cumple el requisito de incorporar datos sin interrumpir el servicio ni modificar la estructura.
- Los campos fijos (`id_vehiculo`, `linea`, `ubicacion`, `fecha`, `velocidad`, `destino`) son obligatorios y tienen tipo y rango.

**Polimorfismo.** `datosExtra` cambia según el tipo de vehículo y el validator lo exige con `oneOf`:
- Autobús: `capacidadPasajeros` y `tienePisoBajo`.
- Ferry: `capacidadVehiculos`.
- Tranvía y Metro: `cantidadCoches`.

**Reglas de negocio en el validator.** Con `$expr` se controla que `fechaHasta` sea posterior a `fechaDesde` y que un vehículo tenga como máximo una asignación abierta. Eso refleja la regla "en cada momento, un vehículo está asignado a lo sumo a una línea".

**Índices pensados para cada consulta.**

| Requerimiento | Índice |
|---|---|
| 5.1 Última posición por línea | `(linea, fecha)` |
| 5.2 Vehículos a menos de 1 km | `2dsphere` sobre `ubicacion` |
| 5.3 Recorrido en un intervalo | `(id_vehiculo, fecha)` |
| 5.4 Historial de una línea | `lineas.codigo` |

Con `explain` se comprobó que el 5.3 usa su índice.

**Datos geoespaciales.** `ubicacion` es un GeoJSON `Point` con `[longitud, latitud]`. Las consultas usan `$geoNear` y el pipeline de agregación (`$match`, `$sort`, `$group`, `$lookup`).

## 2. Ventajas y desventajas de MongoDB en este subsistema

### Ventajas

- **Esquema flexible.** Cada vehículo informa datos distintos y pueden aparecer tipos nuevos. En SQL habría que usar muchas columnas nulas, una tabla clave-valor o `ALTER TABLE` constantes.
- **Escrituras de alto volumen.** Los reportes son inserciones independientes (unos 6.000 por segundo) que no necesitan joins ni transacciones entre sí. Mongo escala en horizontal con sharding. No lo implementamos, pero una clave como `id_vehiculo` o la fecha sería natural.
- **Lecturas simples.** Un documento trae todo lo que se pregunta de una medición, sin joins.
- **Soporte geoespacial nativo**, con índice `2dsphere` y consultas de proximidad.

### Desventajas

- **Integridad débil.** No hay claves foráneas. Nada impide un reporte con un `id_vehiculo` que no existe, ni que la `linea` del reporte no coincida con la asignación vigente del vehículo. Esas reglas dependen de la aplicación.
- **Duplicación.** El `nombre` de la línea se repite en cada vehículo que la prestó, y `linea` se repite en cada reporte. Cambiar un nombre implica actualizar muchos documentos. Con el límite de dos colecciones no pudimos tener un catálogo de líneas.
- **Consultas entre colecciones más incómodas.** El 5.4 necesita `$unwind` y la variante del 5.1 que parte de `vehiculos` necesita `$lookup`. En SQL serían joins directos.
- **Validaciones limitadas.** Las reglas entre documentos distintos no se pueden expresar en el validator.

## 3. ¿Algún subsistema del obligatorio que se beneficiaría de MongoDB?

### Se beneficiarían: Lugares y Cuentas

- **Lugares.** Los horarios "no tienen existencia propia y desaparecen junto con el lugar", lo que es un subdocumento embebido casi por definición. Los teléfonos y sitios web múltiples, la dirección compuesta y las categorías secundarias también encajan como arreglos y objetos anidados. Un lugar se lee casi siempre completo, con todo eso a la vez.
- **Cuentas.** Hay roles que se superponen (guía local, propietaria, ambas o ninguna), cada uno con datos distintos, y teléfonos múltiples. En un documento, los datos de guía local o de propietaria son subdocumentos opcionales.
- **Fotografías.** Se numeran dentro del lugar y no tienen sentido fuera de él, por lo que podrían embeberse. Pueden crecer mucho, así que habría que evaluarlo.

### No se beneficiarían: Reseñas, "me gusta" y respuestas

Tienen reglas de integridad fuertes, y eso favorece el modelo relacional:

- Una reseña por cuenta y lugar.
- Máximo de 5 reseñas por día por cuenta.
- No se puede reseñar un lugar cerrado definitivamente.
- No se puede dar "me gusta" a la propia reseña.
- Las reseñas de cuentas suspendidas dejan de contar en la puntuación media.

Todo eso se resuelve mejor con claves, restricciones y transacciones.
