
CREATE TABLE persona (
    id SERIAL PRIMARY KEY,
    nombre VARCHAR(100),
    apellido VARCHAR(100),
    documento VARCHAR(20)
);
SELECT * FROM persona;