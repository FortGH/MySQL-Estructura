-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema Pizzeria
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema Pizzeria
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `Pizzeria` DEFAULT CHARACTER SET utf8 ;
USE `Pizzeria` ;

-- -----------------------------------------------------
-- Table `Pizzeria`.`cliente`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Pizzeria`.`cliente` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `nombre` VARCHAR(45) NOT NULL,
  `apellido1` VARCHAR(45) NOT NULL,
  `apellido2` VARCHAR(45) NOT NULL,
  `calle` VARCHAR(45) NOT NULL,
  `nº_calle` VARCHAR(45) NOT NULL,
  `piso` VARCHAR(45) NULL,
  `puerta` VARCHAR(45) NULL,
  `codigo_postal` INT NOT NULL,
  `localidad` VARCHAR(45) NOT NULL,
  `provincia` VARCHAR(45) NOT NULL,
  `telefono` INT(9) NOT NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Pizzeria`.`pedido`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Pizzeria`.`pedido` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `cliente_id` INT NOT NULL,
  `fecha_hora` DATETIME NOT NULL,
  `tipo` ENUM('tienda', 'domicilio') NOT NULL,
  `precio_total` FLOAT(6,2) NOT NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_pedido_cliente_idx` (`cliente_id` ASC),
  CONSTRAINT `fk_pedido_cliente`
    FOREIGN KEY (`cliente_id`)
    REFERENCES `Pizzeria`.`cliente` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Pizzeria`.`categoria`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Pizzeria`.`categoria` (
  ` id` INT NOT NULL,
  `nombre` VARCHAR(45) NULL,
  PRIMARY KEY (` id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Pizzeria`.`producto`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Pizzeria`.`producto` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `nombre` VARCHAR(45) NOT NULL,
  `descripcion` VARCHAR(200) NULL,
  `imagen` BLOB NULL,
  `precio` FLOAT(6,2) NOT NULL,
  `categoria_ id` INT NOT NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_producto_categoria1_idx` (`categoria_ id` ASC),
  CONSTRAINT `fk_producto_categoria1`
    FOREIGN KEY (`categoria_ id`)
    REFERENCES `Pizzeria`.`categoria` (` id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Pizzeria`.`tienda`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Pizzeria`.`tienda` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `calle` VARCHAR(45) NOT NULL,
  `nº_calle` VARCHAR(45) NOT NULL,
  `planta` VARCHAR(45) NULL,
  `codigo_postal` INT NOT NULL,
  `localidad` VARCHAR(45) NOT NULL,
  `provincia` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Pizzeria`.`empleado`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Pizzeria`.`empleado` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `nombre` VARCHAR(45) NOT NULL,
  `apellido1` VARCHAR(45) NOT NULL,
  `apellido2` VARCHAR(45) NULL,
  `nif` VARCHAR(9) NOT NULL,
  `telefono` INT(9) NOT NULL,
  `tipo` ENUM('cocinero', 'repartidor') NULL,
  `tienda_id` INT NOT NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_empleado_tienda1_idx` (`tienda_id` ASC),
  CONSTRAINT `fk_empleado_tienda1`
    FOREIGN KEY (`tienda_id`)
    REFERENCES `Pizzeria`.`tienda` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Pizzeria`.`detalle_pedido`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Pizzeria`.`detalle_pedido` (
  `pedido_id` INT NOT NULL,
  `producto_id` INT NOT NULL,
  `categoria_ id` INT NOT NULL,
  `cantidad` INT NOT NULL,
  `empleado_id` INT NOT NULL,
  `fecha_entrega` DATETIME NOT NULL,
  PRIMARY KEY (`pedido_id`, `producto_id`, `categoria_ id`, `empleado_id`),
  INDEX `fk_detalle_pedido_categoria1_idx` (`categoria_ id` ASC),
  INDEX `fk_detalle_pedido_pedido1_idx` (`pedido_id` ASC),
  INDEX `fk_detalle_pedido_empleado1_idx` (`empleado_id` ASC) ,
  CONSTRAINT `fk_detalle_pedido_producto1`
    FOREIGN KEY (`producto_id`)
    REFERENCES `Pizzeria`.`producto` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_detalle_pedido_categoria1`
    FOREIGN KEY (`categoria_ id`)
    REFERENCES `Pizzeria`.`categoria` (` id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_detalle_pedido_pedido1`
    FOREIGN KEY (`pedido_id`)
    REFERENCES `Pizzeria`.`pedido` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_detalle_pedido_empleado1`
    FOREIGN KEY (`empleado_id`)
    REFERENCES `Pizzeria`.`empleado` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
