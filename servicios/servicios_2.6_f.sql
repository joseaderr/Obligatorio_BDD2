/**************************************************************************************************
 * Requerimiento 2.6 
 * Implementar un servicio que permita a una cuenta propietaria responder una reseña recibida por 
 * un lugar que administra. 
 **************************************************************************************************/
CREATE OR REPLACE PROCEDURE RESPONDER_RESENA ( 
    pIdResena IN NUMBER, 
    pIdPropietario IN NUMBER, 
    pRespuesta IN VARCHAR2 -- Cambiado estrictamente a VARCHAR2
) 
AS
	resultado_select NUMERIC;	
BEGIN
	/************** VALIDACION DE PARÁMETROS **************/
		SELECT COUNT(*) INTO resultado_select FROM CUENTA_PROPIETARIA c WHERE c.ID_CUENTA = pIdPropietario;
		IF( resultado_select = 0 ) THEN 
	        RAISE_APPLICATION_ERROR(-20101, 'Error: El usuario no existe o no es propietario.');
		END IF;

		SELECT COUNT(*) INTO resultado_select FROM CUENTA c 
		WHERE 
			c.ID_CUENTA = pIdPropietario AND
			c.ESTADO != 'Suspendida';
		IF( resultado_select = 0 ) THEN 
	        RAISE_APPLICATION_ERROR(-20102, 'Error: El cuenta se encuentra suspendida.');
		END IF;
	
		SELECT COUNT(*) INTO resultado_select 
		FROM RESENA r
		WHERE r.ID_RESENA = pIdResena;
		IF( resultado_select=0 ) THEN 
	        RAISE_APPLICATION_ERROR(-20103, 'Error: La reseña no existe.');
		END IF;
		
	    SELECT COUNT(*) INTO resultado_select 
		FROM RESENA r
		JOIN LUGAR l ON l.ID_LUGAR = r.ID_LUGAR
		WHERE 
			l.ID_CUENTA_ADMIN = pIdPropietario AND 
			r.ID_RESENA = pIdResena;
		IF( resultado_select=0 ) THEN
	        RAISE_APPLICATION_ERROR(-20104, 'Error: El usuario no administra el lugar de la reseña especificada.');
	    END IF;
	    
	    SELECT COUNT(*) INTO resultado_select 
		FROM RESENA r
		JOIN LUGAR l ON l.ID_LUGAR = r.ID_LUGAR
		WHERE 
			l.ID_CUENTA_ADMIN = pIdPropietario AND 
			r.ID_RESENA = pIdResena;
		IF( resultado_select=0 ) THEN
	        RAISE_APPLICATION_ERROR(-20105, 'Error: El usuario no administra el lugar de la reseña especificada.');
	    END IF;
	    
	    SELECT COUNT(*) INTO resultado_select 
		FROM RESENA rese
		JOIN RESPUESTA resp ON rese.ID_RESENA = resp.ID_RESENA
		WHERE rese.ID_RESENA = pIdResena;
	    IF( resultado_select!=0 ) THEN
	    	RAISE_APPLICATION_ERROR(-20106, 'Error: Ya existe una respuesta de la respuesta especificada.');
	    END IF;
	    
	    SELECT COUNT(*) INTO resultado_select 
		FROM RESENA r
		JOIN LUGAR l ON l.ID_LUGAR = r.ID_LUGAR
		WHERE 
			l.ESTADO = 'Cerrado definitivamente';
		IF( resultado_select=0 ) THEN
	        RAISE_APPLICATION_ERROR(-20107, 'Error: No se puede responder una reseña sobre un lugar Cerrado definitivamente.');
	    END IF;
	/************** FIN DE VALIDACION DE PARÁMETROS **************/
    
    INSERT INTO RESPUESTA ( ID_RESENA, ID_CUENTA_PROP, TEXTO ) VALUES ( pIdResena, pIdPropietario, pRespuesta );
END;

BEGIN
	RESPONDER_RESENA( 1, 15, 'Restpueatdasd');
END;


SELECT *
FROM USER_ERRORS 
WHERE name = 'RESPONDER_RESENA' 
  AND type = 'PROCEDURE'
ORDER BY sequence;
