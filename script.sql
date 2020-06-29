--DROP SCHEMA public CASCADE;
--CREATE SCHEMA public;

----------------------------------------------------------
-----------------------PLANTEAMIENTO 1--------------------
----------------------------------------------------------


CREATE TABLE PROFESION (
    cod_prof INT PRIMARY KEY NOT null,
    nombre VARCHAR(50) UNIQUE NOT null
);

CREATE TABLE PAIS (
    cod_pais INT PRIMARY KEY NOT null,
    nombre VARCHAR(50) UNIQUE NOT null
);

CREATE TABLE PUESTO (
    cod_puesto INT PRIMARY KEY NOT null,
    nombre VARCHAR(50) UNIQUE NOT null
);

CREATE TABLE DEPARTAMENTO (
    cod_depto INT PRIMARY KEY  NOT null,
    nombre VARCHAR(50) UNIQUE NOT null
);

CREATE TABLE MIEMBRO (
    cod_miembro INT PRIMARY KEY NOT null,
    nombre VARCHAR(100) NOT null,
    apellido VARCHAR(100) NOT null,
    edad INT NOT null,
    telefono INT null,
    residencia VARCHAR(100) null,
    PAIS_cod_pais INT NOT null,
    PROFESION_cod_prof INT NOT null,
	FOREIGN KEY (PAIS_cod_pais) REFERENCES PAIS (cod_pais) ON DELETE CASCADE,
	FOREIGN KEY (PROFESION_cod_prof) REFERENCES PROFESION (cod_prof) ON DELETE CASCADE
);

CREATE TABLE PUESTO_MIEMBRO (
    MIEMBRO_cod_miembro INT NOT null,
    PUESTO_cod_puesto INT NOT null,
    DEPARTAMENTO_cod_depto INT NOT null,
    fecha_inicio date NOT null,
    fecha_fin date null,
	PRIMARY KEY (MIEMBRO_cod_miembro,PUESTO_cod_puesto,DEPARTAMENTO_cod_depto),
	FOREIGN KEY (MIEMBRO_cod_miembro) REFERENCES MIEMBRO (cod_miembro) ON DELETE CASCADE,
	FOREIGN KEY (PUESTO_cod_puesto) REFERENCES PUESTO (cod_puesto) ON DELETE CASCADE,
	FOREIGN KEY (DEPARTAMENTO_cod_depto) REFERENCES DEPARTAMENTO (cod_depto) ON DELETE CASCADE
);

CREATE TABLE TIPO_MEDALLA(
    cod_tipo INT PRIMARY KEY NOT null,
    medalla VARCHAR(20) UNIQUE NOT null
);

CREATE TABLE MEDALLERO(
    PAIS_cod_pais INT NOT null,
    cantidad_medallas INT NOT null,
    TIPO_MEDALLA_cod_tipo INT NOT null,
	PRIMARY KEY (PAIS_cod_pais,TIPO_MEDALLA_cod_tipo),
	FOREIGN KEY (TIPO_MEDALLA_cod_tipo) REFERENCES TIPO_MEDALLA (cod_tipo) ON DELETE CASCADE
);

CREATE TABLE DISCIPLINA (
    cod_disciplina INT PRIMARY KEY NOT null,
    nombre VARCHAR(50) NOT null,
    descripcion VARCHAR(150) null
);

CREATE TABLE ATLETA(
    cod_atleta INT PRIMARY KEY NOT null,
    nombre VARCHAR(50) NOT null,
    apellido VARCHAR(50) NOT null,
    edad INT NOT null,
    participaciones VARCHAR(100) NOT null,
    DISCIPLINA_cod_disciplina INT NOT null,
    PAIS_cod_pais INT NOT null,
	FOREIGN KEY (DISCIPLINA_cod_disciplina) REFERENCES DISCIPLINA (cod_disciplina) ON DELETE CASCADE,
	FOREIGN KEY (PAIS_cod_pais) REFERENCES PAIS (cod_pais) ON DELETE CASCADE
);

