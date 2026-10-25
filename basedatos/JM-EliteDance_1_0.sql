CREATE DATABASE IF NOT EXISTS jm_elitedance_1_0
  CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;
USE jm_elitedance_1_0;


CREATE TABLE usuarios (
  id               INT          NOT NULL AUTO_INCREMENT,
  nombre_completo  VARCHAR(50)  NOT NULL,
  correo           VARCHAR(100) NOT NULL,
  contrasenia_hash VARCHAR(250) NOT NULL,
  fecha_registro   DATETIME     NOT NULL DEFAULT CURRENT_TIMESTAMP,
  activo           BOOL         NOT NULL DEFAULT TRUE,
  PRIMARY KEY (id),
  UNIQUE KEY uq_usuarios_correo (correo)
) ENGINE=InnoDB;


CREATE TABLE tokens_recuperacion (
  id               INT          NOT NULL AUTO_INCREMENT,
  id_usuario       INT          NOT NULL,
  token_hash       VARCHAR(255) NOT NULL,
  fecha_creacion   DATETIME     NOT NULL DEFAULT CURRENT_TIMESTAMP,
  fecha_expiracion DATETIME     NOT NULL,
  usado            BOOL         NOT NULL DEFAULT FALSE,
  PRIMARY KEY (id),
  UNIQUE KEY uq_token_hash (token_hash),
  CONSTRAINT fk_tokens_usuario FOREIGN KEY (id_usuario)
    REFERENCES usuarios (id) 
) ENGINE=InnoDB;


CREATE TABLE movimientos (
  id           INT         NOT NULL AUTO_INCREMENT,
  nombre       VARCHAR(50) NOT NULL,
  ruta_imagen  VARCHAR(50) NULL,
  PRIMARY KEY (id)
) ENGINE=InnoDB;


CREATE TABLE niveles (
  id                INT          NOT NULL AUTO_INCREMENT,
  titulo            VARCHAR(50)  NOT NULL,
  descripcion       TEXT         NULL,
  id_creador        INT          NULL,
  fecha_creacion    DATETIME     NOT NULL DEFAULT CURRENT_TIMESTAMP,
  activo            BOOL         NOT NULL DEFAULT TRUE,
  ruta_cancion      VARCHAR(200) NOT NULL,
  duracion_segundos INT          NULL,
  PRIMARY KEY (id),
  CONSTRAINT fk_niveles_creador FOREIGN KEY (id_creador)
    REFERENCES usuarios (id) 
) ENGINE=InnoDB;


CREATE TABLE pasos_nivel (
  id            INT           NOT NULL AUTO_INCREMENT,
  id_nivel      INT           NOT NULL,
  id_movimiento INT           NOT NULL,
  segundo       DECIMAL(6,2)  NOT NULL,
  PRIMARY KEY (id),
  UNIQUE KEY uq_paso_nivel_segundo (id_nivel, segundo),
  CONSTRAINT fk_pasos_nivel FOREIGN KEY (id_nivel)
    REFERENCES niveles (id),
  CONSTRAINT fk_pasos_movimiento FOREIGN KEY (id_movimiento)
    REFERENCES movimientos (id)
) ENGINE=InnoDB;


CREATE TABLE puntajes (
  id         INT      NOT NULL AUTO_INCREMENT,
  id_nivel   INT      NOT NULL,
  id_usuario INT      NOT NULL,
  puntaje    INT      NOT NULL DEFAULT 0,
  fecha      DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (id),
  CONSTRAINT fk_puntajes_nivel FOREIGN KEY (id_nivel)
    REFERENCES niveles (id),
  CONSTRAINT fk_puntajes_usuario FOREIGN KEY (id_usuario)
    REFERENCES usuarios (id)
) ENGINE=InnoDB;