
-- Funcion auxiliar para centralizar la logica de calculo puntos de una cuenta.
CREATE OR REPLACE FUNCTION fn_calcular_puntos_lugar(id_lugar LUGAR.ID_LUGAR%type)
    RETURN LUGAR.PUNTOS%type is puntosLugar LUGAR.PUNTOS%type;
begin
SELECT NVL(avg(r.puntaje),0) INTO puntosLugar FROM RESENA r -- Controla el caso de que la consulta no tenga ningun registro a devolver y transforma el NULL en 0.
                                                       JOIN CUENTA c ON c.ID_CUENTA = r.ID_CUENTA
WHERE c.estado <> 'Suspendida' AND r.ID_LUGAR = id_lugar;
return puntosLugar;
end;


-- Requerimiento 2.4
-- Implementar un servicio que permita suspender una cuenta. En el caso de que la cuenta
-- tenga reseñas, se debe actualizar la puntuación de los lugares correspondientes.

-- Detalle IMPL
-- Si cuenta es nulo error
-- si cuenta estado es null o suspendida error
-- sino se cambia el estado de cuenta y se actualizan los puntos de cada lugar asociado a la cuenta modificada
create or replace procedure PRC_suspender_cuenta(
    cuenta_id CUENTA.ID_CUENTA%type
) as
    cuenta_estado CUENTA.ESTADO%type;
    existe_cuenta number;
    CUENTA_ESTADO_ERR EXCEPTION;
    CUENTA_NOT_FOUND EXCEPTION;
    CUENTA_REQ EXCEPTION;
begin
    if(cuenta_id is null) then
        raise CUENTA_REQ;
end if;


SELECT count(*) INTO existe_cuenta FROM CUENTA c WHERE c.ID_CUENTA = cuenta_id;
if(existe_cuenta = 0) then
        raise CUENTA_NOT_FOUND;
end if;

SELECT c.ESTADO INTO cuenta_estado FROM CUENTA c WHERE c.ID_CUENTA = cuenta_id;
if (cuenta_estado = 'Suspendida') then
        raise CUENTA_ESTADO_ERR;
end if;

UPDATE CUENTA c SET c.ESTADO = 'Suspendida' WHERE c.ID_CUENTA = cuenta_id;

for tupla in (select distinct(r.ID_LUGAR) from RESENA r where r.ID_CUENTA = cuenta_id) loop
update LUGAR l set l.PUNTOS = fn_calcular_puntos_lugar(tupla.id_lugar) where l.ID_LUGAR = tupla.id_lugar;
end loop;

EXCEPTION
    when CUENTA_REQ then
        raise_application_error(-20020, 'El campo cuenta_id es requerido');
when CUENTA_NOT_FOUND then
        raise_application_error(-20021, 'La cuenta no existe en el sistema');
when CUENTA_ESTADO_ERR then
        raise_application_error(-20022, 'La cuenta ya tiene estado suspendido en el sistema');
end;
