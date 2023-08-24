-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema io_bank
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema io_bank
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `io_bank` DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci ;
USE `io_bank` ;

-- -----------------------------------------------------
-- Table `io_bank`.`producto`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `io_bank`.`producto` ;

CREATE TABLE IF NOT EXISTS `io_bank`.`producto` (
  `id_producto` INT NOT NULL,
  `nombre_producto` VARCHAR(45) NOT NULL,
  `tasa_interes_producto` FLOAT NOT NULL,
  `tipo_producto` INT NOT NULL,
  PRIMARY KEY (`id_producto`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `io_bank`.`tipo_usuario`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `io_bank`.`tipo_usuario` ;

CREATE TABLE IF NOT EXISTS `io_bank`.`tipo_usuario` (
  `id_tipo_usuario` INT NOT NULL,
  `descripcion_usuario` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`id_tipo_usuario`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `io_bank`.`usuario`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `io_bank`.`usuario` ;

CREATE TABLE IF NOT EXISTS `io_bank`.`usuario` (
  `id_usuario` INT NOT NULL,
  `documento_usuario` VARCHAR(45) NOT NULL,
  `tipo_documento_usuario` INT NOT NULL,
  `nombre_usuario` VARCHAR(45) NOT NULL,
  `tipo_usuario_id_tipo_usuario` INT NOT NULL,
  PRIMARY KEY (`id_usuario`),
  INDEX `fk_usuario_tipo_usuario1_idx` (`tipo_usuario_id_tipo_usuario` ASC) VISIBLE,
  CONSTRAINT `fk_usuario_tipo_usuario1`
    FOREIGN KEY (`tipo_usuario_id_tipo_usuario`)
    REFERENCES `io_bank`.`tipo_usuario` (`id_tipo_usuario`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `io_bank`.`cuenta`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `io_bank`.`cuenta` ;

CREATE TABLE IF NOT EXISTS `io_bank`.`cuenta` (
  `id_cuenta` INT NOT NULL,
  `saldo_cuenta` INT NOT NULL,
  `producto_id_producto` INT NOT NULL,
  `usuario_id_usuario` INT NOT NULL,
  PRIMARY KEY (`id_cuenta`),
  INDEX `fk_cuenta_producto_idx` (`producto_id_producto` ASC) VISIBLE,
  INDEX `fk_cuenta_usuario1_idx` (`usuario_id_usuario` ASC) VISIBLE,
  CONSTRAINT `fk_cuenta_producto`
    FOREIGN KEY (`producto_id_producto`)
    REFERENCES `io_bank`.`producto` (`id_producto`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_cuenta_usuario1`
    FOREIGN KEY (`usuario_id_usuario`)
    REFERENCES `io_bank`.`usuario` (`id_usuario`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `io_bank`.`tipo_movimiento`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `io_bank`.`tipo_movimiento` ;

CREATE TABLE IF NOT EXISTS `io_bank`.`tipo_movimiento` (
  `id_tipo_movimiento` INT NOT NULL,
  `nombre_tipo_movimiento` VARCHAR(45) NOT NULL,
  `producto_id_producto` INT NOT NULL,
  PRIMARY KEY (`id_tipo_movimiento`),
  INDEX `fk_tipo_movimiento_producto1_idx` (`producto_id_producto` ASC) VISIBLE,
  CONSTRAINT `fk_tipo_movimiento_producto1`
    FOREIGN KEY (`producto_id_producto`)
    REFERENCES `io_bank`.`producto` (`id_producto`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `io_bank`.`asesor`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `io_bank`.`asesor` ;

CREATE TABLE IF NOT EXISTS `io_bank`.`asesor` (
  `id_asesor` INT NOT NULL,
  `nombre_asesor` VARCHAR(45) NOT NULL,
  `documeto_asesor` VARCHAR(45) NOT NULL,
  `ubicacion_asesor` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`id_asesor`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `io_bank`.`movimiento`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `io_bank`.`movimiento` ;

CREATE TABLE IF NOT EXISTS `io_bank`.`movimiento` (
  `id_movimiento` INT NOT NULL,
  `monto_movimiento` FLOAT NOT NULL,
  `cuenta_id_cuenta` INT NOT NULL,
  `tipo_movimiento_id_tipo_movimiento` INT NOT NULL,
  `asesor_id_asesor` INT NOT NULL,
  `origen_movimiento` VARCHAR(45) NULL,
  PRIMARY KEY (`id_movimiento`),
  INDEX `fk_movimiento_cuenta1_idx` (`cuenta_id_cuenta` ASC) VISIBLE,
  INDEX `fk_movimiento_tipo_movimiento1_idx` (`tipo_movimiento_id_tipo_movimiento` ASC) VISIBLE,
  INDEX `fk_movimiento_asesor1_idx` (`asesor_id_asesor` ASC) VISIBLE,
  CONSTRAINT `fk_movimiento_cuenta1`
    FOREIGN KEY (`cuenta_id_cuenta`)
    REFERENCES `io_bank`.`cuenta` (`id_cuenta`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_movimiento_tipo_movimiento1`
    FOREIGN KEY (`tipo_movimiento_id_tipo_movimiento`)
    REFERENCES `io_bank`.`tipo_movimiento` (`id_tipo_movimiento`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_movimiento_asesor1`
    FOREIGN KEY (`asesor_id_asesor`)
    REFERENCES `io_bank`.`asesor` (`id_asesor`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