CREATE TABLE CATEGORIA(
    cod_categoria INT PRIMARY KEY NOT null,
    categoria VARCHAR(50) NOT null
);

CREATE TABLE TIPO_PARTICIPACION(
    cod_participacion INT PRIMARY KEY NOT null,
    tipo_participacion VARCHAR(100) NOT null
);

CREATE TABLE EVENTO(
    cod_evento INT PRIMARY KEY NOT null,
    fecha date NOT null,
    ubicacion VARCHAR(50) NOT null,
    hora TIME NOT null,
    DISCIPLINA_cod_disciplina INT NOT null,
    TIPO_PARTICIPACION_cod_participacion INT NOT null,
    CATEGORIA_cod_categoria INT NOT null,
	FOREIGN KEY (DISCIPLINA_cod_disciplina) REFERENCES DISCIPLINA (cod_disciplina) ON DELETE CASCADE,
	FOREIGN KEY (TIPO_PARTICIPACION_cod_participacion) REFERENCES TIPO_PARTICIPACION (cod_participacion) ON DELETE CASCADE,
	FOREIGN KEY (CATEGORIA_cod_categoria) REFERENCES CATEGORIA (cod_categoria) ON DELETE CASCADE
);

CREATE TABLE EVENTO_ATLETA(
    ATLETA_cod_atleta INT NOT null,
    EVENTO_cod_evento INT NOT null,
	PRIMARY KEY (ATLETA_cod_atleta,EVENTO_cod_evento),
   	FOREIGN KEY (ATLETA_cod_atleta) REFERENCES ATLETA (cod_atleta) ON DELETE CASCADE,
    FOREIGN KEY (EVENTO_Cod_evento) REFERENCES EVENTO (cod_evento) ON DELETE CASCADE
);

CREATE TABLE TELEVISORA(
    cod_televisora INT PRIMARY KEY NOT null,
    nombre VARCHAR(50) NOT null
);

CREATE TABLE COSTO_EVENTO(
    EVENTO_cod_evento INT NOT null,
    TELEVISORA_cod_televisora INT NOT null,
    tarifa INT NOT null,
	PRIMARY KEY (EVENTO_cod_evento,TELEVISORA_cod_televisora),
    FOREIGN KEY (EVENTO_cod_evento) REFERENCES EVENTO (cod_evento) ON DELETE CASCADE,
    FOREIGN KEY (TELEVISORA_cod_televisora) REFERENCES TELEVISORA (cod_televisora) ON DELETE CASCADE
);


----------------------------------------------------------
-----------------------PLANTEAMIENTO 2--------------------
----------------------------------------------------------

ALTER TABLE EVENTO
DROP fecha,
DROP hora,
ADD fecha_hora timestamp NOT null;

----------------------------------------------------------
-----------------------PLANTEAMIENTO 3--------------------
----------------------------------------------------------

ALTER TABLE EVENTO 
ADD CHECK (fecha_hora BETWEEN '2020-07-24 09:00:00' AND '2020-08-09 20:00:00');

----------------------------------------------------------
-----------------------PLANTEAMIENTO 4--------------------
----------------------------------------------------------

CREATE TABLE SEDE(
    codigo INT PRIMARY KEY NOT NULL,
    sede VARCHAR(50) NOT NULL
);

ALTER TABLE EVENTO
ALTER COLUMN ubicacion TYPE INT USING ubicacion::INT;

ALTER TABLE EVENTO
RENAME ubicacion TO SEDE_codigo;

ALTER TABLE EVENTO
ADD FOREIGN KEY (SEDE_codigo) REFERENCES SEDE (codigo);

----------------------------------------------------------
-----------------------PLANTEAMIENTO 5--------------------
----------------------------------------------------------

	ALTER TABLE MIEMBRO
	ALTER COLUMN telefono TYPE INT,
	ALTER COLUMN telefono SET DEFAULT 0;

----------------------------------------------------------
-----------------------PLANTEAMIENTO 6--------------------
----------------------------------------------------------

