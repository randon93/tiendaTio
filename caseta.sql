-- MySQL Script generated by MySQL Workbench
-- Tue May 28 18:38:50 2019
-- Model: New Model    Version: 1.0
-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema mydb
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema mydb
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `mydb` DEFAULT CHARACTER SET utf8 ;
USE `mydb` ;

-- -----------------------------------------------------
-- Table `mydb`.`tipo_producto`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`tipo_producto` (
  `id_tipo_producto` INT NOT NULL,
  `tipo_producto` VARCHAR(45) NULL,
  PRIMARY KEY (`id_tipo_producto`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`proveedor`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`proveedor` (
  `id_proveedor` INT NOT NULL,
  `nombre_proveedor` VARCHAR(45) NULL,
  `entregas` DATETIME NULL,
  `tipo_producto_id_tipo_producto` INT NOT NULL,
  PRIMARY KEY (`id_proveedor`),
  INDEX `fk_proveedor_tipo_producto1_idx` (`tipo_producto_id_tipo_producto` ASC) VISIBLE,
  CONSTRAINT `fk_proveedor_tipo_producto1`
    FOREIGN KEY (`tipo_producto_id_tipo_producto`)
    REFERENCES `mydb`.`tipo_producto` (`id_tipo_producto`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`tienda`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`tienda` (
  `id_tienda` INT NOT NULL,
  `nombre` VARCHAR(45) NULL,
  `direccion` VARCHAR(45) NULL,
  `telefono` VARCHAR(45) NULL,
  PRIMARY KEY (`id_tienda`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`producto`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`producto` (
  `id_producto` INT NOT NULL,
  `nombre` VARCHAR(45) NULL,
  `precio` INT NULL,
  `tienda_id_tienda` INT NOT NULL,
  `tipo_producto_id_tipo_producto` INT NOT NULL,
  PRIMARY KEY (`id_producto`),
  INDEX `fk_producto_tienda1_idx` (`tienda_id_tienda` ASC) VISIBLE,
  INDEX `fk_producto_tipo_producto1_idx` (`tipo_producto_id_tipo_producto` ASC) VISIBLE,
  CONSTRAINT `fk_producto_tienda1`
    FOREIGN KEY (`tienda_id_tienda`)
    REFERENCES `mydb`.`tienda` (`id_tienda`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_producto_tipo_producto1`
    FOREIGN KEY (`tipo_producto_id_tipo_producto`)
    REFERENCES `mydb`.`tipo_producto` (`id_tipo_producto`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`bodega`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`bodega` (
  `id_bodega` INT NOT NULL,
  `cantidad` VARCHAR(45) NULL,
  `producto_id_producto` INT NOT NULL,
  PRIMARY KEY (`id_bodega`),
  INDEX `fk_bodega_producto1_idx` (`producto_id_producto` ASC) VISIBLE,
  CONSTRAINT `fk_bodega_producto1`
    FOREIGN KEY (`producto_id_producto`)
    REFERENCES `mydb`.`producto` (`id_producto`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`administrador`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`administrador` (
  `id_administrador` INT NOT NULL,
  `nombre` VARCHAR(45) NULL,
  `contraseña` INT NOT NULL,
  `tienda_id_tienda` INT NOT NULL,
  PRIMARY KEY (`id_administrador`),
  INDEX `fk_administrador_tienda1_idx` (`tienda_id_tienda` ASC) VISIBLE,
  CONSTRAINT `fk_administrador_tienda1`
    FOREIGN KEY (`tienda_id_tienda`)
    REFERENCES `mydb`.`tienda` (`id_tienda`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`caja`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`caja` (
  `id_caja` INT NOT NULL,
  `dinero_en_caja` INT NULL,
  `administrador_id_administrador` INT NOT NULL,
  PRIMARY KEY (`id_caja`),
  INDEX `fk_caja_administrador1_idx` (`administrador_id_administrador` ASC) VISIBLE,
  CONSTRAINT `fk_caja_administrador1`
    FOREIGN KEY (`administrador_id_administrador`)
    REFERENCES `mydb`.`administrador` (`id_administrador`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`dinero_cuenta`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`dinero_cuenta` (
  `id_dinero_cuenta` INT NOT NULL,
  `dinero_cuenta` INT NULL,
  `dinero_por_cobrar` INT NULL,
  `caja_id_caja` INT NOT NULL,
  PRIMARY KEY (`id_dinero_cuenta`),
  INDEX `fk_dinero_cuenta_caja1_idx` (`caja_id_caja` ASC) VISIBLE,
  CONSTRAINT `fk_dinero_cuenta_caja1`
    FOREIGN KEY (`caja_id_caja`)
    REFERENCES `mydb`.`caja` (`id_caja`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`cliente`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`cliente` (
  `id_cliente` INT NOT NULL,
  `nombre` VARCHAR(45) NULL,
  `telefono` VARCHAR(45) NULL,
  `cantidad creditol` INT NULL,
  PRIMARY KEY (`id_cliente`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`factura`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`factura` (
  `id_factura` INT NOT NULL,
  `total` VARCHAR(45) NULL,
  `caja_id_caja` INT NOT NULL,
  `cliente_id_cliente` INT NOT NULL,
  `producto_id_producto` INT NOT NULL,
  PRIMARY KEY (`id_factura`),
  INDEX `fk_factura_caja1_idx` (`caja_id_caja` ASC) VISIBLE,
  INDEX `fk_factura_cliente1_idx` (`cliente_id_cliente` ASC) VISIBLE,
  INDEX `fk_factura_producto1_idx` (`producto_id_producto` ASC) VISIBLE,
  CONSTRAINT `fk_factura_caja1`
    FOREIGN KEY (`caja_id_caja`)
    REFERENCES `mydb`.`caja` (`id_caja`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_factura_cliente1`
    FOREIGN KEY (`cliente_id_cliente`)
    REFERENCES `mydb`.`cliente` (`id_cliente`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_factura_producto1`
    FOREIGN KEY (`producto_id_producto`)
    REFERENCES `mydb`.`producto` (`id_producto`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`deuda`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`deuda` (
  `id_deuda` INT NOT NULL,
  `cantidad_pagar` INT NULL,
  `cliente_id_cliente` INT NOT NULL,
  PRIMARY KEY (`id_deuda`),
  INDEX `fk_deuda_cliente1_idx` (`cliente_id_cliente` ASC) VISIBLE,
  CONSTRAINT `fk_deuda_cliente1`
    FOREIGN KEY (`cliente_id_cliente`)
    REFERENCES `mydb`.`cliente` (`id_cliente`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`producto_proveedor`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`producto_proveedor` (
  `producto_id_producto` INT NOT NULL,
  `proveedor_id_proveedor` INT NOT NULL,
  PRIMARY KEY (`producto_id_producto`, `proveedor_id_proveedor`),
  INDEX `fk_producto_has_proveedor_proveedor1_idx` (`proveedor_id_proveedor` ASC) VISIBLE,
  INDEX `fk_producto_has_proveedor_producto_idx` (`producto_id_producto` ASC) VISIBLE,
  CONSTRAINT `fk_producto_has_proveedor_producto`
    FOREIGN KEY (`producto_id_producto`)
    REFERENCES `mydb`.`producto` (`id_producto`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_producto_has_proveedor_proveedor1`
    FOREIGN KEY (`proveedor_id_proveedor`)
    REFERENCES `mydb`.`proveedor` (`id_proveedor`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
