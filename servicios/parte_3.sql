-- Parte 3: lugares operativos, categoria, propietario y resumen de resenas.
-- Involucra LUGAR, CATEGORIA, CUENTA_PROPIETARIA, CUENTA y RESENA.
-- Muestra cada lugar operativo con su categoria y propietario, y calcula la cantidad y el puntaje promedio de sus reseñas.
-- Incluye lugares sin reseñas o sin propietario asignado; ordena por promedio de puntaje descendente y nombre.
-- Usa NVL para reemplazar valores NULL por textos descriptivos o por 0 cuando no hay puntajes para calcular el promedio.

SELECT
    l.id_lugar,
    l.nombre AS lugar,
    c.nombre AS categoria,
    NVL(cp.razon_social, 'Sin propietario asignado') AS propietario,
    NVL(cu.nombre, 'N/D') AS cuenta_propietaria,
    COUNT(r.id_resena) AS cantidad_resenas,
    NVL(ROUND(AVG(r.puntaje), 2), 0) AS promedio_puntaje
FROM LUGAR l
JOIN CATEGORIA c
    ON c.id_categoria = l.id_categoria_principal
LEFT JOIN CUENTA_PROPIETARIA cp
    ON cp.id_cuenta = l.id_cuenta_admin
LEFT JOIN CUENTA cu
    ON cu.id_cuenta = cp.id_cuenta
LEFT JOIN RESENA r
    ON r.id_lugar = l.id_lugar
WHERE l.estado = 'Operativo'
GROUP BY
    l.id_lugar,
    l.nombre,
    c.nombre,
    cp.razon_social,
    cu.nombre
ORDER BY
    NVL(AVG(r.puntaje), 0) DESC,
    l.nombre;

-- Obtener plan estimado del optimizador para la consulta anterior:
EXPLAIN PLAN FOR
SELECT
    l.id_lugar,
    l.nombre AS lugar,
    c.nombre AS categoria,
    NVL(cp.razon_social, 'Sin propietario asignado') AS propietario,
    NVL(cu.nombre, 'N/D') AS cuenta_propietaria,
    COUNT(r.id_resena) AS cantidad_resenas,
    NVL(ROUND(AVG(r.puntaje), 2), 0) AS promedio_puntaje
FROM LUGAR l
JOIN CATEGORIA c
    ON c.id_categoria = l.id_categoria_principal
LEFT JOIN CUENTA_PROPIETARIA cp
    ON cp.id_cuenta = l.id_cuenta_admin
LEFT JOIN CUENTA cu
    ON cu.id_cuenta = cp.id_cuenta
LEFT JOIN RESENA r
    ON r.id_lugar = l.id_lugar
WHERE l.estado = 'Operativo'
GROUP BY
    l.id_lugar,
    l.nombre,
    c.nombre,
    cp.razon_social,
    cu.nombre
ORDER BY
    NVL(AVG(r.puntaje), 0) DESC,
    l.nombre;

SELECT *
FROM TABLE(DBMS_XPLAN.DISPLAY(NULL, NULL, 'TYPICAL'));

