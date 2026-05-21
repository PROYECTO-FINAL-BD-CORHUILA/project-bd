--liquibase formatted sql

--changeset santiago:1
--comment: Creación del esquema inicial de 7 tablas para el Marketplace de Café

-- 1. Tabla de Productores
CREATE TABLE productores (
    id_productor SERIAL PRIMARY KEY,
    nombre VARCHAR(100) NOT NULL,
    cedula VARCHAR(20) UNIQUE NOT NULL,
    telefono VARCHAR(20),
    municipio VARCHAR(50) DEFAULT 'Neiva',
    fecha_registro TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- 2. Tabla de Fincas
CREATE TABLE fincas (
    id_finca SERIAL PRIMARY KEY,
    id_productor INT REFERENCES productores(id_productor) ON DELETE CASCADE,
    nombre_finca VARCHAR(100) NOT NULL,
    vereda VARCHAR(100),
    altitud_msnm INT,
    hectareas DECIMAL(5,2)
);

-- 3. Tabla de Lotes de Café
CREATE TABLE lotes (
    id_lote SERIAL PRIMARY KEY,
    id_finca INT REFERENCES fincas(id_finca) ON DELETE CASCADE,
    variedad VARCHAR(50) NOT NULL, -- Ej: Castillo, Colombia, Geisha
    proceso VARCHAR(50),          -- Ej: Lavado, Natural, Honey
    cantidad_kg DECIMAL(10,2) NOT NULL,
    fecha_cosecha DATE NOT NULL
);

-- 4. Tabla de Cataciones (Calidad SCAA)
CREATE TABLE cataciones (
    id_catacion SERIAL PRIMARY KEY,
    id_lote INT REFERENCES lotes(id_lote) ON DELETE CASCADE,
    catador VARCHAR(100) NOT NULL,
    puntaje_scaa DECIMAL(4,2) NOT NULL CHECK (puntaje_scaa >= 0 AND puntaje_scaa <= 100),
    notas_perfil TEXT,
    fecha_catacion TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- 5. Tabla de Clientes (Compradores)
CREATE TABLE clientes (
    id_cliente SERIAL PRIMARY KEY,
    nombre_empresa VARCHAR(100) NOT NULL,
    contacto_nombre VARCHAR(100),
    correo VARCHAR(100) UNIQUE NOT NULL,
    pais_origen VARCHAR(50) DEFAULT 'Colombia'
);

-- 6. Tabla de Pedidos (Maestro)
CREATE TABLE pedidos (
    id_pedido SERIAL PRIMARY KEY,
    id_cliente INT REFERENCES clientes(id_cliente),
    fecha_pedido TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    estado VARCHAR(20) DEFAULT 'Pendiente' -- Pendiente, Completado, Rechazado
);

-- 7. Tabla de Detalle de Pedidos
CREATE TABLE detalle_pedidos (
    id_detalle SERIAL PRIMARY KEY,
    id_pedido INT REFERENCES pedidos(id_pedido) ON DELETE CASCADE,
    id_lote INT REFERENCES lotes(id_lote),
    cantidad_vendida_kg DECIMAL(10,2) NOT NULL,
    precio_por_kg DECIMAL(10,2) NOT NULL
);

--rollback DROP TABLE detalle_pedidos;
--rollback DROP TABLE pedidos;
--rollback DROP TABLE clientes;
--rollback DROP TABLE cataciones;
--rollback DROP TABLE lotes;
--rollback DROP TABLE fincas;
--rollback DROP TABLE productores;