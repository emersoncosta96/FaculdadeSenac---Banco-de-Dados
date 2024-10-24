-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema EscolDeMusica_SenacPE
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema EscolDeMusica_SenacPE
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `EscolDeMusica_SenacPE` DEFAULT CHARACTER SET utf8 ;
USE `EscolDeMusica_SenacPE` ;

-- -----------------------------------------------------
-- Table `EscolDeMusica_SenacPE`.`Orquestra`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `EscolDeMusica_SenacPE`.`Orquestra` (
  `idOrquestra` INT NOT NULL AUTO_INCREMENT,
  `nome` VARCHAR(45) NOT NULL,
  `pais` VARCHAR(45) NOT NULL,
  `cidade` VARCHAR(45) NOT NULL,
  `dt_fundacao` DATETIME NOT NULL,
  PRIMARY KEY (`idOrquestra`),
  UNIQUE INDEX `idOrquestra_UNIQUE` (`idOrquestra` ASC) VISIBLE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `EscolDeMusica_SenacPE`.`Musicos`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `EscolDeMusica_SenacPE`.`Musicos` (
  `idMusicos` INT NOT NULL,
  `nome` VARCHAR(45) NOT NULL,
  `identidade` VARCHAR(45) NOT NULL,
  `dt_nascimento` DATETIME NOT NULL,
  `nacionalidade` VARCHAR(45) NOT NULL,
  `Orquestra_idOrquestra` INT NOT NULL,
  PRIMARY KEY (`idMusicos`),
  UNIQUE INDEX `idMusicos_UNIQUE` (`idMusicos` ASC) VISIBLE,
  INDEX `fk_Musicos_Orquestra1_idx` (`Orquestra_idOrquestra` ASC) VISIBLE,
  CONSTRAINT `fk_Musicos_Orquestra1`
    FOREIGN KEY (`Orquestra_idOrquestra`)
    REFERENCES `EscolDeMusica_SenacPE`.`Orquestra` (`idOrquestra`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `EscolDeMusica_SenacPE`.`Sinfonia`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `EscolDeMusica_SenacPE`.`Sinfonia` (
  `idSinfonia` INT NOT NULL AUTO_INCREMENT,
  `nome` VARCHAR(45) NOT NULL,
  `compositor` VARCHAR(45) NOT NULL,
  `dt_criacao` DATETIME NOT NULL,
  `Orquestra_idOrquestra` INT NOT NULL,
  PRIMARY KEY (`idSinfonia`),
  UNIQUE INDEX `idSinfonia_UNIQUE` (`idSinfonia` ASC) VISIBLE,
  INDEX `fk_Sinfonia_Orquestra1_idx` (`Orquestra_idOrquestra` ASC) VISIBLE,
  CONSTRAINT `fk_Sinfonia_Orquestra1`
    FOREIGN KEY (`Orquestra_idOrquestra`)
    REFERENCES `EscolDeMusica_SenacPE`.`Orquestra` (`idOrquestra`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `EscolDeMusica_SenacPE`.`Instrumentos`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `EscolDeMusica_SenacPE`.`Instrumentos` (
  `idInstrumentos` INT NOT NULL AUTO_INCREMENT,
  `nome` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`idInstrumentos`),
  UNIQUE INDEX `idInstrumentos_UNIQUE` (`idInstrumentos` ASC) VISIBLE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `EscolDeMusica_SenacPE`.`Funcao_musicos`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `EscolDeMusica_SenacPE`.`Funcao_musicos` (
  `idFunca` INT NOT NULL AUTO_INCREMENT,
  `funcao` VARCHAR(45) NOT NULL,
  `dtFunc` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`idFunca`),
  UNIQUE INDEX `idFunca_UNIQUE` (`idFunca` ASC) VISIBLE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `EscolDeMusica_SenacPE`.`Apresentacoes`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `EscolDeMusica_SenacPE`.`Apresentacoes` (
  `idApresentacoes` INT NOT NULL AUTO_INCREMENT,
  `loca_da_apresentacao` VARCHAR(45) NOT NULL,
  `bairro` VARCHAR(45) NOT NULL,
  `Orquestra_idOrquestra` INT NOT NULL,
  PRIMARY KEY (`idApresentacoes`),
  UNIQUE INDEX `idApresentacoes_UNIQUE` (`idApresentacoes` ASC) VISIBLE,
  INDEX `fk_Apresentacoes_Orquestra1_idx` (`Orquestra_idOrquestra` ASC) VISIBLE,
  CONSTRAINT `fk_Apresentacoes_Orquestra1`
    FOREIGN KEY (`Orquestra_idOrquestra`)
    REFERENCES `EscolDeMusica_SenacPE`.`Orquestra` (`idOrquestra`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `EscolDeMusica_SenacPE`.`Participa`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `EscolDeMusica_SenacPE`.`Participa` (
  `Musicos_idMusicos` INT NOT NULL,
  `Sinfonia_idSinfonia` INT NOT NULL,
  `Instrumentos_idInstrumentos` INT NOT NULL,
  `Funcao_musicos_idFunca` INT NOT NULL,
  PRIMARY KEY (`Musicos_idMusicos`, `Sinfonia_idSinfonia`, `Instrumentos_idInstrumentos`, `Funcao_musicos_idFunca`),
  INDEX `fk_Participa_Sinfonia1_idx` (`Sinfonia_idSinfonia` ASC) VISIBLE,
  INDEX `fk_Participa_Instrumentos1_idx` (`Instrumentos_idInstrumentos` ASC) VISIBLE,
  INDEX `fk_Participa_Funcao_musicos1_idx` (`Funcao_musicos_idFunca` ASC) VISIBLE,
  CONSTRAINT `fk_Participa_Musicos`
    FOREIGN KEY (`Musicos_idMusicos`)
    REFERENCES `EscolDeMusica_SenacPE`.`Musicos` (`idMusicos`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Participa_Sinfonia1`
    FOREIGN KEY (`Sinfonia_idSinfonia`)
    REFERENCES `EscolDeMusica_SenacPE`.`Sinfonia` (`idSinfonia`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Participa_Instrumentos1`
    FOREIGN KEY (`Instrumentos_idInstrumentos`)
    REFERENCES `EscolDeMusica_SenacPE`.`Instrumentos` (`idInstrumentos`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Participa_Funcao_musicos1`
    FOREIGN KEY (`Funcao_musicos_idFunca`)
    REFERENCES `EscolDeMusica_SenacPE`.`Funcao_musicos` (`idFunca`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
