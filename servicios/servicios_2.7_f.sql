
/**************************************************************************************************
 * Requerimiento 2.7 
 * Implementar un servicio que permita a una cuenta indicar que le gustó una reseña, registrando la 
 * fecha en que lo hizo. Al registrarse el “me gusta”, se deben actualizar los puntos acumulados de 
 * la cuenta guía local que escribió la reseña.
 *************************************************************************************************/
CREATE OR REPLACE PROCEDURE MG_RESENA ( 
    pIdCuenta IN NUMBER, 
    pIdResena IN NUMBER
) 
AS
	pResultado_select NUMERIC;
	pIdCuentaResena NUMERIC;
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

	SELECT r.ID_CUENTA INTO pIdCuentaResena FROM RESENA r WHERE r.ID_RESENA = pIdResena;
		
    INSERT INTO ME_GUSTA m
    (ID_CUENTA_MG, ID_RESENA)
    VALUES
    (pIdCuenta, pIdResena);
	
	ACTUALIZAR_PUNTOS_CUENTA_GUIA( pIdCuentaResena );		
END;

/**********************************************************************
 * Actualiza los puntos de la cuenta guía ingresada como parámetro
 * Si la cuenta ingresada es cuenta común pero no cuenta guía, crea
 * una cuenta guía y actualiza los puntos.
 * Se definen los parámetros, que definen el valor en puntos asociado a 
 * cada me gusta y cada reseña
 * 		*pMultiplicadorPuntosMeGusta
 * 		*pMultiplicadorPuntosReseña
 **********************************************************************/
CREATE OR REPLACE PROCEDURE ACTUALIZAR_PUNTOS_CUENTA_GUIA ( 
    pIdCuenta IN NUMBER
) 
AS
	pMultiplicadorPuntosMeGusta NUMERIC DEFAULT 1;
	pMultiplicadorPuntosReseña NUMERIC DEFAULT 2;
	pResultado_select NUMERIC;
	pPuntos_generados NUMERIC DEFAULT 0;
	pCuenta_es_guia_local NUMERIC;
BEGIN
	SELECT COUNT(*) INTO pResultado_select  FROM CUENTA c WHERE c.ID_CUENTA = pIdCuenta;
	IF( pResultado_select = 0 ) THEN 
        RAISE_APPLICATION_ERROR(-21001, 'Error: El usuario no existe.');
	END IF;

	SELECT 
		COUNT( DISTINCT r.ID_RESENA ) * pMultiplicadorPuntosReseña + 
		COUNT( DISTINCT m.ID_ME_GUSTA ) * pMultiplicadorPuntosMeGusta
			INTO pPuntos_generados 
	FROM CUENTA c
	LEFT JOIN RESENA r ON r.ID_CUENTA=c.ID_CUENTA
	LEFT JOIN ME_GUSTA m ON m.ID_RESENA=r.ID_RESENA
	WHERE 
		r.ID_CUENTA = pIdCuenta;

	SELECT COUNT(*) INTO pCuenta_es_guia_local FROM CUENTA_GUIA_LOCAL c WHERE c.ID_CUENTA = pIdCuenta;

	IF( pPuntos_generados>0 AND pCuenta_es_guia_local=0 ) THEN
		INSERT INTO CUENTA_GUIA_LOCAL
		(ID_CUENTA)
		VALUES (pIdCuenta);
	END IF;

	IF( pPuntos_generados>0 ) THEN
		UPDATE CUENTA_GUIA_LOCAL c SET PUNTOS = pPuntos_generados WHERE c.ID_CUENTA = pIdCuenta;
	END IF;
END;
