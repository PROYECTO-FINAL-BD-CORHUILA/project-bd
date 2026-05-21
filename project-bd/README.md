# ☕ Project-BD: Infraestructura y Datos para el Marketplace de Café

Este repositorio contiene la arquitectura de base de datos relacional para la plataforma de Marketplace de Café Especial del Huila. El despliegue, versionamiento y migración de la estructura se gestionan de forma automatizada utilizando **Liquibase** y contenedores de **Docker** con **PostgreSQL**.

---

## 👥 Integrantes del Grupo
* **David Santiago Salazar Salazar**
* **Cesar Augusto Tamayo Urriago**

*Asignatura: Bases de Datos II  
Corporación Universitaria del Huila (CORHUILA)*

---

## 📁 Arquitectura del Proyecto y Estructura de Carpetas

A continuación se detalla la función de cada directorio y los scripts que componen el ciclo de vida de la base de datos:

### 🔹 1. `liquibase/changelog/`
Contiene el archivo orquestador principal de las migraciones.
* **`db.changelog-master.xml`**: Es el archivo maestro de Liquibase. Se encarga de definir el orden estricto de ejecución de todos los scripts SQL del proyecto, garantizando que la estructura (DDL) se monte por completo antes de inyectar cualquier dato (DML).

### 🔹 2. `liquibase/ddl/` (Data Definition Language)
Contiene la evolución de la estructura de la base de datos de forma incremental. Cumple estrictamente con los requerimientos técnicos avanzados del diseño relacional exigidos en la rúbrica:
* **`v1-crear-tablas-iniciales.sql`**: Define el esquema base con la creación de tablas, llaves primarias, llaves foráneas y restricciones de obligatoriedad (`NOT NULL` y `UNIQUE`).
* **`v2-restricciones-indices.sql`**: Implementa las restricciones de verificación (`CHECK`) para asegurar la integridad del negocio y los índices personalizados (`INDEX`) optimizados para acelerar las búsquedas concurrentes en la aplicación.
* **`v3-vistas.sql`**: Almacena las consultas complejas y reportes de negocio estructurados (`VIEW`) para simplificar la lectura de datos unificados (ej. trazabilidad completa).
* **`v4-programacion-bd.sql`**: Contiene la lógica programable en el servidor, incluyendo funciones (`FUNCTIONS`), procedimientos almacenados (`PROCEDURES`) y disparadores automatizados (`TRIGGERS`) para el control dinámico del inventario.

### 🔹 3. `liquibase/dml/` (Data Manipulation Language)
Maneja la inserción de la información en el sistema, dividida según su naturaleza operacional:

* **📁 `canonical/` (Datos Semilla)**
  * **`v1-datos-semilla.sql`**: Inserta los datos maestros estáticos e indispensables para que el negocio pueda operar en producción (por ejemplo, el catálogo oficial de variedades de café como *Castillo, Geisha* y tipos de procesos como *Lavado, Natural*).
* **📁 `volumetric/` (Carga Masiva)**
  * **`v1-carga-masiva.sql`**: Almacena el set de datos masivos de simulación (más de 100 registros volumétricos) diseñado para estresar la base de datos, validar el comportamiento del trigger de inventario y comprobar el rendimiento de los índices bajo una carga real de pruebas.

### 🔹 4. Archivos de Configuración de la Raíz
* **`docker-compose.yml`**: Configura y levanta el entorno aislado con el motor de PostgreSQL y la herramienta de migración de Liquibase de manera coordinada.
* **`liquibase.properties.example`**: Archivo de plantilla que define las variables de entorno, credenciales y puertos de conexión requeridos para enlazar Liquibase con el contenedor de la base de datos.
* **`pruebas__entrega.sql`**: Banco de pruebas manuales y scripts de consulta rápidos para demostrar el correcto funcionamiento de los triggers, vistas y procedimientos durante la sustentación académica.

---

## 🚀 Flujo de Execution del Ciclo de Vida

Para garantizar la integridad referencial de los datos, el `db.changelog-master.xml` ejecuta los componentes en la siguiente secuencia lógica:

```text
┌───────────────┐      ┌─────────────────────────┐      ┌─────────────────┐      ┌─────────────────┐
│ DDL: Tablas   │ ───> │ DDL: Checks e Índices   │ ───> │ DDL: Vistas     │ ───> │ DDL: Triggers   │
└───────────────┘      └─────────────────────────┘      └─────────────────┘      └─────────────────┘
                                                                                          │
┌─────────────────────────┐      ┌─────────────────────────┐                              │
│ DML: Carga Volumétrica  │ <─── │ DML: Semillas Canónicas │ <────────────────────────────┘
└─────────────────────────┘      └─────────────────────────┘