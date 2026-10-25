# Parte 4 - Ubicación en tiempo real

## Letra

Además de la parte colaborativa, Google Maps incorpora una funcionalidad de ubicación en tiempo real de los vehículos de transporte público.

Las empresas de transporte comparten con la plataforma la posición de sus unidades, lo que permite mostrar en el mapa
dónde está cada vehículo. De cada vehículo se conoce el código interno (único), el tipo ("Autobús", "Tranvía", "Metro" o
"Ferry"), el operador y el modelo. Según el tipo se registran datos adicionales: los autobuses tienen capacidad de pasajeros
y si son de piso bajo, los ferrys tienen capacidad de vehículos, y los tranvías y el metro tienen cantidad de coches.
Una línea de transporte es un servicio identificado por un código y un nombre (por ejemplo, "Línea 42 – Centro /
Aeropuerto"). Un vehículo presta servicio en una línea durante un período determinado (fecha y hora de inicio y de fin). Un
vehículo puede prestar servicio en distintas líneas a lo largo del tiempo y una línea es prestada por distintos vehículos. En
cada momento, un vehículo está asignado a lo sumo a una línea.
Cada vehículo reporta su posición (latitud y longitud) junto con la fecha y hora de la medición, la velocidad y el destino.
Además, puede informar otros datos en ese instante (nivel de ocupación, temperatura interior, estado de las puertas, etc.), y
el conjunto de datos informados varía de un vehículo a otro. Se estima que habrá unos 30.000 vehículos reportando cada 5
segundos.

## Consigna

El subsistema de ubicación en tiempo real debe ser dinámico, permitiendo la incorporación de nuevos
tipos de datos sin generar interrupciones en el funcionamiento y sin la necesidad de modificar la
estructura existente.
Por esta razón, se solicita diseñar el modelo de datos descrito en MongoDB utilizando un máximo de
dos colecciones.

Se pide:
a. Análisis de la solución propuesta, incluyendo los supuestos efectuados, el modelado de las
colecciones identificadas, indicando propósito y campos predefinidos con posibles variaciones
en los atributos (campos opcionales, estructuras anidadas, listas, etc.).
b. Cada colección creada con un schema validator.
c. Se deberán generar datos de prueba que sean coherentes y completos con lo presentado en
la Parte 1.d para poblar el subsistema de ubicación en tiempo real.

## Analisis

De cada vehículo se conoce el código interno (único), el tipo ("Autobús", "Tranvía", "Metro" o
"Ferry"), el operador y el modelo. Según el tipo se registran datos adicionales: los autobuses tienen capacidad de pasajeros
y si son de piso bajo, los ferrys tienen capacidad de vehículos, y los tranvías y el metro tienen cantidad de coches.
Un vehículo presta servicio en una línea durante un período determinado (fecha y hora de inicio y de fin). Un
vehículo puede prestar servicio en distintas líneas a lo largo del tiempo y una línea es prestada por distintos vehículos. En
cada momento, un vehículo está asignado a lo sumo a una línea.
Cada vehículo reporta su posición (latitud y longitud) junto con la fecha y hora de la medición, la velocidad y el destino.
Además, puede informar otros datos en ese instante (nivel de ocupación, temperatura interior, estado de las puertas, etc.), y
el conjunto de datos informados varía de un vehículo a otro. Se estima que habrá unos 30.000 vehículos reportando cada 5
segundos.

Consultas necesarias

Con relación a la realidad modelada en la parte 4, se solicita cumplir con los siguientes
requerimientos:

Requerimiento 5.1
Devolver las coordenadas de la última posición conocida de todos los vehículos de una línea.

Requerimiento 5.2
Obtener los vehículos que se encuentran a menos de 1 km de un punto dado.

Requerimiento 5.3
Devolver el recorrido de un vehículo durante un intervalo de tiempo dado.

Requerimiento 5.4
Mostrar el historial de asignaciones de una línea, con los datos de cada vehículo que la prestó.

### Modelado

Bosquejo del modelo de datos de cada coleccion, no es codigo sino una idea visual de como quedarian, las bases mongo no tienen schema rigido.
Se denormaliza la informacion y enfocamos en estructurarla para que sea operativa a las consultas necesarias.

```JSON
Vehiculos{
    _id: long, //required
    tipo: String ("Autobús", "Tranvía", "Metro" o "Ferry"), //required
    operador: String, //required
    modelo: String, //required
    datosExtra: {
        capacidadPasajeros: int,
        tienePisoBajo: boolean,
        capacidadVehiculos: int,
        cantidadCoches: int
    },
    lineas: [
        {
            codigo: string, // codigo de linea D8 //required
            nombre: string, //required
            fechaDesde: date, //required
            fechaHasta: date | null
        }
    ]
}
```

Coleccion de datos sobre vehiculos, se guardan los datos necesarios sobre el mismo utilizando un historial de lineas y un struct de datos extra donde pueden agregar datos complementarios, el historial de linea se agrega aca ya que no es un dato con un volumen necesario para tener su propia coleccion y la asignacion de lineas es un dato que depende del vehiculo.


```JSON
    reporte {
        _id: ObjectId, //required
        id_vehiculo: long, //required
        linea: string, // codigo de linea L4 //required
        ubicacion: {
            type: "Point",
            coordinates : [double, double]
        },
        fecha: date, //required
        velocidad: double, //required
        destino: string, //required
        extras: {}
    }
```

Coleccion de reporte, aca asociamos el reporte a un vehiculo _(sin FK ya que no existe en mongo)_, la letra nos indica que el reporte de un vehiculo se actualiza cada 5seg, por ende genera un volumen de datos grande como para tener su propia coleccion, ya que consultar todos estos datos dentro de una lista en el vehiculo podria ser poco optimo o lento. leyendo de [documentacion de mongo sobre geolocalizacion](https://www.mongodb.com/es/docs/manual/reference/geojson/#std-label-geospatial-indexes-store-geojson) se decide el schema en ubicacion, y tambien incorporamos un campo extras sin schema definido para que nos puedan mandar datos no esperados.

#### Restricciones e Indices

**Indices**

En cada colleccion vamos a querer un indice para optimizar la busqueda de datos en la base

- Vehiculos
    - _id: Identificador unico, la coleccion ordenada por este podria hacer accesible la busqueda de un vehiculo puntual.
    - linea.codigo: Basandonos en las consultas necesarias se requiere identificar todos los vehiculos de una linea, tenerlos indexados por linea es necesario

- Reporte
    - id_vehiculo, fecha: necesario para agilizar la consulta de todos los reportes de un vehiculo dado en un rango de fecha.
    - linea, fecha: buscamos todos los reportes de la linea X en un rango de fecha.
    - ubicacion: necesario para buscar reportes en un radio de X distancia a la redonda.
