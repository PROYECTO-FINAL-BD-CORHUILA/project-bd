-- liquibase formatted sql
-- changeset santiago:carga-volumetrica-definitiva-v5 splitStatements:false

-- 1. LIMPIEZA AUTOMÁTICA: Borra datos previos y resetea IDs para evitar el error de duplicados
TRUNCATE TABLE detalle_pedidos, pedidos, clientes, cataciones, lotes, fincas, productores RESTART IDENTITY CASCADE;

-- 2. INSERTAR PRODUCTORES
INSERT INTO productores (nombre, cedula, telefono, municipio)
SELECT 
    (ARRAY['Carlos Gomez', 'Ana Rodriguez', 'Luis Perez', 'Maria Hernandez', 'Pedro Torres', 'Sofia Ramirez', 'Juan Diaz', 'Lucia Sanchez', 'Diego Lopez', 'Elena Muñoz'])[1 + (s % 10)],
    '1000' || (1000 + s),
    '300' || (1000000 + s),
    (ARRAY['Neiva', 'Pitalito', 'Garzón', 'La Plata', 'Timaná', 'San Agustín', 'Acevedo'])[1 + (s % 7)]
FROM generate_series(1, 110) AS s;

-- 3. INSERTAR FINCAS
INSERT INTO fincas (id_productor, nombre_finca, vereda, altitud_msnm, hectareas)
SELECT 
    id_productor,
    (ARRAY['Finca El Roble', 'Hacienda La Gloria', 'Finca San Isidro', 'Finca Las Mercedes', 'Finca El Tesoro'])[1 + (id_productor % 5)],
    (ARRAY['La Esperanza', 'El Mirador', 'Los Andes', 'Bella Vista', 'El Oasis', 'Villa Café', 'La Cumbre', 'Brisas del Huila'])[1 + (id_productor % 8)],
    1300 + (id_productor * 2),
    2.5
FROM productores 
ORDER BY id_productor DESC LIMIT 110;

-- 4. INSERTAR LOTES
INSERT INTO lotes (id_finca, variedad, proceso, cantidad_kg, fecha_cosecha)
SELECT 
    id_finca,
    'Castillo',
    'Lavado',
    500 + (id_finca % 100),
    CURRENT_DATE - (id_finca % 30)
FROM fincas 
ORDER BY id_finca DESC LIMIT 110;

-- 5. INSERTAR CATACIONES
INSERT INTO cataciones (id_lote, catador, puntaje_scaa, notas_perfil)
SELECT 
    id_lote,
    'Catador Experto ' || (1 + (id_lote % 3)),
    80.00 + (id_lote % 10),
    'Excelente balance, notas cítricas y dulces características del Huila.'
FROM lotes 
ORDER BY id_lote DESC LIMIT 110;

-- 6. INSERTAR CLIENTES
INSERT INTO clientes (nombre_empresa, contacto_nombre, correo, pais_origen)
SELECT 
    (ARRAY['Café Export S.A.', 'Global Coffee Hub', 'Premium Beans Co.', 'Cafeteros del Mundo'])[1 + (s % 4)],
    'Gerente Comercial ' || s,
    'contacto' || s || '@exportcafe.com',
    'Colombia'
FROM generate_series(1, 110) AS s;

-- 7. INSERTAR PEDIDOS
INSERT INTO pedidos (id_cliente, fecha_pedido, estado)
SELECT 
    id_cliente,
    CURRENT_TIMESTAMP,
    'Pendiente'
FROM clientes 
ORDER BY id_cliente DESC LIMIT 110;

-- 8. INSERTAR DETALLE DE PEDIDOS
INSERT INTO detalle_pedidos (id_pedido, id_lote, cantidad_vendida_kg, precio_por_kg)
SELECT 
    p.id_pedido,
    l.id_lote,
    50.00 + (p.id_pedido % 20),
    12500.00 + (p.id_pedido * 10)
FROM (
    SELECT id_pedido, ROW_NUMBER() OVER (ORDER BY id_pedido DESC) as rn 
    FROM pedidos LIMIT 110
) p
JOIN (
    SELECT id_lote, ROW_NUMBER() OVER (ORDER BY id_lote DESC) as rn 
    FROM lotes LIMIT 110
) l ON p.rn = l.rn;