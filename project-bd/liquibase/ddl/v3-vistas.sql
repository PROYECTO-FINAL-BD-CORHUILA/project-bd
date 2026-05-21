-- liquibase formatted sql
-- changeset santiago:crear-vistas-sistema

-- Vista de Trazabilidad Comercial: Junta quién produce, en qué finca, qué lote de café y su calidad final.
CREATE OR REPLACE VIEW vista_trazabilidad_completa AS
SELECT 
    p.nombre AS productor,
    p.municipio,
    f.nombre_finca,
    l.id_lote,
    l.variedad,
    l.proceso,
    c.puntaje_scaa AS evaluacion_scaa
FROM productores p
JOIN fincas f ON p.id_productor = f.id_productor
JOIN lotes l ON f.id_finca = l.id_finca
LEFT JOIN cataciones c ON l.id_lote = c.id_lote;