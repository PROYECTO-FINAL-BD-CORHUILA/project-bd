# ☕ Marketplace de Café: Sistema de Gestión

## 1. Descripción del Proyecto
Este proyecto es una solución integral para la gestión de datos en el sector caficultor. El sistema permite registrar fincas, productores, lotes y gestionar la logística de pedidos, garantizando la trazabilidad y el rendimiento comercial a través de herramientas avanzadas de base de datos.

---

## 2. Equipo de Desarrollo
* David Santiago Salazar Salazar
* Cesar Augusto Tamayo Urriago

---

## 3. Estructura del Repositorio
Para facilitar el mantenimiento y la escalabilidad, el proyecto se organiza de la siguiente manera:

### 📂 Carpeta `ddl/` (Migraciones de Base de Datos)
Contiene todos los archivos necesarios para construir la infraestructura mediante **Liquibase**:

* `db.changelog-master.xml`: Archivo maestro que orquesta la ejecución secuencial de todas las migraciones.
* `v1-estructura-base.sql`: Definición de tablas relacionales (fincas, productores, lotes, pedidos).
* `v2-evidencias-santiago.sql`: Scripts complementarios de configuración y datos iniciales.
* `v3-evidencias-cesar.sql`: **Lógica de negocio avanzada**:
    * `historial_auditoria`: Registro de cambios.
    * `fn_total_kg_variedad`: Cálculo de rendimiento por variedad.
    * `trg_auditoria_pedidos`: Trigger para trazabilidad automática.
    * `sp_aplicar_descuento_volumen`: Procedimiento de gestión comercial.
    * `vista_rendimiento_comercial_fincas`: Reporte ejecutivo de ventas.

### 📂 Carpetas de Soporte
* `rollback/`: Reservada para scripts de reversión (*downgrade*) de esquema.
* `scripts/`: Destinada a tareas de mantenimiento, respaldos y utilidades del contenedor.

---

## 4. Guía de Ejecución
El entorno está estandarizado mediante **Docker**, asegurando que la base de datos funcione exactamente igual en cualquier equipo.

* **Iniciar el entorno:**
  ```bash
  docker compose up