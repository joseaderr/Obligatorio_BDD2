
-- Requerimiento 2.5
-- Implementar un servicio que permita a una cuenta publicar una reseña sobre un lugar.
-- El servicio debe retornar la puntuación media del lugar una vez registrada la reseña.

-- Detalle de IMPL
-- si cuenta es null o no existe error
-- si lugar es null o no existe error
-- si param es null o vacío error
-- si puntos es null, menor a 1 o mayor a 5 error
-- si idioma es null o vacío error
-- si no hay errores se hace un upsert de la resena.
CREATE OR REPLACE PROCEDURE PRC_INGRESAR_RESENA(
    param_id_cuenta IN RESENA.ID_CUENTA%type,
    param_id_lugar IN RESENA.ID_LUGAR%type,
    param_descripcion IN RESENA.TEXTO%type,
    param_idioma IN RESENA.IDIOMA%type,
    param_puntos IN RESENA.PUNTAJE%type,
    puntaje_avg OUT LUGAR.puntos%type
) as
    cuenta_not_found Exception;
    lugar_not_found Exception;
    puntos_error Exception;
    desc_error EXCEPTION;
    idioma_error Exception;
    existe_cuenta number;
    existe_lugar number;
    hayResena number;
begin
select count(*) into existe_cuenta from CUENTA c where c.ID_CUENTA = param_id_cuenta;
if(param_id_cuenta is null or existe_cuenta = 0 ) then
        raise cuenta_not_found;
end if;

select count(*) into existe_lugar from LUGAR l where l.ID_LUGAR = param_id_lugar;
if(param_id_lugar is null or existe_lugar = 0 ) then
        raise lugar_not_found;
end if;
    if(param_descripcion is null or trim(param_descripcion) = '' ) then
        raise desc_error;
end if;
    if(param_puntos is null or param_puntos <= 0 or param_puntos > 5 ) then
        raise puntos_error;
end if;
    if(param_idioma is null or trim(param_idioma) = '' ) then
        raise idioma_error;
end if;

select count(*) into hayResena from RESENA r where r.ID_CUENTA = param_id_cuenta and r.ID_LUGAR = param_id_lugar;
if (hayResena = 0) then
        insert into RESENA (ID_CUENTA, ID_LUGAR, PUNTAJE, TEXTO, IDIOMA) values
            (param_id_cuenta, param_id_lugar, param_puntos, param_descripcion, param_idioma);
else
update RESENA r set r.idioma = param_idioma, r.puntaje = param_puntos, r.texto = param_descripcion, r.FECHA = sysdate
WHERE r.ID_CUENTA = param_id_cuenta and r.ID_LUGAR = param_id_lugar;
end if;

    -- Ante de llegar aca ya tendría que haber ejecutado el trigger TRG_RESENA_LUGAR
select l.PUNTOS into puntaje_avg from LUGAR l where l.ID_LUGAR = param_id_lugar;

EXCEPTION
    when cuenta_not_found then
        raise_application_error(-20030, 'Cuenta no encontrada');
when lugar_not_found then
        raise_application_error(-20031, 'Lugar no encontrada');
when puntos_error then
        raise_application_error(-20032, 'Los puntos de la reseña deben ser entre 1 y 5');
when desc_error then
        raise_application_error(-20033, 'La descripción no puede ser nula ni vacía');
when idioma_error then
        raise_application_error(-20034, 'El idioma no puede ser nulo ni vacío');
end;
