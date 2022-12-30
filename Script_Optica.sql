-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema mydb
-- -----------------------------------------------------
-- -----------------------------------------------------
-- Schema optica
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema optica
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `optica` DEFAULT CHARACTER SET utf8mb4 ;
USE `optica` ;

-- -----------------------------------------------------
-- Table `optica`.`cliente`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `optica`.`cliente` (
  `id` INT(11) NOT NULL AUTO_INCREMENT,
  `nombre` VARCHAR(45) NOT NULL,
  `apellido1` VARCHAR(45) NOT NULL,
  `apellido2` VARCHAR(45) NOT NULL,
  `codigo_postal` VARCHAR(10) NULL DEFAULT NULL,
  `telefono` INT(20) NOT NULL,
  `email` VARCHAR(45) NOT NULL,
  `fecha_registro` DATE NOT NULL,
  `cliente_id_recomendo` INT(11) NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_cliente_cliente1_idx` (`cliente_id_recomendo` ASC),
  CONSTRAINT `fk_cliente_cliente1`
    FOREIGN KEY (`cliente_id_recomendo`)
    REFERENCES `optica`.`cliente` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4;


-- -----------------------------------------------------
-- Table `optica`.`empleado`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `optica`.`empleado` (
  `id` INT(11) NOT NULL AUTO_INCREMENT,
  `nombre` VARCHAR(45) NOT NULL,
  `apellido1` VARCHAR(45) NOT NULL,
  `apellido2` VARCHAR(45) NOT NULL,
  `telefono` INT(20) NOT NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4;


-- -----------------------------------------------------
-- Table `optica`.`proveedor`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `optica`.`proveedor` (
  `id` INT(11) NOT NULL AUTO_INCREMENT,
  `nombre` VARCHAR(45) NOT NULL,
  `telefono` INT(20) NOT NULL,
  `fax` INT(20) NULL DEFAULT NULL,
  `nif` VARCHAR(9) NOT NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4;


-- -----------------------------------------------------
-- Table `optica`.`marca`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `optica`.`marca` (
  `id` INT(11) NOT NULL AUTO_INCREMENT,
  `nombre` VARCHAR(45) NOT NULL,
  `proveedor_id` INT(11) NOT NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_marca_proveedor1_idx` (`proveedor_id` ASC),
  CONSTRAINT `fk_marca_proveedor1`
    FOREIGN KEY (`proveedor_id`)
    REFERENCES `optica`.`proveedor` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4;


-- -----------------------------------------------------
-- Table `optica`.`gafas`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `optica`.`gafas` (
  `id` INT(11) NOT NULL AUTO_INCREMENT,
  `graduacion_vidrio_der` FLOAT(3,2) NULL DEFAULT NULL,
  `graduacion_vidrio_izq` FLOAT(3,2) NULL DEFAULT NULL,
  `tipo_montura` ENUM('flotante', 'pasta', 'metalica') NOT NULL,
  `color_montura` VARCHAR(60) NOT NULL,
  `color_vidrio_der` VARCHAR(45) NULL DEFAULT NULL,
  `color_vidrio_izq` VARCHAR(45) NULL DEFAULT NULL,
  `precio` FLOAT(8,2) NOT NULL,
  `marca_id` INT(11) NOT NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_gafas_marca1_idx` (`marca_id` ASC),
  CONSTRAINT `fk_gafas_marca1`
    FOREIGN KEY (`marca_id`)
    REFERENCES `optica`.`marca` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4;


-- -----------------------------------------------------
-- Table `optica`.`venta`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `optica`.`venta` (
  `id` INT(11) NOT NULL AUTO_INCREMENT,
  `fecha` DATE NOT NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4;


-- -----------------------------------------------------
-- Table `optica`.`detalle_venta`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `optica`.`detalle_venta` (
  `venta_id` INT(11) NOT NULL,
  `empleado_id` INT(11) NOT NULL,
  `cliente_id` INT(11) NOT NULL,
  `gafas_id` INT(11) NOT NULL,
  PRIMARY KEY (`venta_id`, `empleado_id`, `cliente_id`, `gafas_id`),
  UNIQUE INDEX `venta_id_UNIQUE` (`venta_id` ASC),
  INDEX `fk_detalle_venta_empleado1_idx` (`empleado_id` ASC),
  INDEX `fk_detalle_venta_cliente1_idx` (`cliente_id` ASC),
  INDEX `fk_detalle_venta_venta1_idx` (`venta_id` ASC),
  INDEX `fk_detalle_venta_gafas1_idx` (`gafas_id` ASC),
  CONSTRAINT `fk_detalle_venta_cliente1`
    FOREIGN KEY (`cliente_id`)
    REFERENCES `optica`.`cliente` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_detalle_venta_empleado1`
    FOREIGN KEY (`empleado_id`)
    REFERENCES `optica`.`empleado` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_detalle_venta_gafas1`
    FOREIGN KEY (`gafas_id`)
    REFERENCES `optica`.`gafas` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_detalle_venta_venta1`
    FOREIGN KEY (`venta_id`)
    REFERENCES `optica`.`venta` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4;


-- -----------------------------------------------------
-- Table `optica`.`direccion_provedor`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `optica`.`direccion_provedor` (
  `proveedor_id` INT(11) NOT NULL,
  `calle` VARCHAR(45) NOT NULL,
  `numero` INT(11) NOT NULL,
  `piso` VARCHAR(45) NULL DEFAULT NULL,
  `puerta` VARCHAR(45) NULL DEFAULT NULL,
  `ciudad` VARCHAR(45) NOT NULL,
  `codigo_postal` VARCHAR(10) NOT NULL,
  `pais` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`proveedor_id`),
  CONSTRAINT `fk_direccion_provedor_proveedor1`
    FOREIGN KEY (`proveedor_id`)
    REFERENCES `optica`.`proveedor` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
