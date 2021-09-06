SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

DROP SCHEMA IF EXISTS `testm5n3` ;
CREATE SCHEMA IF NOT EXISTS `testm5n3` DEFAULT CHARACTER SET utf8 COLLATE utf8_general_ci ;
USE `testm5n3` ;

-- -----------------------------------------------------
-- Table `testm5n3`.`Tipo_usuario`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `testm5n3`.`Tipo_usuario` ;

CREATE TABLE IF NOT EXISTS `testm5n3`.`Tipo_usuario` (
  `idTipo_usuario` INT NOT NULL AUTO_INCREMENT,
  `Tipo_usuario` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`idTipo_usuario`))
ENGINE = InnoDB;

insert into Tipo_usuario values
(default, 'Premium') ,(default, 'Free') ;
-- -----------------------------------------------------
-- Table `testm5n3`.`Usuarios`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `testm5n3`.`Usuarios` ;

CREATE TABLE IF NOT EXISTS `testm5n3`.`Usuarios` (
  `idUsuarios` INT NOT NULL AUTO_INCREMENT,
  `Usuario_nombre` VARCHAR(45) NOT NULL,
  `Usuario_mail` VARCHAR(45) NULL,
  `Usuario_passw` VARCHAR(12) NULL,
  `Usuario_nacimiento` DATE NULL,
  `Usuario_sexo` VARCHAR(1) NULL,
  `Usuario_pais` VARCHAR(35) NULL,
  `Usuario_CIP` VARCHAR(15) NULL,
  `Tipo_usuario_idTipo_usuario` INT NOT NULL,
  PRIMARY KEY (`idUsuarios`),
  INDEX `fk_Usuarios_Tipo_usuario_idx` (`Tipo_usuario_idTipo_usuario` ASC),
  CONSTRAINT `fk_Usuarios_Tipo_usuario`
    FOREIGN KEY (`Tipo_usuario_idTipo_usuario`)
    REFERENCES `testm5n3`.`Tipo_usuario` (`idTipo_usuario`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

insert into Usuarios values
(default, 'Usuario Premium 1', 'kk@kk.com','passw','1980/12/17','M','Spain','08800','1') ,
(default, 'Usuario Free 1', 'kkv@kkv.com','passwv','1990/12/18','H','Spain','08020','2') ,
(default, 'Usuario Premium 2', 'kkx@kk.com','passw','1981/12/17','M','Spain','08801','1') ,
(default, 'Usuario Free 2', 'kkvx@kkv.com','passwv','1991/12/18','H','Spain','08021','2') 
;
-- -----------------------------------------------------
-- Table `testm5n3`.`Suscripciones`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `testm5n3`.`Suscripciones` ;

CREATE TABLE IF NOT EXISTS `testm5n3`.`Suscripciones` (
  `idSuscripciones` INT NOT NULL AUTO_INCREMENT,
  `Usuarios_idUsuarios` INT NOT NULL,
  `Suscripcion_inicio` DATE NULL,
  `Suscripcion_renovacion` DATE NULL,
  `Suscripcion_forma_pago` VARCHAR(1) NULL,
  PRIMARY KEY (`idSuscripciones`, `Usuarios_idUsuarios`),
  INDEX `fk_Suscripciones_Usuarios1_idx` (`Usuarios_idUsuarios` ASC),
  CONSTRAINT `fk_Suscripciones_Usuarios1`
    FOREIGN KEY (`Usuarios_idUsuarios`)
    REFERENCES `testm5n3`.`Usuarios` (`idUsuarios`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


insert into Suscripciones values
(default, 1, '2020/12/17',NULL,'T') ,
(default, 3, '2000/12/18','2020/12/18','P'); 

-- -----------------------------------------------------
-- Table `testm5n3`.`datos_pago`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `testm5n3`.`datos_pago` ;

CREATE TABLE IF NOT EXISTS `testm5n3`.`datos_pago` (
  `iddatos_pago` INT NOT NULL AUTO_INCREMENT,
  `Suscripciones_idSuscripciones` INT NOT NULL,
  `Suscripciones_Usuarios_idUsuarios` INT NOT NULL,
  `datos_fecha` DATETIME NOT NULL DEFAULT now(),
  `datos_num_tarjeta` VARCHAR(20) NULL,
  `datos_mes_cadu` INT NULL,
  `datos_any_cadu` INT NULL,
  `datos_cod_seg` INT NULL,
  `datos_usuario_paypal` VARCHAR(25) NULL,
  PRIMARY KEY (`iddatos_pago`),
  INDEX `fk_datos_pago_Suscripciones1_idx` (`Suscripciones_idSuscripciones` ASC, `Suscripciones_Usuarios_idUsuarios` ASC),
  CONSTRAINT `fk_datos_pago_Suscripciones1`
    FOREIGN KEY (`Suscripciones_idSuscripciones` , `Suscripciones_Usuarios_idUsuarios`)
    REFERENCES `testm5n3`.`Suscripciones` (`idSuscripciones` , `Usuarios_idUsuarios`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

insert into datos_pago values
(default,1,1,'2020/12/17','1233-444',10,2021,1234,null),
(default,2,3,'2000/12/18',null,null,null,null,'usuar_pay'),
(default,2,3,'2020/12/18',null,null,null,null,'usuar_pay');
-- -----------------------------------------------------
-- Table `testm5n3`.`Play_list`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `testm5n3`.`Play_list` ;

CREATE TABLE IF NOT EXISTS `testm5n3`.`Play_list` (
  `idPlay_list` INT NOT NULL AUTO_INCREMENT,
  `Play_list_titulo` VARCHAR(45) NOT NULL,
  `Play_list_activa` TINYINT(1) NOT NULL,
  `Play_lis_creada` DATE NULL,
  `Play_list_` VARCHAR(45) NULL,
  PRIMARY KEY (`idPlay_list`))
ENGINE = InnoDB;

insert into Play_list values
(default,'play list 1',1,'2020/12/20',default),
(default,'play list 2',1,'2019/12/20',default),
(default,'play list 3',0,'2020/12/20',default),
(default,'play list 4',1,'2018/12/20',default);


-- -----------------------------------------------------
-- Table `testm5n3`.`Usuarios_has_Play_list`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `testm5n3`.`Usuarios_has_Play_list` ;

CREATE TABLE IF NOT EXISTS `testm5n3`.`Usuarios_has_Play_list` (
  `Usuarios_idUsuarios` INT NOT NULL,
  `Play_list_idPlay_list` INT NOT NULL,
  `Play_incluida` DATE NOT NULL,
  `Play_eliminada` DATE NULL,
  PRIMARY KEY (`Usuarios_idUsuarios`, `Play_list_idPlay_list`),
  INDEX `fk_Usuarios_has_Play_list_Play_list1_idx` (`Play_list_idPlay_list` ASC),
  INDEX `fk_Usuarios_has_Play_list_Usuarios1_idx` (`Usuarios_idUsuarios` ASC),
  CONSTRAINT `fk_Usuarios_has_Play_list_Usuarios1`
    FOREIGN KEY (`Usuarios_idUsuarios`)
    REFERENCES `testm5n3`.`Usuarios` (`idUsuarios`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Usuarios_has_Play_list_Play_list1`
    FOREIGN KEY (`Play_list_idPlay_list`)
    REFERENCES `testm5n3`.`Play_list` (`idPlay_list`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

insert into Usuarios_has_Play_list values
(1,1,now(),null),
(1,2,now(),null),
(2,3,now(),null),
(3,4,now(),null);

-- -----------------------------------------------------
-- Table `testm5n3`.`Artista`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `testm5n3`.`Artista` ;

CREATE TABLE IF NOT EXISTS `testm5n3`.`Artista` (
  `idArtista` INT NOT NULL AUTO_INCREMENT,
  `Artista_nombre` VARCHAR(45) NULL,
  `Artista_imagen` BLOB NULL,
  `Artista_relacion_idArtista` INT NULL,
  PRIMARY KEY (`idArtista`),
  INDEX `fk_Artista_Artista1_idx` (`Artista_relacion_idArtista` ASC),
  CONSTRAINT `fk_Artista_Artista1`
    FOREIGN KEY (`Artista_relacion_idArtista`)
    REFERENCES `testm5n3`.`Artista` (`idArtista`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


insert into Artista values
(default, 'artista 1',NULL,null) ;
insert into Artista values
(default, 'artista 2',NULL,1); 

-- -----------------------------------------------------
-- Table `testm5n3`.`Albun`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `testm5n3`.`Albun` ;

CREATE TABLE IF NOT EXISTS `testm5n3`.`Albun` (
  `idAlbun` INT NOT NULL AUTO_INCREMENT,
  `Albun_titulo` VARCHAR(45) NULL,
  `Albun_publicado` DATE NULL,
  `Albun_imagen` BLOB NULL,
  `Artista_idArtista` INT NOT NULL,
  PRIMARY KEY (`idAlbun`),
  INDEX `fk_Albun_Artista1_idx` (`Artista_idArtista` ASC),
  CONSTRAINT `fk_Albun_Artista1`
    FOREIGN KEY (`Artista_idArtista`)
    REFERENCES  `testm5n3`.`Artista` (`idArtista`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

insert into Albun values
(default,'titulo 1','1981/02/22',null,1),
(default,'titulo 2','1991/02/22',null,2);


-- -----------------------------------------------------
-- Table `testm5n3`.`canciones`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `testm5n3`.`canciones` ;

CREATE TABLE IF NOT EXISTS `testm5n3`.`canciones` (
  `idcanciones` INT NOT NULL AUTO_INCREMENT,
  `cancion_nombre` VARCHAR(45) NULL,
  `cancion_duración` FLOAT NULL,
  `contador_reproducciones` INT NULL,
  `Albun_idAlbun` INT NOT NULL,
  PRIMARY KEY (`idcanciones`),
  INDEX `fk_canciones_Albun1_idx` (`Albun_idAlbun` ASC),
  CONSTRAINT `fk_canciones_Albun1`
    FOREIGN KEY (`Albun_idAlbun`)
    REFERENCES `testm5n3`.`Albun` (`idAlbun`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

insert into canciones values
(default,'cancion 1',12,1,1),
(default,'cancion 2',22,default,1),
(default,'cancion 3',32,default,1),
(default,'cancion 1',20,default,2);
-- -----------------------------------------------------
-- Table `testm5n3`.`Play_list_has_canciones`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `testm5n3`.`Play_list_has_canciones` ;

CREATE TABLE IF NOT EXISTS `testm5n3`.`Play_list_has_canciones` (
  `Play_list_idPlay_list` INT NOT NULL,
  `canciones_idcanciones` INT NOT NULL,
  `Usuarios_idUsuarios_addiciona` INT NOT NULL,
  `Play_list_has_canciones_fecha` DATETIME NULL DEFAULT now(),
  PRIMARY KEY (`Play_list_idPlay_list`, `canciones_idcanciones`),
  INDEX `fk_Play_list_has_canciones_canciones1_idx` (`canciones_idcanciones` ASC),
  INDEX `fk_Play_list_has_canciones_Play_list1_idx` (`Play_list_idPlay_list` ASC),
  INDEX `fk_Play_list_has_canciones_Usuarios1_idx` (`Usuarios_idUsuarios_addiciona` ASC),
  CONSTRAINT `fk_Play_list_has_canciones_Play_list1`
    FOREIGN KEY (`Play_list_idPlay_list`)
    REFERENCES `testm5n3`.`Play_list` (`idPlay_list`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Play_list_has_canciones_canciones1`
    FOREIGN KEY (`canciones_idcanciones`)
    REFERENCES `testm5n3`.`canciones` (`idcanciones`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Play_list_has_canciones_Usuarios1`
    FOREIGN KEY (`Usuarios_idUsuarios_addiciona`)
    REFERENCES `testm5n3`.`Usuarios` (`idUsuarios`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

insert into Play_list_has_canciones values
(1,1,1,default),
(1,2,2,default),
(2,1,3,default),
(3,3,1,default),
(4,4,4,default);

-- -----------------------------------------------------
-- Table `testm5n3`.`Usuarios_sigue_Artista`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `testm5n3`.`Usuarios_sigue_Artista` ;

CREATE TABLE IF NOT EXISTS `testm5n3`.`Usuarios_sigue_Artista` (
  `Usuarios_idUsuarios` INT NOT NULL,
  `Artista_idArtista` INT NOT NULL,
  PRIMARY KEY (`Usuarios_idUsuarios`, `Artista_idArtista`),
  INDEX `fk_Usuarios_has_Artista_Artista1_idx` (`Artista_idArtista` ASC),
  INDEX `fk_Usuarios_has_Artista_Usuarios1_idx` (`Usuarios_idUsuarios` ASC),
  CONSTRAINT `fk_Usuarios_has_Artista_Usuarios1`
    FOREIGN KEY (`Usuarios_idUsuarios`)
    REFERENCES `testm5n3`.`Usuarios` (`idUsuarios`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Usuarios_has_Artista_Artista1`
    FOREIGN KEY (`Artista_idArtista`)
    REFERENCES `testm5n3`.`Artista` (`idArtista`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

insert into Usuarios_sigue_Artista values
(1,2),
(2,2),
(3,1);

-- -----------------------------------------------------
-- Table `testm5n3`.`Usuarios_favoritos_Albun`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `testm5n3`.`Usuarios_favoritos_Albun` ;

CREATE TABLE IF NOT EXISTS `testm5n3`.`Usuarios_favoritos_Albun` (
  `Usuarios_idUsuarios` INT NOT NULL,
  `Albun_idAlbun` INT NOT NULL,
  PRIMARY KEY (`Usuarios_idUsuarios`, `Albun_idAlbun`),
  INDEX `fk_Usuarios_has_Albun_Albun1_idx` (`Albun_idAlbun` ASC),
  INDEX `fk_Usuarios_has_Albun_Usuarios1_idx` (`Usuarios_idUsuarios` ASC),
  CONSTRAINT `fk_Usuarios_has_Albun_Usuarios1`
    FOREIGN KEY (`Usuarios_idUsuarios`)
    REFERENCES `testm5n3`.`Usuarios` (`idUsuarios`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Usuarios_has_Albun_Albun1`
    FOREIGN KEY (`Albun_idAlbun`)
    REFERENCES `testm5n3`.`Albun` (`idAlbun`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

insert into Usuarios_favoritos_Albun values
(1,1),
(2,1),
(3,2);

-- -----------------------------------------------------
-- Table `testm5n3`.`Usuarios_favoritos_canciones`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `testm5n3`.`Usuarios_favoritos_canciones` ;

CREATE TABLE IF NOT EXISTS `testm5n3`.`Usuarios_favoritos_canciones` (
  `Usuarios_idUsuarios` INT NOT NULL,
  `canciones_idcanciones` INT NOT NULL,
  PRIMARY KEY (`Usuarios_idUsuarios`, `canciones_idcanciones`),
  INDEX `fk_Usuarios_has_canciones_canciones1_idx` (`canciones_idcanciones` ASC),
  INDEX `fk_Usuarios_has_canciones_Usuarios1_idx` (`Usuarios_idUsuarios` ASC),
  CONSTRAINT `fk_Usuarios_has_canciones_Usuarios1`
    FOREIGN KEY (`Usuarios_idUsuarios`)
    REFERENCES `testm5n3`.`Usuarios` (`idUsuarios`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Usuarios_has_canciones_canciones1`
    FOREIGN KEY (`canciones_idcanciones`)
    REFERENCES `testm5n3`.`canciones` (`idcanciones`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

insert into Usuarios_favoritos_canciones values
(1,1),
(1,2),
(2,1),
(3,4);

SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
