/**************************************************************************************************
 * Requerimiento 2.8 
 * Implementar un servicio que retorne el ranking de las 10 cuentas guía local que más “me gusta” 
 * recibieron en sus reseñas durante los últimos 30 días, dentro de una ciudad determinada. 
 * El servicio debe permitir un parámetro opcional para filtrar por categoría principal del lugar 
 * reseñado. El listado debe incluir el nombre para mostrar de la cuenta, su nivel y la cantidad 
 * de “me gusta” recibidos
 **************************************************************************************************/
CREATE OR REPLACE FUNCTION OBTENER_CURSOR_RANKING_MG(
    pCiudad 			IN VARCHAR2,
    pIdCategoriaPpal	IN NUMERIC DEFAULT NULL
) RETURN SYS_REFCURSOR 
IS
    v_cursor SYS_REFCURSOR;
BEGIN
    OPEN v_cursor FOR
	    SELECT * FROM
		(
			SELECT 
				c.NOMBRE ,
				cg.NIVEL ,
				COUNT( mg.ID_ME_GUSTA ) total_mg,
			    RANK() OVER (ORDER BY COUNT( mg.ID_ME_GUSTA ) DESC, cg.ID_CUENTA ASC ) AS ranking_puntaje
			FROM CUENTA_GUIA_LOCAL cg
			JOIN CUENTA c 		ON c.ID_CUENTA  = cg.ID_CUENTA 
			JOIN RESENA r 		ON r.ID_CUENTA = cg.ID_CUENTA 
			JOIN ME_GUSTA mg 	ON mg.ID_RESENA = r.ID_RESENA
			JOIN LUGAR l 		ON l.ID_LUGAR = r.ID_LUGAR 
			WHERE 
				l.CIUDAD = pCiudad AND
				mg.FECHA >= (CURRENT_DATE - 30) AND
				( pIdCategoriaPpal IS NULL OR l.ID_CATEGORIA_PRINCIPAL = pIdCategoriaPpal )
			GROUP BY 
				cg.ID_CUENTA, c.NOMBRE, cg.NIVEL
		)  t
		WHERE t.ranking_puntaje<=10;           
    RETURN v_cursor;
END OBTENER_CURSOR_RANKING_MG;


DECLARE
    v_ranking       SYS_REFCURSOR;

    v_nombre        VARCHAR2(100);
    v_nivel         NUMBER;
    v_total_likes   NUMBER;
	ranking_puntaje NUMBER;
BEGIN
    -- Obtenemos el cursor invocando la función
    v_ranking := OBTENER_CURSOR_RANKING_MG(pCiudad => 'Montevideo', pIdCategoriaPpal => 4);
    -- Recorremos el cursor fila por fila
    LOOP
        FETCH v_ranking INTO v_nombre, v_nivel, v_total_likes, ranking_puntaje;
        EXIT WHEN v_ranking%NOTFOUND; -- Termina cuando ya no hay más filas
        
        -- Imprimimos el resultado en la consola de salida
        DBMS_OUTPUT.PUT_LINE('Nombre guía: ' || v_nombre || ' | Nivel: ' || v_nivel || ' | cant. MG: ' || v_total_likes || ' | ranking: ' || ranking_puntaje );
    END LOOP;
    
    -- Cerramos el cursor
    CLOSE v_ranking;
END;