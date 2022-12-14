-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema Youtube
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema Youtube
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `Youtube` DEFAULT CHARACTER SET utf8 ;
USE `Youtube` ;

-- -----------------------------------------------------
-- Table `Youtube`.`usuario`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Youtube`.`usuario` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `email` VARCHAR(45) NOT NULL,
  `password` VARCHAR(45) NOT NULL,
  `nombre_usuario` VARCHAR(45) NOT NULL,
  `fecha_nacimiento` DATE NOT NULL,
  `sexo` ENUM('F', 'M') NOT NULL,
  `codigo_postal` INT NOT NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Youtube`.`video`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Youtube`.`video` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `titulo` VARCHAR(45) NOT NULL,
  `descripcion` VARCHAR(500) NOT NULL,
  `tamaño_mb` INT NOT NULL,
  `nombre_archivo_video` VARCHAR(45) NOT NULL,
  `duracion_video` INT NOT NULL,
  `thumbnail` BLOB NOT NULL,
  `nº_reproducciones` INT NOT NULL,
  `nº_likes` INT NOT NULL,
  `nº_dislikes` INT NOT NULL,
  `estado` ENUM('publico', 'oculto', 'privado') NOT NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Youtube`.`etiqueta`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Youtube`.`etiqueta` (
  `id` INT NOT NULL,
  `nombre` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Youtube`.`video_tiene_etiqueta`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Youtube`.`video_tiene_etiqueta` (
  `etiqueta_id` INT NOT NULL,
  `video_id` INT NOT NULL,
  PRIMARY KEY (`etiqueta_id`, `video_id`),
  INDEX `fk_etiqueta_has_video_video1_idx` (`video_id` ASC) ,
  INDEX `fk_etiqueta_has_video_etiqueta1_idx` (`etiqueta_id` ASC) ,
  CONSTRAINT `fk_etiqueta_has_video_etiqueta1`
    FOREIGN KEY (`etiqueta_id`)
    REFERENCES `Youtube`.`etiqueta` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_etiqueta_has_video_video1`
    FOREIGN KEY (`video_id`)
    REFERENCES `Youtube`.`video` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Youtube`.`usuario_publica_video`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Youtube`.`usuario_publica_video` (
  `usuario_id` INT NOT NULL,
  `video_id` INT NOT NULL,
  `fecha_hora` DATETIME NOT NULL,
  PRIMARY KEY (`usuario_id`, `video_id`),
  INDEX `fk_usuario_publica_video_video1_idx` (`video_id` ASC),
  CONSTRAINT `fk_usuario_publica_video_usuario1`
    FOREIGN KEY (`usuario_id`)
    REFERENCES `Youtube`.`usuario` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_usuario_publica_video_video1`
    FOREIGN KEY (`video_id`)
    REFERENCES `Youtube`.`video` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Youtube`.`canal`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Youtube`.`canal` (
  `id` INT NOT NULL,
  `nombre` VARCHAR(45) NOT NULL,
  `descripcion` VARCHAR(45) NOT NULL,
  `fecha_creacion` DATE NOT NULL,
  `usuario_id` INT NOT NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_canal_usuario1_idx` (`usuario_id` ASC),
  CONSTRAINT `fk_canal_usuario1`
    FOREIGN KEY (`usuario_id`)
    REFERENCES `Youtube`.`usuario` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Youtube`.`usuario_suscribe_canal`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Youtube`.`usuario_suscribe_canal` (
  `canal_id` INT NOT NULL,
  `usuario_id` INT NOT NULL,
  PRIMARY KEY (`canal_id`, `usuario_id`),
  INDEX `fk_canal_has_usuario_usuario1_idx` (`usuario_id` ASC) ,
  INDEX `fk_canal_has_usuario_canal1_idx` (`canal_id` ASC) ,
  CONSTRAINT `fk_canal_has_usuario_canal1`
    FOREIGN KEY (`canal_id`)
    REFERENCES `Youtube`.`canal` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_canal_has_usuario_usuario1`
    FOREIGN KEY (`usuario_id`)
    REFERENCES `Youtube`.`usuario` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Youtube`.`usuario_like_dislike_video`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Youtube`.`usuario_like_dislike_video` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `usuario_id` INT NOT NULL,
  `video_id` INT NOT NULL,
  `like_dislike` ENUM('like', 'dislike') NOT NULL,
  `fecha_hora` DATETIME NOT NULL,
  PRIMARY KEY (`id`, `usuario_id`, `video_id`),
  INDEX `fk_usuario_has_video_video1_idx` (`video_id` ASC),
  INDEX `fk_usuario_has_video_usuario1_idx` (`usuario_id` ASC) ,
  CONSTRAINT `fk_usuario_has_video_usuario1`
    FOREIGN KEY (`usuario_id`)
    REFERENCES `Youtube`.`usuario` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_usuario_has_video_video1`
    FOREIGN KEY (`video_id`)
    REFERENCES `Youtube`.`video` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Youtube`.`playlist`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Youtube`.`playlist` (
  `id` INT NOT NULL,
  `nombre` VARCHAR(45) NOT NULL,
  `fecha_creacion` DATE NOT NULL,
  `estado` ENUM('publica', 'privada') NOT NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Youtube`.`usuario_crea_playlist`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Youtube`.`usuario_crea_playlist` (
  `usuario_id` INT NOT NULL,
  `playlist_id` INT NOT NULL,
  PRIMARY KEY (`usuario_id`, `playlist_id`),
  INDEX `fk_usuario_has_playlist_playlist1_idx` (`playlist_id` ASC) ,
  INDEX `fk_usuario_has_playlist_usuario1_idx` (`usuario_id` ASC) ,
  CONSTRAINT `fk_usuario_has_playlist_usuario1`
    FOREIGN KEY (`usuario_id`)
    REFERENCES `Youtube`.`usuario` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_usuario_has_playlist_playlist1`
    FOREIGN KEY (`playlist_id`)
    REFERENCES `Youtube`.`playlist` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Youtube`.`comentario`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Youtube`.`comentario` (
  `id` INT NOT NULL,
  `usuario_id` INT NOT NULL,
  `video_id` INT NOT NULL,
  `texto_comentario` VARCHAR(500) NOT NULL,
  `fecha_hora` DATETIME NOT NULL,
  PRIMARY KEY (`id`, `usuario_id`, `video_id`),
  INDEX `fk_comentario_usuario1_idx` (`usuario_id` ASC) ,
  INDEX `fk_comentario_video1_idx` (`video_id` ASC) ,
  CONSTRAINT `fk_comentario_usuario1`
    FOREIGN KEY (`usuario_id`)
    REFERENCES `Youtube`.`usuario` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_comentario_video1`
    FOREIGN KEY (`video_id`)
    REFERENCES `Youtube`.`video` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Youtube`.`usuario_like_dislike_comentario`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Youtube`.`usuario_like_dislike_comentario` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `usuario_id` INT NOT NULL,
  `comentario_video_id` INT NOT NULL,
  `comentario_id` INT NOT NULL,
  `comentario_usuario_id` INT NOT NULL,
  `like_dislike` ENUM('like', 'dislike') NOT NULL,
  `fecha_hora` DATETIME NOT NULL,
  PRIMARY KEY (`id`, `usuario_id`, `comentario_video_id`, `comentario_id`, `comentario_usuario_id`),
  INDEX `fk_usuario_has_video_usuario1_idx` (`usuario_id` ASC) ,
  INDEX `fk_coemtario_like_dislike_comentario1_idx` (`comentario_id` ASC, `comentario_usuario_id` ASC, `comentario_video_id` ASC) ,
  CONSTRAINT `fk_usuario_has_video_usuario10`
    FOREIGN KEY (`usuario_id`)
    REFERENCES `Youtube`.`usuario` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_coemtario_like_dislike_comentario1`
    FOREIGN KEY (`comentario_id` , `comentario_usuario_id` , `comentario_video_id`)
    REFERENCES `Youtube`.`comentario` (`id` , `usuario_id` , `video_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
