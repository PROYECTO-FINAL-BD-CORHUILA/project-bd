-- liquibase formatted sql
-- changeset santiago:datos-canonicos

INSERT INTO variedades (nombre) VALUES ('Castillo'), ('Colombia'), ('Geisha'), ('Bourbon');
INSERT INTO procesos (nombre) VALUES ('Lavado'), ('Natural'), ('Honey');
-- Asegúrate de tener estas tablas o ajusta según tu DDL actual