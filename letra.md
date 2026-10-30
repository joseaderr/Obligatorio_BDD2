# Google Maps

Google Maps es una plataforma de mapas y navegación en la que la información de los lugares proviene, en gran medida, de las personas que los visitan. Los usuarios reseñan los lugares que conocen, suben fotografías y valoran las reseñas de otros. Sobre esa base colaborativa se construyen las puntuaciones que después ve todo el mundo.

La empresa desea rediseñar la base de datos que soporta la parte colaborativa de la plataforma. A continuación, se describen los distintos subsistemas que deben ser contemplados.

## Cuentas

Para contribuir en la plataforma es necesario registrar una cuenta indicando un correo electrónico que es único, un nombre para mostrar, el país de residencia y el idioma preferido de la interfaz. Interesa registrar la fecha en que se creó la cuenta. Una cuenta puede tener varios teléfonos de contacto. Se debe permitir controlar en qué estado está dicha cuenta, los cuales pueden ser “Activa” o “Suspendida”. Una cuenta suspendida no puede realizar ninguna contribución.

Las cuentas se distinguen según cómo participan en la plataforma. Una cuenta puede comportarse como guía local, como propietaria de un negocio, como ambas cosas a la vez, o como ninguna de las dos en el caso de quienes solo consultan el mapa.

- **Cuentas guía local:** se conoce la fecha en que ingresaron al programa y el nivel alcanzado, que va de 1 a 8. Los puntos acumulados se obtienen a partir de las contribuciones que la cuenta realizó.
- **Cuentas propietarias:** se conoce la razón social, el RUT (valor numérico de doce dígitos), la fecha en que se verificó la titularidad y el método de verificación empleado, que puede ser “Postal”, “Telefónico” o “Video”.

Es habitual que una persona que administra su propio negocio sea además guía local activa y las políticas de la plataforma lo permiten expresamente.

## Lugares

El mapa se organiza alrededor de los lugares. De cada lugar se registra un identificador, un nombre, la dirección (compuesta por calle, número, ciudad y país), la latitud y la longitud, y los teléfonos y sitios web de contacto, que pueden ser varios. El lugar tiene un estado que puede ser “Operativo”, “Cerrado temporalmente” o “Cerrado definitivamente”. La puntuación media del lugar se obtiene a partir de las reseñas que recibió.

Un lugar puede estar contenido dentro de otro lugar. Un local está dentro de un centro comercial, un centro comercial está dentro de un complejo, y así sucesivamente. Un lugar contenedor puede albergar muchos lugares, mientras que un lugar contenido pertenece a lo sumo a un contenedor. Ningún lugar puede estar contenido dentro de sí mismo.

Las cuentas propietarias verificadas administran los lugares que les pertenecen. Interesa conocer la fecha en la que comenzó dicha administración. Un lugar puede no tener ninguna cuenta propietaria que lo administre, de hecho, la mayoría de los lugares del mapa no la tiene.

## Categorías

De cada categoría se registra un identificador, un nombre que no se repite y una descripción. Todo lugar pertenece a exactamente una categoría principal, que es la que determina cómo se lo representa en el mapa. Una misma categoría puede ser principal de muchos lugares y secundaria de muchos otros.

Además de la principal, un lugar puede declarar varias categorías secundarias, que sirven para que aparezca en más búsquedas. Por ejemplo: un restaurante puede declararse también como bar y como salón de eventos.

## Horarios

Los lugares operativos publican sus horarios de atención. Los horarios se registran por día de la semana, y se conoce la hora de apertura y la hora de cierre, que debe ser posterior a la de apertura. Un horario no tiene existencia propia: se define siempre dentro de un lugar determinado y desaparece junto con él.

## Fotografías

Las cuentas pueden subir fotografías de los lugares que visitan. Las fotografías se numeran correlativamente dentro del lugar al que corresponden y no tienen sentido fuera de él. De cada una se registra la fecha en que fue tomada, la fecha en que se subió y una descripción opcional.

