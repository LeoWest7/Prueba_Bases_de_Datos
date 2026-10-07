-- =====================================================
-- PROYECTO: SISTEMA DE GESTIÓN DE BIBLIOTECA
-- ARCHIVO: 02_datos_prueba.sql
-- =====================================================

-- =====================================================
-- 1. INSERTAR CATEGORÍAS
-- =====================================================

INSERT INTO categoria (nombre, descripcion)
VALUES ('Bases de Datos',
        'Libros relacionados con bases de datos y SQL');

INSERT INTO categoria (nombre, descripcion)
VALUES ('Programacion',
        'Libros relacionados con programación y desarrollo de software');

INSERT INTO categoria (nombre, descripcion)
VALUES ('Literatura',
        'Libros de literatura y obras clásicas');

INSERT INTO categoria (nombre, descripcion)
VALUES ('Redes',
        'Libros relacionados con redes y comunicaciones');


-- =====================================================
-- 2. INSERTAR USUARIOS
-- =====================================================

INSERT INTO usuario (nombre, apellido, email)
VALUES ('Juan', 'Perez', 'juan.perez@gmail.com');

INSERT INTO usuario (nombre, apellido, email)
VALUES ('Maria', 'Gonzalez', 'maria.gonzalez@gmail.com');

INSERT INTO usuario (nombre, apellido, email)
VALUES ('Pedro', 'Soto', 'pedro.soto@gmail.com');

INSERT INTO usuario (nombre, apellido, email)
VALUES ('Camila', 'Rojas', 'camila.rojas@gmail.com');

INSERT INTO usuario (nombre, apellido, email)
VALUES ('Diego', 'Martinez', 'diego.martinez@gmail.com');


-- =====================================================
-- 3. INSERTAR LIBROS
-- =====================================================

INSERT INTO libro
    (titulo, autor, id_categoria, anio_publicacion, stock)
VALUES
    ('Oracle PL/SQL',
     'Steven Feuerstein',
     1,
     2020,
     3);

INSERT INTO libro
    (titulo, autor, id_categoria, anio_publicacion, stock)
VALUES
    ('Fundamentos de Bases de Datos',
     'Abraham Silberschatz',
     1,
     2019,
     2);

INSERT INTO libro
    (titulo, autor, id_categoria, anio_publicacion, stock)
VALUES
    ('Clean Code',
     'Robert C. Martin',
     2,
     2008,
     2);

INSERT INTO libro
    (titulo, autor, id_categoria, anio_publicacion, stock)
VALUES
    ('Introduccion a la Programacion',
     'Luis Joyanes',
     2,
     2021,
     4);

INSERT INTO libro
    (titulo, autor, id_categoria, anio_publicacion, stock)
VALUES
    ('Don Quijote de la Mancha',
     'Miguel de Cervantes',
     3,
     1605,
     1);

INSERT INTO libro
    (titulo, autor, id_categoria, anio_publicacion, stock)
VALUES
    ('Cien años de soledad',
     'Gabriel Garcia Marquez',
     3,
     1967,
     2);

INSERT INTO libro
    (titulo, autor, id_categoria, anio_publicacion, stock)
VALUES
    ('Redes de Computadores',
     'Andrew Tanenbaum',
     4,
     2011,
     3);


-- =====================================================
-- 4. CONFIRMAR LOS CAMBIOS
-- =====================================================

COMMIT;


