-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema mydb
-- -----------------------------------------------------
-- -----------------------------------------------------
-- Schema amadeuspc
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema amadeuspc
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `amadeuspc` DEFAULT CHARACTER SET utf8mb3 ;
USE `amadeuspc` ;

-- -----------------------------------------------------
-- Table `amadeuspc`.`brands`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `amadeuspc`.`brands` (
  `idBrand` INT NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(45) NULL DEFAULT NULL,
  `idProduct` INT NULL DEFAULT NULL,
  PRIMARY KEY (`idBrand`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb3;


-- -----------------------------------------------------
-- Table `amadeuspc`.`rols`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `amadeuspc`.`rols` (
  `idRol` INT NOT NULL AUTO_INCREMENT,
  `admin` TINYINT NULL DEFAULT NULL,
  `user` TINYINT NULL DEFAULT NULL,
  PRIMARY KEY (`idRol`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb3;


-- -----------------------------------------------------
-- Table `amadeuspc`.`addresses`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `amadeuspc`.`addresses` (
  `idAddress` INT NOT NULL AUTO_INCREMENT,
  `address` VARCHAR(45) NULL,
  `city` VARCHAR(45) NULL,
  `province` VARCHAR(45) NULL,
  `country` VARCHAR(45) NULL,
  `zipCode` INT NULL,
  PRIMARY KEY (`idAddress`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `amadeuspc`.`users`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `amadeuspc`.`users` (
  `idUser` INT NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(45) NOT NULL,
  `surname` VARCHAR(45) NOT NULL,
  `email` VARCHAR(45) NOT NULL,
  `phone` INT NOT NULL,
  `rol_id` INT NOT NULL,
  `avatar` VARCHAR(100) NULL,
  `Idaddress` INT NULL,
  PRIMARY KEY (`idUser`),
  INDEX `Rol_idx` (`rol_id` ASC) VISIBLE,
  INDEX `address_idx` (`Idaddress` ASC) VISIBLE,
  CONSTRAINT `Rol`
    FOREIGN KEY (`rol_id`)
    REFERENCES `amadeuspc`.`rols` (`idRol`),
  CONSTRAINT `address`
    FOREIGN KEY (`Idaddress`)
    REFERENCES `amadeuspc`.`addresses` (`idAddress`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb3;


-- -----------------------------------------------------
-- Table `amadeuspc`.`cart`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `amadeuspc`.`cart` (
  `id` INT NOT NULL,
  `id_user` INT NOT NULL,
  INDEX `usuarios_idx` (`id_user` ASC) VISIBLE,
  PRIMARY KEY (`id`),
  CONSTRAINT `usuarios`
    FOREIGN KEY (`id_user`)
    REFERENCES `amadeuspc`.`users` (`idUser`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb3;


-- -----------------------------------------------------
-- Table `amadeuspc`.`category`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `amadeuspc`.`category` (
  `idCategory` INT NOT NULL AUTO_INCREMENT,
  `nameCategory` VARCHAR(45) NULL DEFAULT NULL,
  PRIMARY KEY (`idCategory`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb3;


-- -----------------------------------------------------
-- Table `amadeuspc`.`products`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `amadeuspc`.`products` (
  `idProduct` INT NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(45) NOT NULL,
  `price` INT NOT NULL,
  `description` VARCHAR(45) NOT NULL,
  `category_id` INT NOT NULL,
  `brand_id` INT NOT NULL,
  `discount` INT NULL DEFAULT NULL,
  `novelty` TINYINT NULL DEFAULT NULL,
  INDEX `Marcas_idx` (`brand_id` ASC) VISIBLE,
  INDEX `Categorias_idx` (`category_id` ASC) VISIBLE,
  PRIMARY KEY (`idProduct`),
  CONSTRAINT `Categorias`
    FOREIGN KEY (`category_id`)
    REFERENCES `amadeuspc`.`category` (`idCategory`),
  CONSTRAINT `Marcas`
    FOREIGN KEY (`brand_id`)
    REFERENCES `amadeuspc`.`brands` (`idBrand`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb3;


-- -----------------------------------------------------
-- Table `amadeuspc`.`product_image`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `amadeuspc`.`product_image` (
  `idProduct_Image` INT NOT NULL,
  `idProduct` INT NOT NULL,
  PRIMARY KEY (`idProduct_Image`),
  INDEX `Productos_idx` (`idProduct` ASC) VISIBLE,
  CONSTRAINT `Productos`
    FOREIGN KEY (`idProduct`)
    REFERENCES `amadeuspc`.`products` (`idProduct`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb3;


-- -----------------------------------------------------
-- Table `amadeuspc`.`products_cart`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `amadeuspc`.`products_cart` (
  `idProducts_cart` INT NOT NULL AUTO_INCREMENT,
  `productId` INT NOT NULL,
  `cartId` INT NOT NULL,
  PRIMARY KEY (`idProducts_cart`),
  INDEX `Products_idx` (`productId` ASC) VISIBLE,
  INDEX `Cart_idx` (`cartId` ASC) VISIBLE,
  CONSTRAINT `Cart`
    FOREIGN KEY (`cartId`)
    REFERENCES `amadeuspc`.`cart` (`id`),
  CONSTRAINT `Products`
    FOREIGN KEY (`productId`)
    REFERENCES `amadeuspc`.`products` (`idProduct`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb3;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;