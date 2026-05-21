# Investigación: Liquibase

## ¿Qué es Liquibase?

Liquibase es una herramienta que permite gestionar y versionar bases de datos mediante archivos llamados *changelogs*, donde se definen los cambios que se aplican automáticamente.

## ¿Para qué sirve?

Sirve para:

* Crear y modificar bases de datos de forma automática.
* Controlar cambios en tablas y relaciones.
* Evitar errores al ejecutar scripts manualmente.

## ¿Cómo funciona?

Liquibase lee un archivo principal (`db.changelog-master.yaml`) que contiene una lista de cambios. Luego ejecuta los archivos SQL en orden y guarda un registro de los cambios aplicados.

## Conceptos clave

* **Changelog:** archivo principal que organiza los cambios.
* **Changeset:** identificador único de cada cambio.
* **DDL:** creación de tablas.
* **DML:** manipulación de datos (insert, update, delete).

## Implementación en el proyecto

En este proyecto se utilizó Liquibase junto con PostgreSQL en Docker para:

* Crear las tablas: persona, rol, usuario, producto, factura y detalle_factura.
* Insertar datos de prueba.
* Mantener el control de los cambios mediante archivos organizados en DDL y DML.

## Conclusión

Liquibase facilita la gestión de bases de datos, permitiendo automatizar cambios y mantener un control ordenado del sistema.