INSERT INTO PAIS (cod_pais, nombre) VALUES (1, 'Guatemala');
INSERT INTO PAIS (cod_pais, nombre) VALUES (2, 'Francia');
INSERT INTO PAIS (cod_pais, nombre) VALUES (3, 'Argentina');
INSERT INTO PAIS (cod_pais, nombre) VALUES (4, 'Alemania');
INSERT INTO PAIS (cod_pais, nombre) VALUES (5, 'Italia');
INSERT INTO PAIS (cod_pais, nombre) VALUES (6, 'Brasil');
INSERT INTO PAIS (cod_pais, nombre) VALUES (7, 'Estados Unidos');

INSERT INTO PROFESION (cod_prof, nombre) VALUES (1, 'Médico');
INSERT INTO PROFESION (cod_prof, nombre) VALUES (2, 'Arquitecto');
INSERT INTO PROFESION (cod_prof, nombre) VALUES (3, 'Ingeniero');
INSERT INTO PROFESION (cod_prof, nombre) VALUES (4, 'Secretaria');
INSERT INTO PROFESION (cod_prof, nombre) VALUES (5, 'Auditor');

INSERT INTO MIEMBRO (cod_miembro,nombre,apellido,edad,residencia,PAIS_cod_pais,PROFESION_cod_prof)
VALUES (1,'Scott','Mitchell',32,'1092 Highland Drive Manitowoc, Wl 54220',7,3);
INSERT INTO MIEMBRO (cod_miembro,nombre,apellido,edad,telefono,residencia,PAIS_cod_pais,PROFESION_cod_prof)
VALUES (2,'Fanette','Poulin',25,25075853,'49, boulevard Aristide Briand 76120 LE GRAND-QUEVILLY',2,4);
INSERT INTO MIEMBRO (cod_miembro,nombre,apellido,edad,residencia,PAIS_cod_pais,PROFESION_cod_prof)
VALUES (3,'Laura','Cunha Silva',55,'Rua Onze, 86 Uberaba-MG',6,5);
INSERT INTO MIEMBRO (cod_miembro,nombre,apellido,edad,telefono,residencia,PAIS_cod_pais,PROFESION_cod_prof)
VALUES (4,'Juan José','López',38,36985247,'26 calle 4-10 zona 11',1,2);
INSERT INTO MIEMBRO (cod_miembro,nombre,apellido,edad,telefono,residencia,PAIS_cod_pais,PROFESION_cod_prof)
VALUES (5,'Arcangela','Panicucci',39,391664921,'Via Santa Teresa, 114 90010-Geraci Siculo PA',5,1);
INSERT INTO MIEMBRO (cod_miembro,nombre,apellido,edad,residencia,PAIS_cod_pais,PROFESION_cod_prof)
VALUES (6,'Jeuel','Villalpando',31,'Acuña de Figeroa 6106 80101 Playa Pascual',3,5);

INSERT INTO DISCIPLINA (cod_disciplina,nombre,descripcion) VALUES (1,'Atletismo','Saltos de longitud y triples, de altura y con pértiga o garrocha; las pruebas de lanzamiento de martillo, jabalina y disco');
INSERT INTO DISCIPLINA (cod_disciplina,nombre) VALUES (2,'Bádminton');
INSERT INTO DISCIPLINA (cod_disciplina,nombre) VALUES (3,'Ciclismo');
INSERT INTO DISCIPLINA (cod_disciplina,nombre,descripcion) VALUES (4,'Judo','Es un arte marcial que se originó en Japón alrededor de 1880');
INSERT INTO DISCIPLINA (cod_disciplina,nombre) VALUES (5,'Lucha');
INSERT INTO DISCIPLINA (cod_disciplina,nombre) VALUES (6,'Tenis de Mesa');
INSERT INTO DISCIPLINA (cod_disciplina,nombre) VALUES (7,'Boxeo');
INSERT INTO DISCIPLINA (cod_disciplina,nombre,descripcion) VALUES (8,'Natación','Está presente como deporte en los Juegos desde la primera edición de la era moderna, en Atenas, Grecia, en 1896, donde se disputo en aguas abiertas.');
INSERT INTO DISCIPLINA (cod_disciplina,nombre) VALUES (9,'Esgrima');
INSERT INTO DISCIPLINA (cod_disciplina,nombre) VALUES (10,'Vela');

