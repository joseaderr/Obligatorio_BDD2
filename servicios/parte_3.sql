-- Parte 3: lugares operativos, categoria, propietario y resumen de resenas.
-- Involucra LUGAR, CATEGORIA, CUENTA_PROPIETARIA, CUENTA y RESENA.

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

-- Plan estimado del optimizador para la consulta anterior.
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

Operaciones y relación con algoritmos
TABLE ACCESS BY INDEX ROWID y INDEX FULL SCAN sobre LUGAR: Oracle recorre el índice PK_LUGAR y usa los ROWID para recuperar las filas de la tabla. Luego aplica el filtro l.estado = 'Operativo'. Es un acceso mediante índice, aunque el plan estima recorrer las 15 entradas del índice.
TABLE ACCESS FULL sobre RESENA y SORT JOIN: Oracle lee las 15 filas estimadas de reseñas y las ordena por id_lugar para poder unirlas con los lugares.
MERGE JOIN OUTER entre LUGAR y RESENA: corresponde al algoritmo de combinación por mezcla. Compara ambas entradas ordenadas y, por ser OUTER, conserva los lugares que no tengan reseñas.
HASH JOIN y HASH JOIN OUTER: Oracle usa uniones hash para relacionar lugares con categorías, propietarios y cuentas. Las uniones OUTER conservan lugares aunque no tengan un propietario asociado.
HASH GROUP BY: calcula la cantidad y el promedio de las reseñas por lugar usando una estructura hash para agrupar.
SORT ORDER BY: ordena el resultado final por promedio de puntaje y nombre, según el ORDER BY de la consulta.
TABLE ACCESS FULL en CUENTA_PROPIETARIA y CUENTA: lee esas tablas completas. En este plan son pequeñas —10 y 30 filas estimadas—, por lo que recorrerlas puede ser más conveniente que acceder fila por fila mediante índices.
Comparación con los algoritmos teóricos
El plan refleja los algoritmos estudiados: usa hash join para las uniones, merge join para combinar entradas ordenadas, y hash group by y ordenamiento para agrupar y presentar el resultado. También respeta la semántica de las uniones externas: los lugares sin reseñas o sin propietario no se descartan.

El optimizador mezcla estos métodos según las estadísticas, los índices y el tamaño estimado de las tablas. Por eso el plan no tiene por qué usar un único algoritmo para todas las uniones.

Eficiencia y posibles mejoras
Para el volumen mostrado, los recorridos completos de RESENA, CUENTA_PROPIETARIA y CUENTA parecen razonables: son tablas pequeñas y el costo total estimado del plan es 16, con un tiempo estimado de un segundo. Ese tiempo es una estimación, no una medición real.

Hay una diferencia que conviene analizar: el plan estima 6 filas en el resultado, pero la ejecución de la consulta devolvió 14. Puede deberse a estadísticas desactualizadas o a estimaciones de cardinalidad imprecisas. Conviene actualizar las estadísticas en el entorno de pruebas y comparar las estimaciones con un plan que muestre estadísticas reales de ejecución.

Si RESENA crece considerablemente, se podría probar un índice sobre RESENA(id_lugar), porque ese campo se usa para unir las reseñas con los lugares. Con solo 15 reseñas, el recorrido completo puede seguir siendo más eficiente. Lo adecuado es comparar planes y mediciones con un volumen de datos representativo antes de decidir.

*/
