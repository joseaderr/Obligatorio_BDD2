-- Requerimiento 2.2
-- Implementar un servicio que permita la transferencia de la titularidad de un lugar entre dos cuentas.
-- Se debe verificar que la cuenta que transfiere sea realmente la que administra el lugar y que ambas
-- se encuentren correctamente habilitadas para la transferencia.

-- Detalle de IMPL
-- Si no se mandan los params necesarios se devuelve error.
-- Si la cuenta de origen no es propietaria del lugar se devuelve error
-- Si la cuenta de destino no tiene rol propietario se devuelve error
-- Si la cuenta de destino no tiene fecha de verificación se devuelve error.
create or replace procedure PRC_transferir_titularidad(
    lugar_id IN LUGAR.ID_LUGAR%type,
    cuenta_id_destino in CUENTA.ID_CUENTA%type,
    cuenta_id_origen in CUENTA.ID_CUENTA%type
) as
    admin_actual LUGAR.ID_CUENTA_ADMIN%type;
    fecha_verificacion CUENTA_PROPIETARIA.FECHA_VERIFICACION%type;
    LUGAR_SIN_ADMIN_ERR Exception;
    LUGAR_REQ_ERR Exception;
    CUENTA_DESTINO_REQ_ERR Exception;
    CUENTA_ORIGEN_REQ_ERR Exception;
    CUENTA_DESTINO_NO_VERIF_ERR Exception;
    CUENTA_ORIGEN_ERR Exception;
begin
    if( lugar_id is null ) then
        raise LUGAR_REQ_ERR;
    elsif (cuenta_id_destino is null) then
        raise CUENTA_DESTINO_REQ_ERR;
    elsif (cuenta_id_origen is null) then
        raise CUENTA_ORIGEN_REQ_ERR;
end if;

SELECT l.ID_CUENTA_ADMIN into admin_actual FROM LUGAR l WHERE l.ID_LUGAR = lugar_id;

if(admin_actual is null ) then
        raise LUGAR_SIN_ADMIN_ERR;
    elsif (admin_actual <> cuenta_id_origen) then
        raise CUENTA_ORIGEN_ERR;
end if;

SELECT cd.FECHA_VERIFICACION into fecha_verificacion from CUENTA_PROPIETARIA cd where cd.ID_CUENTA = cuenta_id_destino;

if (fecha_verificacion is null) then
        raise CUENTA_DESTINO_NO_VERIF_ERR;
end if;

UPDATE LUGAR l set l.ID_CUENTA_ADMIN = cuenta_id_destino where l.ID_LUGAR = lugar_id;

EXCEPTION
    when LUGAR_REQ_ERR then
        raise_application_error(-20010, 'El campo lugar_id es requerido');
when CUENTA_DESTINO_REQ_ERR then
        raise_application_error(-20011, 'El campo cuenta_id_destino es requerido');
when CUENTA_ORIGEN_REQ_ERR then
        raise_application_error(-20012, 'El campo cuenta_id_origen es requerido');
when LUGAR_SIN_ADMIN_ERR then
        raise_application_error(-20013, 'El lugar debe contar con un administrador actual para hacer una transferencia');
when CUENTA_DESTINO_NO_VERIF_ERR then
        raise_application_error(-20014,'La cuenta de destino no ha sido verificada como propietaria.');
when CUENTA_ORIGEN_ERR then
        raise_application_error(-20015,'La cuenta de origen no es propietaria del lugar.');
end;