-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema Optica
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema Optica
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `Optica` DEFAULT CHARACTER SET utf8mb4 ;
-- -----------------------------------------------------
-- Schema sql_store
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema sql_store
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `sql_store` DEFAULT CHARACTER SET utf8mb4 ;
USE `Optica` ;

-- -----------------------------------------------------
-- Table `Optica`.`proveedor`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Optica`.`proveedor` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `nombre` VARCHAR(45) NOT NULL,
  `telefono` INT(9) NOT NULL,
  `fax` INT NULL,
  `nif` VARCHAR(9) NOT NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Optica`.`marca`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Optica`.`marca` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `nombre` VARCHAR(45) NOT NULL,
  `proveedor_id` INT NOT NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_marca_proveedor1_idx` (`proveedor_id` ASC),
  CONSTRAINT `fk_marca_proveedor1`
    FOREIGN KEY (`proveedor_id`)
    REFERENCES `Optica`.`proveedor` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Optica`.`gafas`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Optica`.`gafas` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `graduacion_vidrio_der` FLOAT NULL,
  `graduacion_vidrio_izq` FLOAT NULL,
  `tipo_montura` ENUM('flotante', 'pasta', 'metalica') NOT NULL,
  `color_montura` VARCHAR(60) NOT NULL,
  `color_vidrio_der` VARCHAR(45) NULL,
  `color_vidrio_izq` VARCHAR(45) NULL,
  `precio` FLOAT(8,2) NOT NULL,
  `marca_id` INT NOT NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_gafas_marca1_idx` (`marca_id` ASC),
  CONSTRAINT `fk_gafas_marca1`
    FOREIGN KEY (`marca_id`)
    REFERENCES `Optica`.`marca` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4;


-- -----------------------------------------------------
-- Table `Optica`.`cliente`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Optica`.`cliente` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `nombre` VARCHAR(45) NOT NULL,
  `apellido1` VARCHAR(45) NOT NULL,
  `apellido2` VARCHAR(45) NOT NULL,
  `codigo_postal` INT NULL,
  `telefono` INT NOT NULL,
  `email` VARCHAR(45) NOT NULL,
  `fecha_registro` DATE NOT NULL,
  `cliente_id` INT NOT NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_cliente_cliente1_idx` (`cliente_id` ASC),
  CONSTRAINT `fk_cliente_cliente1`
    FOREIGN KEY (`cliente_id`)
    REFERENCES `Optica`.`cliente` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Optica`.`empleado`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Optica`.`empleado` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `nombre` VARCHAR(45) NOT NULL,
  `apellido1` VARCHAR(45) NOT NULL,
  `apellido2` VARCHAR(45) NOT NULL,
  `telefono` INT(9) NOT NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Optica`.`direccion_provedor`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Optica`.`direccion_provedor` (
  `calle` VARCHAR(45) NOT NULL,
  `numero` INT NOT NULL,
  `piso` VARCHAR(45) NULL,
  `puerta` VARCHAR(45) NULL,
  `ciudad` VARCHAR(45) NOT NULL,
  `codigo_postal` INT NOT NULL,
  `pais` VARCHAR(45) NOT NULL,
  `proveedor_id` INT NOT NULL,
  PRIMARY KEY (`proveedor_id`),
  CONSTRAINT `fk_direccion_provedor_proveedor1`
    FOREIGN KEY (`proveedor_id`)
    REFERENCES `Optica`.`proveedor` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Optica`.`venta`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Optica`.`venta` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `fecha` DATE NOT NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Optica`.`detalle_venta`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Optica`.`detalle_venta` (
  `empleado_id` INT NOT NULL,
  `cliente_id` INT NOT NULL,
  `venta_id` INT NOT NULL,
  `gafas_id` INT NOT NULL,
  PRIMARY KEY (`empleado_id`, `cliente_id`, `venta_id`, `gafas_id`),
  INDEX `fk_detalle_venta_empleado1_idx` (`empleado_id` ASC) ,
  INDEX `fk_detalle_venta_cliente1_idx` (`cliente_id` ASC),
  INDEX `fk_detalle_venta_venta1_idx` (`venta_id` ASC),
  INDEX `fk_detalle_venta_gafas1_idx` (`gafas_id` ASC) ,
  CONSTRAINT `fk_detalle_venta_empleado1`
    FOREIGN KEY (`empleado_id`)
    REFERENCES `Optica`.`empleado` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_detalle_venta_cliente1`
    FOREIGN KEY (`cliente_id`)
    REFERENCES `Optica`.`cliente` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_detalle_venta_venta1`
    FOREIGN KEY (`venta_id`)
    REFERENCES `Optica`.`venta` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_detalle_venta_gafas1`
    FOREIGN KEY (`gafas_id`)
    REFERENCES `Optica`.`gafas` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
