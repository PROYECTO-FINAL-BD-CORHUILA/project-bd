# Proyecto Liquibase - Base de Datos

## 📚 Asignatura

**Modelado y Gestión de Bases de Datos**

## 👨‍🎓 Estudiante

**David Santiago Salazar Salazar**

---

## 📌 Descripción del Proyecto

Este proyecto tiene como objetivo implementar una base de datos utilizando **Liquibase** para el control de versiones, junto con **PostgreSQL** ejecutado en un contenedor Docker.

Se desarrolla un sistema básico de gestión que incluye entidades como personas, usuarios, roles, productos y facturación, aplicando buenas prácticas de modelado relacional mediante el uso de llaves primarias y foráneas.

---

## 🧱 Estructura del Proyecto

```
task-mgbd-liquibase/
│
├── db/
│   └── changelog/
│       ├── db.changelog-master.yaml
│       ├── ddl/
│       │   ├── 001-create-persona.sql
│       │   ├── 002-create-rol.sql
│       │   ├── 003-create-usuario.sql
│       │   ├── 004-create-producto.sql
│       │   ├── 005-create-factura.sql
│       │   └── 006-create-detalle-factura.sql
│       └── dml/
│           ├── 001-insert-data.sql
│           ├── 002-update-data.sql
│           └── 003-delete-data.sql
│
├── scripts/
│   └── queries/
│       ├── 001-select-personas.sql
│       ├── 002-select-facturas.sql
│       └── 003-select-detalle-factura.sql
│
├── docker-compose.yml
├── liquibase.properties
└── README.md
```

---

## ⚙️ Tecnologías Utilizadas

* Docker
* PostgreSQL
* Liquibase
* SQL

---

## 🚀 Instrucciones de Ejecución

### 1. Levantar la base de datos con Docker

```bash
docker-compose up -d
```

### 2. Ejecutar las migraciones con Liquibase

```bash
liquibase update
```

---

## 🧪 Validación del Proyecto

Para verificar que la base de datos fue creada correctamente, se deben ejecutar las consultas ubicadas en:

```
scripts/queries/
```

Estas permiten validar:

* Registros en la tabla `persona`
* Relación entre `factura` y `usuario`
* Detalle de productos en `detalle_factura`

---

## 🧠 Conceptos Aplicados

* **DDL (Data Definition Language):** Creación de tablas y estructura de la base de datos.
* **DML (Data Manipulation Language):** Inserción, actualización y eliminación de datos.
* **Llaves primarias y foráneas:** Para mantener la integridad referencial.
* **Control de versiones de base de datos con Liquibase.**

---

## 📄 Notas Adicionales

* El archivo `db.changelog-master.yaml` controla la ejecución de todos los scripts.
* Cada archivo SQL contiene un `changeset` requerido por Liquibase.
* Se utilizó Docker para garantizar portabilidad del entorno.

---

## ✅ Estado del Proyecto

✔ Base de datos funcional
✔ Migraciones ejecutadas correctamente
✔ Datos de prueba insertados
✔ Consultas de validación operativas

---

## 📌 Autor

**David Santiago Salazar Salazar**