Interesa saber qué cuenta subió cada fotografía. Las fotografías se conservan, aunque la cuenta que las subió elimine su reseña del lugar.

## Reseñas

El corazón de la plataforma son las reseñas. Una cuenta reseña un lugar que conoce, y de esa reseña se registra el puntaje otorgado —un valor entero de 1 a 5—, el texto, la fecha en que se publicó y el idioma en que fue escrita. Una cuenta no puede reseñar dos veces el mismo lugar: si vuelve sobre su opinión, la reseña anterior se reemplaza y se conserva únicamente la última. Un lugar cerrado definitivamente no admite nuevas reseñas, y ninguna cuenta puede publicar más de cinco reseñas en un mismo día.

La reseña queda registrada desde el momento en que se publica y permanece en el sistema con independencia de que alguien la lea o interactúe con ella alguna vez. Es la unidad sobre la que se construye todo lo que sigue. Si una cuenta es suspendida, sus reseñas se conservan, pero dejan de computarse en la puntuación media de los lugares.

Sobre una reseña ya publicada, otras cuentas pueden indicar que les gustó. Interesa registrar qué cuenta le dio “me gusta” a cada reseña y en qué fecha lo hizo. Una reseña puede acumular muchos “me gusta” a lo largo del tiempo o no recibir ninguno, y una misma cuenta puede dar “me gusta” a reseñas de muchos lugares distintos, pero no puede darle “me gusta” dos veces a la misma reseña ni dárselo a una reseña propia.

Por política de la empresa, el “me gusta” recae siempre sobre la opinión de una cuenta acerca de un lugar concreto, y no sobre la cuenta que la escribió ni sobre el lugar por separado: que una reseña de un usuario sobre un restaurante haya recibido “me gusta” no dice nada sobre las demás reseñas de ese mismo usuario ni sobre las demás reseñas de dicho restaurante.

La cantidad de “me gusta” recibidos es uno de los insumos con los que se calculan los puntos de las cuentas guía local.

La cuenta propietaria que administra un lugar puede responder las reseñas que este recibe. De cada respuesta se registra un identificador, el texto y la fecha en que se publicó, que debe ser posterior a la fecha de la reseña. Una reseña admite a lo sumo una respuesta, y una respuesta corresponde siempre a una única reseña. Interesa saber qué cuenta publicó cada respuesta, dado que la titularidad de un lugar puede cambiar con el tiempo. Solo la cuenta propietaria que administra el lugar puede responder las reseñas de ese lugar.

## Ubicación en tiempo real

Además de la parte colaborativa, Google Maps incorpora una funcionalidad de ubicación en tiempo real de los vehículos de transporte público.

Las empresas de transporte comparten con la plataforma la posición de sus unidades, lo que permite mostrar en el mapa dónde está cada vehículo. De cada vehículo se conoce el código interno (único), el tipo (“Autobús”, “Tranvía”, “Metro” o “Ferry”), el operador y el modelo. Según el tipo se registran datos adicionales: los autobuses tienen capacidad de pasajeros y si son de piso bajo, los ferrys tienen capacidad de vehículos, y los tranvías y el metro tienen cantidad de coches.

Una línea de transporte es un servicio identificado por un código y un nombre (por ejemplo, “Línea 42 – Centro / Aeropuerto”). Un vehículo presta servicio en una línea durante un período determinado (fecha y hora de inicio y de fin). Un vehículo puede prestar servicio en distintas líneas a lo largo del tiempo y una línea es prestada por distintos vehículos. En cada momento, un vehículo está asignado a lo sumo a una línea.

Cada vehículo reporta su posición (latitud y longitud) junto con la fecha y hora de la medición, la velocidad y el destino. Además, puede informar otros datos en ese instante (nivel de ocupación, temperatura interior, estado de las puertas, etc.), y el conjunto de datos informados varía de un vehículo a otro. Se estima que habrá unos 30.000 vehículos reportando cada 5 segundos.