/*
 ID_LUGAR LUGAR                                                                                                                                                  CATEGORIA                                                                                            PROPIETARIO                                                                                                                                                                                              CUENTA_PROPIETARIA                                                                                                                                     CANTIDAD_RESENAS PROMEDIO_PUNTAJE
---------- ------------------------------------------------------------------------------------------------------------------------------------------------------ ---------------------------------------------------------------------------------------------------- -------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- ------------------------------------------------------------------------------------------------------------------------------------------------------ ---------------- ----------------
        12 Boutique Exclusiva                                                                                                                                     Centro Comercial                                                                                     Boutique y Moda Mendoza S.A.S.                                                                                                                                                                           Andrés Mendoza                                                                                                                                                        1                5
         3 Café de la Esquina                                                                                                                                     Cafetería                                                                                            Comercializadora de Café Díaz Ltda                                                                                                                                                                       Roberto Díaz                                                                                                                                                          1                5
         8 Librería Cultura Viva                                                                                                                                  Librería                                                                                             Librerías y Cultura Rojas EIRL                                                                                                                                                                           Manuel Rojas                                                                                                                                                          1                5
         6 Museo del Prado                                                                                                                                        Museo                                                                                                Servicios Turísticos Sánchez SL                                                                                                                                                                          Hugo Sánchez                                                                                                                                                          1                5
         5 Pizzería Bella Italia                                                                                                                                  Restaurante                                                                                          Restaurantes Morales Spa                                                                                                                                                                                 Ricardo Morales                                                                                                                                                       1                5
         1 Mall Costanera Center                                                                                                                                  Centro Comercial                                                                                     Sin propietario asignado                                                                                                                                                                                 N/D                                                                                                                                                                   2              4,5
         2 Restaurante Giratorio                                                                                                                                  Restaurante                                                                                          Inversiones Gastronómicas Soto EIRL                                                                                                                                                                      Pedro Soto                                                                                                                                                            2              4,5
         9 Bar El Callejón                                                                                                                                        Bar                                                                                                  Entretenimiento Mexicano SA de CV                                                                                                                                                                        Fernando Herrera                                                                                                                                                      1                4
        14 Café Literario Retiro                                                                                                                                  Cafetería                                                                                            Sin propietario asignado                                                                                                                                                                                 N/D                                                                                                                                                                   1                4
        10 Clínica Las Condes Médica                                                                                                                              Centro Médico                                                                                        Centro Médico Miranda Ltda                                                                                                                                                                               Jorge Miranda                                                                                                                                                         1                4
         7 Parque del Retiro                                                                                                                                      Parque                                                                                               Sin propietario asignado                                                                                                                                                                                 N/D                                                                                                                                                                   1                4

  ID_LUGAR LUGAR                                                                                                                                                  CATEGORIA                                                                                            PROPIETARIO                                                                                                                                                                                              CUENTA_PROPIETARIA                                                                                                                                     CANTIDAD_RESENAS PROMEDIO_PUNTAJE
---------- ------------------------------------------------------------------------------------------------------------------------------------------------------ ---------------------------------------------------------------------------------------------------- -------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- ------------------------------------------------------------------------------------------------------------------------------------------------------ ---------------- ----------------
         4 Hotel Plaza Central                                                                                                                                    Hotel                                                                                                Hotelería y Turismo López S.A.S.                                                                                                                                                                         Javier López                                                                                                                                                          1                3
        11 SmartFit Gimnasio                                                                                                                                      Gimnasio                                                                                             Gimnasios e Infraestructura Salas Spa                                                                                                                                                                    Marcelo Salas                                                                                                                                                         1                3
        21 Café Central                                                                                                                                           Restaurante                                                                                          Sin propietario asignado                                                                                                                                                                                 N/D                                                                                                                                                                   0                0

14 filas seleccionadas.


Explicado.


PLAN_TABLE_OUTPUT
---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
Plan hash value: 2707003092

---------------------------------------------------------------------------------------------------------
| Id  | Operation                         | Name                | Rows  | Bytes | Cost (%CPU)| Time     |
---------------------------------------------------------------------------------------------------------
|   0 | SELECT STATEMENT                  |                     |     6 |   714 |    16  (19)| 00:00:01 |
|   1 |  SORT ORDER BY                    |                     |     6 |   714 |    16  (19)| 00:00:01 |
|   2 |   HASH GROUP BY                   |                     |     6 |   714 |    16  (19)| 00:00:01 |
|*  3 |    HASH JOIN OUTER                |                     |     6 |   714 |    14   (8)| 00:00:01 |
|*  4 |     HASH JOIN OUTER               |                     |     6 |   606 |    11  (10)| 00:00:01 |
|*  5 |      HASH JOIN                    |                     |     6 |   384 |     8  (13)| 00:00:01 |

PLAN_TABLE_OUTPUT
---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
|   6 |       MERGE JOIN OUTER            |                     |     6 |   306 |     6  (17)| 00:00:01 |
|*  7 |        TABLE ACCESS BY INDEX ROWID| LUGAR               |     5 |   210 |     2   (0)| 00:00:01 |
|   8 |         INDEX FULL SCAN           | PK_LUGAR            |    15 |       |     1   (0)| 00:00:01 |
|*  9 |        SORT JOIN                  |                     |    15 |   135 |     4  (25)| 00:00:01 |
|  10 |         TABLE ACCESS FULL         | RESENA              |    15 |   135 |     3   (0)| 00:00:01 |
|  11 |       VIEW                        | index$_join$_002    |    10 |   130 |     2   (0)| 00:00:01 |
|* 12 |        HASH JOIN                  |                     |       |       |            |          |
|  13 |         INDEX FAST FULL SCAN      | PK_CATEGORIA        |    10 |   130 |     1   (0)| 00:00:01 |
|  14 |         INDEX FAST FULL SCAN      | UQ_CATEGORIA_NOMBRE |    10 |   130 |     1   (0)| 00:00:01 |
|  15 |      TABLE ACCESS FULL            | CUENTA_PROPIETARIA  |    10 |   370 |     3   (0)| 00:00:01 |
|  16 |     TABLE ACCESS FULL             | CUENTA              |    30 |   540 |     3   (0)| 00:00:01 |

PLAN_TABLE_OUTPUT
---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
---------------------------------------------------------------------------------------------------------

Predicate Information (identified by operation id):
---------------------------------------------------

   3 - access("CU"."ID_CUENTA"(+)="CP"."ID_CUENTA")
   4 - access("CP"."ID_CUENTA"(+)="L"."ID_CUENTA_ADMIN")
   5 - access("C"."ID_CATEGORIA"="L"."ID_CATEGORIA_PRINCIPAL")
   7 - filter("L"."ESTADO"='Operativo')
   9 - access("R"."ID_LUGAR"(+)="L"."ID_LUGAR")
       filter("R"."ID_LUGAR"(+)="L"."ID_LUGAR")

PLAN_TABLE_OUTPUT
---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
  12 - access(ROWID=ROWID)

Note
-----
   - this is an adaptive plan
Parte A -
Operaciones y relación con algoritmos
TABLE ACCESS BY INDEX ROWID y INDEX FULL SCAN sobre LUGAR: Oracle recorre el índice PK_LUGAR y usa los ROWID para
recuperar las filas de la tabla. Luego aplica el filtro l.estado = 'Operativo'. Es un acceso mediante índice,
aunque el plan estima recorrer las 15 entradas del índice.
Selección (σ): la condición WHERE l.estado = 'Operativo' selecciona los lugares operativos. En este plan se aplica
como filtro sobre las filas obtenidas de LUGAR; no es un TABLE ACCESS FULL de LUGAR, sino un acceso por índice seguido del filtro.

TABLE ACCESS FULL sobre RESENA y SORT JOIN: Oracle lee las 15 filas estimadas de reseñas y las ordena por id_lugar para poder
unirlas con los lugares. El full scan lee la tabla completa; la condición de unión por id_lugar se aplica al combinar las filas,
 no hay una selección WHERE independiente sobre RESENA.

MERGE JOIN OUTER entre LUGAR y RESENA: corresponde al algoritmo de combinación por mezcla.
Compara ambas entradas ordenadas y, por ser OUTER, conserva los lugares que no tengan reseñas.

HASH JOIN y HASH JOIN OUTER: Oracle usa uniones hash para relacionar lugares con categorías,
propietarios y cuentas. Las uniones OUTER conservan lugares aunque no tengan un propietario asociado.

HASH GROUP BY: calcula la cantidad y el promedio de las reseñas por lugar usando una estructura hash para agrupar.

SORT ORDER BY: ordena el resultado final por promedio de puntaje y nombre, según el ORDER BY de la consulta.

TABLE ACCESS FULL en CUENTA_PROPIETARIA y CUENTA: lee esas tablas completas. En este plan son pequeñas —10 y 30 filas estimadas—, por lo que recorrerlas puede ser más conveniente que acceder fila por fila mediante índices. No se aplica una selección WHERE específica sobre ellas; se usan las condiciones de unión para relacionar sus filas con las demás tablas.
Comparación con los algoritmos teóricos

Entre los algoritmos vistos en el curso, el plan refleja:

- **Búsqueda full scan:** `TABLE ACCESS FULL` recorre las tablas RESENA, CUENTA_PROPIETARIA y CUENTA.
- **Index scan:** `INDEX FULL SCAN` recorre las entradas de PK_LUGAR; `INDEX FAST FULL SCAN` recorre los índices de CATEGORIA.
- **Index join:** la vista interna `index$_join$_002` combina índices de CATEGORIA para obtener los datos requeridos.
- **Merge sort:** `SORT JOIN` ordena las filas antes del `MERGE JOIN OUTER`, que combina las entradas ordenadas.
- **Hash join:** el plan contiene operaciones `HASH JOIN` y `HASH JOIN OUTER`. No indica si son hash join recursivos o no recursivos.

No se observa **nested loops** en este plan.

Parte B:

El plan presenta similitudes con la optimización estudiada en el curso, tanto por costos como por heurísticas. Desde el
enfoque por costos, Oracle estima la cantidad de filas, los bloques y el costo de las alternativas, y elige una combinación
de accesos y uniones. Por ejemplo, se observan recorridos completos de tablas pequeñas con costo estimado 3, mientras que
el acceso a LUGAR combina un INDEX FULL SCAN (costo 1) y TABLE ACCESS BY INDEX ROWID (costo 2). El costo estimado total
del plan es 16. Los costos de cada operación representan estimaciones del trabajo de esa operación y su subplan; no deben
sumarse entre sí ni interpretarse como tiempos reales.

También se observa una heurística de aplicar la selección lo antes posible: el filtro sobre LUGAR aparece en la operación
7, antes de las uniones posteriores, reduciendo las filas estimadas de 15 a 5. El plan organiza las uniones en una secuencia
y utiliza distintos algoritmos —merge join y hash join— en lugar de aplicar uno solo a todas las relaciones. Esto es
coherente con elegir el orden y método de unión según las estimaciones, aunque las uniones externas también condicionan
qué reordenamientos son válidos.

Las estimaciones no coinciden completamente con la ejecución: el plan calcula 6 filas para el resultado, mientras que la
consulta devolvió 14. Esto muestra que la elección basada en costos depende de la precisión de las estadísticas y de las
estimaciones de cardinalidad; por lo tanto, el costo 16 sirve para comparar alternativas del optimizador, no garantiza el
tiempo efectivo de ejecución.

Parte C - Eficiencia de la consulta y posibles mejoras

Con los datos actuales, la eficiencia de la consulta es adecuada: las tablas son pequeñas y los TABLE ACCESS FULL sobre
RESENA, CUENTA_PROPIETARIA y CUENTA pueden ser convenientes. El plan estima un costo de 16, aunque esto no sustituye una
medición del tiempo real. Si las tablas aumentaran considerablemente y recorrerlas completas se volviera costoso, se
podrían evaluar índices en las columnas usadas para las uniones, especialmente RESENA(id_lugar). También podría evaluarse
un índice sobre LUGAR(estado) si el valor 'Operativo' seleccionara una proporción reducida de filas. El optimizador
elegiría el índice cuando permita encontrar las filas requeridas con menos trabajo; si muchas filas cumplen la condición,
puede ser más eficiente leer la tabla completa de una vez.

*/
