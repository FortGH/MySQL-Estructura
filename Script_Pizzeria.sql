SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema pizzeria
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema pizzeria
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `pizzeria` DEFAULT CHARACTER SET utf8 ;
USE `pizzeria` ;

-- -----------------------------------------------------
-- Table `pizzeria`.`cliente`
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
  `codigo_postal` VARCHAR(10) NOT NULL,
  `localidad` VARCHAR(45) NOT NULL,
  `provincia` VARCHAR(45) NOT NULL,
  `telefono` INT(20) NOT NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `pizzeria`.`tienda`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `pizzeria`.`tienda` (
  `id` INT(11) NOT NULL AUTO_INCREMENT,
  `calle` VARCHAR(45) NOT NULL,
  `nº_calle` VARCHAR(45) NOT NULL,
  `planta` VARCHAR(45) NULL DEFAULT NULL,
  `codigo_postal` VARCHAR(10) NOT NULL,
  `localidad` VARCHAR(45) NOT NULL,
  `provincia` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `pizzeria`.`empleado`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `pizzeria`.`empleado` (
  `id` INT(11) NOT NULL AUTO_INCREMENT,
  `nombre` VARCHAR(45) NOT NULL,
  `apellido1` VARCHAR(45) NOT NULL,
  `apellido2` VARCHAR(45) NULL DEFAULT NULL,
  `nif` VARCHAR(9) NOT NULL,
  `telefono` INT(20) NOT NULL,
  `tipo` ENUM('cocinero', 'repartidor') NULL DEFAULT NULL,
  `tienda_id` INT(11) NOT NULL,
  PRIMARY KEY (`id`, `tienda_id`),
  INDEX `fk_empleado_tienda1_idx` (`tienda_id` ASC),
  CONSTRAINT `fk_empleado_tienda1`
    FOREIGN KEY (`tienda_id`)
    REFERENCES `pizzeria`.`tienda` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `pizzeria`.`detalle_delivery`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `pizzeria`.`detalle_delivery` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `empleado_id` INT(11) NOT NULL,
  `fecha_hora_entrega` DATETIME NOT NULL,
  PRIMARY KEY (`id`, `empleado_id`),
  INDEX `fk_detalle_delivery_empleado1_idx` (`empleado_id` ASC),
  CONSTRAINT `fk_detalle_delivery_empleado1`
    FOREIGN KEY (`empleado_id`)
    REFERENCES `pizzeria`.`empleado` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `pizzeria`.`pedido`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `pizzeria`.`pedido` (
  `id` INT(11) NOT NULL AUTO_INCREMENT,
  `cliente_id` INT(11) NOT NULL,
  `tienda_id` INT(11) NOT NULL,
   `fecha_hora` DATETIME NOT NULL,
  `tipo_pedido` ENUM('tienda', 'delivery') NOT NULL,
  `detalle_delivery_id` INT NULL DEFAULT NULL,
  PRIMARY KEY (`id`, `cliente_id`, `tienda_id`),
  INDEX `fk_pedido_cliente1_idx` (`cliente_id` ASC),
  INDEX `fk_pedido_tienda1_idx` (`tienda_id` ASC),
  INDEX `fk_pedido_detalle_delivery2_idx` (`detalle_delivery_id` ASC),
  CONSTRAINT `fk_pedido_cliente1`
    FOREIGN KEY (`cliente_id`)
    REFERENCES `pizzeria`.`cliente` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_pedido_tienda1`
    FOREIGN KEY (`tienda_id`)
    REFERENCES `pizzeria`.`tienda` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_pedido_detalle_delivery2`
    FOREIGN KEY (`detalle_delivery_id`)
    REFERENCES `pizzeria`.`detalle_delivery` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `pizzeria`.`pizza_categoria`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `pizzeria`.`pizza_categoria` (
  `id` INT(11) NOT NULL AUTO_INCREMENT,
  `nombre` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `pizzeria`.`tipo_producto`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `pizzeria`.`tipo_producto` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `nombre` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `pizzeria`.`producto`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `pizzeria`.`producto` (
  `id` INT(11) NOT NULL AUTO_INCREMENT,
  `nombre` VARCHAR(45) NOT NULL,
  `descripcion` VARCHAR(200) NULL DEFAULT NULL,
  `imagen` BLOB NULL DEFAULT NULL,
  `precio` FLOAT(6,2) NOT NULL,
  `tipo_producto_id` INT NOT NULL,
  `pizza_categoria_id` INT(11) NULL DEFAULT NULL,
  PRIMARY KEY (`id`, `tipo_producto_id`),
  INDEX `fk_producto_pizza_categoria1_idx` (`pizza_categoria_id` ASC) ,
  INDEX `fk_producto_tipo_producto1_idx` (`tipo_producto_id` ASC),
  CONSTRAINT `fk_producto_pizza_categoria1`
    FOREIGN KEY (`pizza_categoria_id`)
    REFERENCES `pizzeria`.`pizza_categoria` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_producto_tipo_producto1`
    FOREIGN KEY (`tipo_producto_id`)
    REFERENCES `pizzeria`.`tipo_producto` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `pizzeria`.`detalle_pedido`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `pizzeria`.`detalle_pedido` (
  `pedido_id` INT(11) NOT NULL,
  `producto_id` INT(11) NOT NULL,
  `tipo_producto_id` INT NOT NULL,
  `cantidad` INT(11) NOT NULL,
  `precio_unidad` FLOAT(6,2) NOT NULL,
  PRIMARY KEY (`pedido_id`, `producto_id`, `tipo_producto_id`),
  INDEX `fk_detalle_pedido_producto1_idx` (`producto_id` ASC),
  INDEX `fk_detalle_pedido_tipo_producto1_idx` (`tipo_producto_id` ASC),
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
  CONSTRAINT `fk_detalle_pedido_tipo_producto1`
    FOREIGN KEY (`tipo_producto_id`)
    REFERENCES `pizzeria`.`tipo_producto` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;