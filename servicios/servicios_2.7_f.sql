
/**************************************************************************************************
 * Requerimiento 2.7 
 * Implementar un servicio que permita a una cuenta indicar que le gustó una reseña, registrando la 
 * fecha en que lo hizo. Al registrarse el “me gusta”, se deben actualizar los puntos acumulados de 
 * la cuenta guía local que escribió la reseña.
 *************************************************************************************************/
CREATE OR REPLACE PROCEDURE MG_RESENA ( 
    pIdCuenta IN CUENTA.ID_CUENTA%TYPE, 
    pIdResena IN RESENA.ID_RESENA%TYPE
) 
AS
	pResultado_select NUMERIC;
	pIdCuentaResena RESENA.ID_RESENA%TYPE;
BEGIN
	/************** VALIDACION DE PARÁMETROS **************/
		SELECT COUNT(*) INTO pResultado_select FROM CUENTA c WHERE c.ID_CUENTA = pIdCuenta;
		IF( pResultado_select = 0 ) THEN 
	        RAISE_APPLICATION_ERROR(-20111, 'Error: El usuario no existe.');
		END IF;

		SELECT COUNT(*) INTO pResultado_select FROM CUENTA c 
		WHERE 
			c.ID_CUENTA = pIdCuenta AND c.ESTADO = 'Suspendida';
		IF( pResultado_select > 0 ) THEN 
	        RAISE_APPLICATION_ERROR(-20112, 'Error: El cuenta se encuentra suspendida.');
		END IF;

		SELECT COUNT(*) INTO pResultado_select FROM RESENA r WHERE r.ID_RESENA = pIdResena;
		IF( pResultado_select = 0 ) THEN 
	        RAISE_APPLICATION_ERROR(-20113, 'Error: La reseña no existe.');
		END IF;
		
		SELECT COUNT(*) INTO pResultado_select FROM RESENA r WHERE r.ID_RESENA = pIdResena;
		IF( pResultado_select = 0 ) THEN 
	        RAISE_APPLICATION_ERROR(-20114, 'Error: La reseña no existe.');
		END IF;
		
		SELECT COUNT(*) INTO pResultado_select FROM RESENA r 
		WHERE 
			r.ID_RESENA = pIdResena AND r.ID_CUENTA = pIdCuenta;
		IF( pResultado_select > 0 ) THEN 
	        RAISE_APPLICATION_ERROR(-20115, 'Error: La reseña pertenece al mismo usuario.');
		END IF;
		
		SELECT COUNT(*) INTO pResultado_select FROM ME_GUSTA m
		WHERE 
			m.ID_CUENTA_MG = pIdCuenta AND m.ID_RESENA = pIdResena;
		IF( pResultado_select > 0 ) THEN 
	        RAISE_APPLICATION_ERROR(-20116, 'Error: El usuario ya indicó que le gusta la reseña.');
		END IF;
	/************** FIN DE VALIDACION DE PARÁMETROS **************/

	SELECT r.ID_CUENTA INTO pIdCuentaResena FROM RESENA r WHERE r.ID_RESENA = pIdResena FOR UPDATE;
	
    INSERT INTO ME_GUSTA m
    (ID_CUENTA_MG, ID_RESENA)
    VALUES
    (pIdCuenta, pIdResena);
	
	ACTUALIZAR_PUNTOS_CUENTA_GUIA( pIdCuentaResena );
	COMMIT;
	
	EXCEPTION
    WHEN OTHERS THEN
        ROLLBACK;
        RAISE;
END MG_RESENA;
