-- liquibase formatted sql
-- changeset santiago:agregar-check-e-indices

-- =======================================================
-- 1. RESTRICCIONES CHECK
-- =======================================================
-- Validar que los puntajes de catación cumplan el estándar internacional SCAA (0 a 100)
ALTER TABLE cataciones 
ADD CONSTRAINT chk_puntaje_scaa CHECK (puntaje_scaa >= 0 AND puntaje_scaa <= 100);

-- Validar que las hectáreas y cantidades de café recolectadas sean lógicas y positivas
ALTER TABLE fincas ADD CONSTRAINT chk_hectareas_positivas CHECK (hectareas > 0);
ALTER TABLE lotes ADD CONSTRAINT chk_cantidad_kg_positiva CHECK (cantidad_kg >= 0);

-- Validar valores de mercado en las transacciones comerciales del Marketplace
ALTER TABLE detalle_pedidos ADD CONSTRAINT chk_precio_positivo CHECK (precio_por_kg > 0);
ALTER TABLE detalle_pedidos ADD CONSTRAINT chk_cantidad_vendida_positiva CHECK (cantidad_vendida_kg > 0);

-- =======================================================
-- 2. ÍNDICES JUSTIFICADOS
-- =======================================================
-- JUSTIFICACIÓN: Se crea porque la búsqueda de productores por municipio será la más usada por los compradores para filtrar origen local.
CREATE INDEX idx_productores_municipio ON productores(municipio);

-- JUSTIFICACIÓN: Optimiza las búsquedas frecuentes de los estados de negocio ('Pendiente', 'Enviado', 'Completado') en el panel administrativo.
CREATE INDEX idx_pedidos_estado ON pedidos(estado);

-- JUSTIFICACIÓN: Acelera los ordenamientos de las cataciones más recientes o de mayor puntaje para los rankings de calidad de café.
CREATE INDEX idx_cataciones_puntaje ON cataciones(puntaje_scaa DESC);