INSERT INTO TIPO_MEDALLA(cod_tipo, medalla) VALUES (1, 'Oro');
INSERT INTO TIPO_MEDALLA(cod_tipo, medalla) VALUES (2, 'Plata');
INSERT INTO TIPO_MEDALLA(cod_tipo, medalla) VALUES (3, 'Bronce');
INSERT INTO TIPO_MEDALLA(cod_tipo, medalla) VALUES (4, 'Platino');

INSERT INTO CATEGORIA (cod_categoria, categoria) VALUES (1, 'Clasificatorio');
INSERT INTO CATEGORIA (cod_categoria, categoria) VALUES (2, 'Eliminatorio');
INSERT INTO CATEGORIA (cod_categoria, categoria) VALUES (3, 'Final');

INSERT INTO TIPO_PARTICIPACION (cod_participacion, tipo_participacion) VALUES (1, 'Individual');
INSERT INTO TIPO_PARTICIPACION (cod_participacion, tipo_participacion) VALUES (2, 'Parejas');
INSERT INTO TIPO_PARTICIPACION (cod_participacion, tipo_participacion) VALUES (3, 'Equipos');

INSERT INTO MEDALLERO (PAIS_cod_pais,TIPO_MEDALLA_cod_tipo,cantidad_medallas) VALUES (5,1,3);
INSERT INTO MEDALLERO (PAIS_cod_pais,TIPO_MEDALLA_cod_tipo,cantidad_medallas) VALUES (2,1,5);
INSERT INTO MEDALLERO (PAIS_cod_pais,TIPO_MEDALLA_cod_tipo,cantidad_medallas) VALUES (6,3,4);
INSERT INTO MEDALLERO (PAIS_cod_pais,TIPO_MEDALLA_cod_tipo,cantidad_medallas) VALUES (4,4,3);
INSERT INTO MEDALLERO (PAIS_cod_pais,TIPO_MEDALLA_cod_tipo,cantidad_medallas) VALUES (7,3,10);
INSERT INTO MEDALLERO (PAIS_cod_pais,TIPO_MEDALLA_cod_tipo,cantidad_medallas) VALUES (3,2,8);
INSERT INTO MEDALLERO (PAIS_cod_pais,TIPO_MEDALLA_cod_tipo,cantidad_medallas) VALUES (1,1,2);
INSERT INTO MEDALLERO (PAIS_cod_pais,TIPO_MEDALLA_cod_tipo,cantidad_medallas) VALUES (1,4,5);
INSERT INTO MEDALLERO (PAIS_cod_pais,TIPO_MEDALLA_cod_tipo,cantidad_medallas) VALUES (5,2,7);

INSERT INTO SEDE (codigo, sede) VALUES (1,'Gimnasio Metropolitano de Tokio');
INSERT INTO SEDE (codigo, sede) VALUES (2,'Jardín del Palacio Imperial de Tokio');
INSERT INTO SEDE (codigo, sede) VALUES (3,'Gimnasio Nacional Yoyogi');
INSERT INTO SEDE (codigo, sede) VALUES (4,'Nippon Budokan');
INSERT INTO SEDE (codigo, sede) VALUES (5,'Estadio Olímpico');

