-- changeset Santiago:005
CREATE TABLE factura (
    id SERIAL PRIMARY KEY,
    usuario_id INT,
    fecha TIMESTAMP,
    FOREIGN KEY (usuario_id) REFERENCES usuario(id)
);