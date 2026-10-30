# Obligatorio_BDD2

## Parte 1

- a) **Pendiente** tenemos MER y aclaraciones
- b) Pronto en [drive](https://drive.google.com/file/d/1xm7Pg0CxCYH5jworPH91Xq-2J5HSZ7BR/view?usp=drive_link)
- c) En Progreso
- d) Pronto en `datos_prueba.sql`

## Parte 2

1) Jose - Pronto
2) Agus - Pronto
3) Jose - Pronto
4) Agus - Pronto
5) Agus - Pronto
6) Freddy - Pronto
7) Freddy - Pronto
8) Freddy

## Parte 3

En Revision 

## Parte 4

En progreso - Agus

## Parte 5

_aunque diga que depende de parte 4, ir arrancando con lo que se tiene_

1) Agus 
2) Freddy
3) Jose
4) Freddy

## Parte 6

**Pendiente VIDEO**

## Entorno local de MongoDB

El archivo `compose.yaml` levanta MongoDB y Mongo Express para desarrollo local. Usa MongoDB 7.0, compatible con kernels Linux anteriores a 7.0.14; MongoDB 8.0+ puede no iniciar o fallar en kernels 6.19 a 7.0.13. Ambos puertos se publican solo en `localhost` y MongoDB conserva los datos en un volumen de Docker.

```sh
docker compose up -d
```

Abrir Mongo Express en <http://localhost:8081>. MongoDB queda disponible en `mongodb://localhost:27017`.

El esquema y los índices de `mongo/01_esquema.js` se aplican manualmente:

```sh
docker compose exec mongodb mongosh "mongodb://localhost:27017" /scripts/01_esquema.js
```

**Atención:** el script elimina y vuelve a crear las colecciones `vehiculos` y `reportes`; ejecutarlo nuevamente borra los documentos existentes en ellas.

Para detener los contenedores sin borrar los datos:

```sh
docker compose down
```

Para eliminar también los datos persistidos, ejecutar `docker compose down -v`.
