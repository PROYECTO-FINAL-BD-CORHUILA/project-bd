-- ==========================================================
-- PRUEBAS ADICIONALES PARA LA SUSTENTACIÓN
-- ==========================================================

-- PRUEBA 1: Integridad Referencial
-- Verificamos que no existan lotes huérfanos (sin finca asignada)
-- Si la consulta devuelve 0, tu integridad referencial es perfecta.
SELECT count(*) AS lotes_sin_finca 
FROM lotes 
WHERE id_finca NOT IN (SELECT id_finca FROM fincas);

-- PRUEBA 2: Prueba de Lógica de Negocio (Rendimiento)
-- Consultar el rendimiento promedio por variedad (Cálculo estadístico)
-- Esto demuestra que puedes hacer consultas complejas con funciones de agregación
SELECT variedad, AVG(cantidad_kg) AS promedio_kg_por_lote
FROM lotes
GROUP BY variedad;

-- PRUEBA 3: Prueba de Filtros (Simulación de búsqueda)
-- Buscar todos los productores que tengan fincas en 'Neiva'
-- Esto demuestra que tus JOINs entre productores y fincas funcionan bien
SELECT p.nombre, f.nombre_finca, f.vereda
FROM productores p
JOIN fincas f ON p.id_productor = f.id_productor
WHERE p.municipio = 'Neiva';

-- 1. Saber cuántas tablas tienes (esto confirma si Liquibase creó todo)
SELECT count(*) FROM information_schema.tables WHERE table_schema = 'public';

-- 2. Saber cuántas columnas tiene la tabla de productores (o la que tú elijas)
-- Cambia 'productores' por el nombre que te salió en el paso 1
SELECT column_name, data_type 
FROM information_schema.columns 
WHERE table_name = 'productores';

-- 3. Ver las 5 filas más recientes de CUALQUIER tabla
-- Solo cambia 'productores' por el nombre de tu tabla principal
SELECT * FROM productores LIMIT 5;