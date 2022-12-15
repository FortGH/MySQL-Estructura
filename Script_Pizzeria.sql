-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema mydb
-- -----------------------------------------------------
-- -----------------------------------------------------
-- Schema pizzeria_1
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema pizzeria_1
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `pizzeria` DEFAULT CHARACTER SET utf8 ;
USE `pizzeria` ;

-- -----------------------------------------------------
-- Table `pizzeria_1`.`cliente`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `pizzeria`.`cliente` (
  `id` INT(11) NOT NULL AUTO_INCREMENT,
  `nombre` VARCHAR(45) NOT NULL,
  `apellido1` VARCHAR(45) NOT NULL,
  `apellido2` VARCHAR(45) NOT NULL,
  `calle` VARCHAR(45) NOT NULL,
  `nº_calle` VARCHAR(45) NOT NULL,
  `piso` VARCHAR(45) NULL DEFAULT NULL,
  `puerta` VARCHAR(45) NULL DEFAULT NULL,
  `codigo_postal` INT(11) NOT NULL,
  `localidad` VARCHAR(45) NOT NULL,
  `provincia` VARCHAR(45) NOT NULL,
  `telefono` INT(9) NOT NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `pizzeria_1`.`pizza_categoria`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `pizzeria`.`pizza_categoria` (
  ` id` INT(11) NOT NULL AUTO_INCREMENT,
  `nombre` VARCHAR(45) NOT NULL,
  PRIMARY KEY (` id`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `pizzeria_1`.`pedido`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `pizzeria`.`pedido` (
  `id` INT(11) NOT NULL AUTO_INCREMENT,
  `cliente_id` INT(11) NOT NULL,
  `fecha_hora` DATETIME NOT NULL,
  `precio_total` FLOAT(6,2) NOT NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_pedido_cliente_idx` (`cliente_id` ASC),
  CONSTRAINT `fk_pedido_cliente`
    FOREIGN KEY (`cliente_id`)
    REFERENCES `pizzeria`.`cliente` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `pizzeria_1`.`producto`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `pizzeria`.`producto` (
  `id` INT(11) NOT NULL AUTO_INCREMENT,
  `nombre` VARCHAR(45) NOT NULL,
  `descripcion` VARCHAR(200) NULL DEFAULT NULL,
  `imagen` BLOB NULL DEFAULT NULL,
  `tipo` ENUM('hamburguesa', 'pizza', 'bebida') NOT NULL,
  `precio` FLOAT(6,2) NOT NULL,
  `pizza_categoria_ id` INT(11) NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_producto_pizza_categoria1_idx` (`pizza_categoria_ id` ASC) ,
  CONSTRAINT `fk_producto_pizza_categoria1`
    FOREIGN KEY (`pizza_categoria_ id`)
    REFERENCES `pizzeria`.`pizza_categoria` (` id`)
    ON DELETE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `pizzeria_1`.`tienda`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `pizzeria`.`tienda` (
  `id` INT(11) NOT NULL AUTO_INCREMENT,
  `calle` VARCHAR(45) NOT NULL,
  `nº_calle` VARCHAR(45) NOT NULL,
  `planta` VARCHAR(45) NULL DEFAULT NULL,
  `codigo_postal` INT(11) NOT NULL,
  `localidad` VARCHAR(45) NOT NULL,
  `provincia` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `pizzeria_1`.`empleado`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `pizzeria`.`empleado` (
  `id` INT(11) NOT NULL AUTO_INCREMENT,
  `nombre` VARCHAR(45) NOT NULL,
  `apellido1` VARCHAR(45) NOT NULL,
  `apellido2` VARCHAR(45) NULL DEFAULT NULL,
  `nif` VARCHAR(9) NOT NULL,
  `telefono` INT(9) NOT NULL,
  `tipo` ENUM('cocinero', 'repartidor') NULL DEFAULT NULL,
  `tienda_id` INT(11) NOT NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_empleado_tienda1_idx` (`tienda_id` ASC),
  CONSTRAINT `fk_empleado_tienda1`
    FOREIGN KEY (`tienda_id`)
    REFERENCES `pizzeria`.`tienda` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `pizzeria_1`.`detalle_pedido`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `pizzeria`.`detalle_pedido` (
  `pedido_id` INT(11) NOT NULL,
  `producto_id` INT(11) NOT NULL,
  `pizza_categoria_ id` INT(11) NULL DEFAULT NULL,
  `cantidad` INT(11) NOT NULL,
  `tipo_pedido` ENUM('tienda', 'delivery') NOT NULL,
  `fecha_hora entrega` DATETIME NULL DEFAULT NULL,
  `empleado_id` INT(11) NULL DEFAULT NULL,
  PRIMARY KEY (`pedido_id`, `producto_id`),
  INDEX `fk_detalle_pedido_categoria1_idx` (`pizza_categoria_ id` ASC) ,
  INDEX `fk_detalle_pedido_pedido1_idx` (`pedido_id` ASC) ,
  INDEX `fk_detalle_pedido_producto1` (`producto_id` ASC) ,
  INDEX `fk_detalle_pedido_empleado1_idx` (`empleado_id` ASC) ,
  CONSTRAINT `fk_detalle_pedido_categoria1`
    FOREIGN KEY (`pizza_categoria_ id`)
    REFERENCES `pizzeria`.`pizza_categoria` (` id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_detalle_pedido_pedido1`
    FOREIGN KEY (`pedido_id`)
    REFERENCES `pizzeria`.`pedido` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_detalle_pedido_producto1`
    FOREIGN KEY (`producto_id`)
    REFERENCES `pizzeria`.`producto` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_detalle_pedido_empleado1`
    FOREIGN KEY (`empleado_id`)
    REFERENCES `pizzeria`.`empleado` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