INSERT INTO EVENTO (cod_evento,fecha_hora,SEDE_codigo,DISCIPLINA_cod_disciplina,TIPO_PARTICIPACION_cod_participacion,CATEGORIA_cod_categoria) VALUES (1,'2020-07-24 11:00:00', 3, 2, 2, 1);
INSERT INTO EVENTO (cod_evento,fecha_hora,SEDE_codigo,DISCIPLINA_cod_disciplina,TIPO_PARTICIPACION_cod_participacion,CATEGORIA_cod_categoria) VALUES (2,'2020-07-26 10:30:00', 1, 6, 1, 3);
INSERT INTO EVENTO (cod_evento,fecha_hora,SEDE_codigo,DISCIPLINA_cod_disciplina,TIPO_PARTICIPACION_cod_participacion,CATEGORIA_cod_categoria) VALUES (3,'2020-07-30 18:45:00', 5, 7, 1, 2);
INSERT INTO EVENTO (cod_evento,fecha_hora,SEDE_codigo,DISCIPLINA_cod_disciplina,TIPO_PARTICIPACION_cod_participacion,CATEGORIA_cod_categoria)
VALUES (4,'2020-08-01 12:15:00', 2, 1, 1, 1);
INSERT INTO EVENTO (cod_evento,fecha_hora,SEDE_codigo,DISCIPLINA_cod_disciplina,TIPO_PARTICIPACION_cod_participacion,CATEGORIA_cod_categoria)
VALUES (5,'2020-08-08 19:35:00', 4, 10, 3, 1);

----------------------------------------------------------
-----------------------PLANTEAMIENTO 7--------------------
----------------------------------------------------------

ALTER TABLE PAIS
DROP CONSTRAINT pais_nombre_key;	

ALTER TABLE TIPO_MEDALLA
DROP CONSTRAINT tipo_medalla_medalla_key;

ALTER TABLE DEPARTAMENTO
DROP CONSTRAINT departamento_nombre_key;

----------------------------------------------------------
-----------------------PLANTEAMIENTO 8--------------------
----------------------------------------------------------

ALTER TABLE ATLETA
DROP CONSTRAINT atleta_disciplina_cod_disciplina_fkey,
DROP COLUMN DISCIPLINA_cod_disciplina;

CREATE TABLE DISCIPLINA_ATLETA(
    cod_atleta INT NOT null,
    cod_disciplina INT NOT null,
    PRIMARY KEY (cod_atleta, cod_disciplina),
    FOREIGN KEY (cod_atleta) REFERENCES ATLETA (cod_atleta) ON DELETE CASCADE,
    FOREIGN KEY (cod_disciplina) REFERENCES DISCIPLINA (cod_disciplina) ON DELETE CASCADE
);

----------------------------------------------------------
-----------------------PLANTEAMIENTO 9--------------------
----------------------------------------------------------

ALTER TABLE COSTO_EVENTO
ALTER COLUMN tarifa TYPE NUMERIC(20, 2);

----------------------------------------------------------
-----------------------PLANTEAMIENTO 10-------------------
----------------------------------------------------------

DELETE FROM TIPO_MEDALLA
WHERE cod_tipo = 4 AND medalla='Platino';


----------------------------------------------------------
-----------------------PLANTEAMIENTO 11-------------------
----------------------------------------------------------

DROP TABLE COSTO_EVENTO;
DROP TABLE TELEVISORA;

----------------------------------------------------------
-----------------------PLANTEAMIENTO 12-------------------
----------------------------------------------------------

DELETE FROM DISCIPLINA;

----------------------------------------------------------
-----------------------PLANTEAMIENTO 13-------------------
----------------------------------------------------------

UPDATE MIEMBRO
SET telefono = 55464601 WHERE nombre = 'Laura' AND apellido = 'Cunha Silva';

UPDATE MIEMBRO
SET telefono = 91514243 WHERE nombre = 'Jeuel' AND apellido = 'Villalpando';

UPDATE MIEMBRO
SET telefono = 920686670 WHERE nombre = 'Scott' AND apellido = 'Mitchell';

----------------------------------------------------------
-----------------------PLANTEAMIENTO 14-------------------
----------------------------------------------------------

ALTER TABLE ATLETA
ADD fotografia BYTEA null;

----------------------------------------------------------
-----------------------PLANTEAMIENTO 15-------------------
----------------------------------------------------------

ALTER TABLE ATLETA
ADD CHECK (edad < 25);
