-- MySQL Script generated by MySQL Workbench
-- Wed Oct 11 21:09:48 2023
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
-- Table `mydb`.`Linka`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Linka` (
  `id_linka` INT NOT NULL AUTO_INCREMENT,
  `číslo_linky` INT UNSIGNED NOT NULL,
  `meno_linky` VARCHAR(240) NOT NULL,
  PRIMARY KEY (`id_linka`),
  UNIQUE INDEX `číslo_linky_UNIQUE` (`číslo_linky` ASC) VISIBLE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Trasa`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Trasa` (
  `id_trasa` INT GENERATED ALWAYS AS () VIRTUAL,
  `meno_trasy` VARCHAR(45) NULL,
  `info_trasy` VARCHAR(240) NULL,
  `id_linka` INT NOT NULL,
  PRIMARY KEY (`id_trasa`),
  UNIQUE INDEX `idTrasy_UNIQUE` (`id_trasa` ASC) VISIBLE,
  CONSTRAINT `fk_Trasa_Linka`
    FOREIGN KEY (`id_linka`)
    REFERENCES `mydb`.`Linka` (`id_linka`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Zastávka`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Zastávka` (
  `id_zastávka` INT NOT NULL AUTO_INCREMENT,
  `meno_zastávky` VARCHAR(45) NULL,
  `adresa_zastávky` VARCHAR(45) NULL,
  PRIMARY KEY (`id_zastávka`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Úsek`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Úsek` (
  `id_zastávka_začiatok` INT NOT NULL,
  `id_zastávka_koniec` INT NOT NULL,
  `meno_úseku` VARCHAR(45) NOT NULL,
  `dĺžka_úseku` VARCHAR(45) NULL,
  `čas_úseku` TIME GENERATED ALWAYS AS () VIRTUAL,
  `Úsekcol` VARCHAR(45) NULL,
  PRIMARY KEY (`id_zastávka_začiatok`, `id_zastávka_koniec`),
  INDEX `fk_Úsek_Zastávka1_idx` (`id_zastávka_začiatok` ASC) VISIBLE,
  INDEX `fk_Úsek_Zastávka2_idx` (`id_zastávka_koniec` ASC) VISIBLE,
  UNIQUE INDEX `id_úsek_UNIQUE` (`meno_úseku` ASC) VISIBLE,
  CONSTRAINT `fk_Úsek_Zastávka1`
    FOREIGN KEY (`id_zastávka_začiatok`)
    REFERENCES `mydb`.`Zastávka` (`id_zastávka`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Úsek_Zastávka2`
    FOREIGN KEY (`id_zastávka_koniec`)
    REFERENCES `mydb`.`Zastávka` (`id_zastávka`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Úsek trasy`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Úsek trasy` (
  `poradie_úseku` INT NOT NULL,
  `id_trasy` INT NOT NULL,
  `id_zastávka_začiatok` INT NOT NULL,
  `id_zastávka_koniec` INT NOT NULL,
  PRIMARY KEY (`poradie_úseku`, `id_trasy`, `id_zastávka_začiatok`, `id_zastávka_koniec`),
  INDEX `fk_Úsek trasy_Úsek1_idx` (`id_zastávka_začiatok` ASC, `id_zastávka_koniec` ASC) VISIBLE,
  CONSTRAINT `fk_Úsek trasy_Trasa1`
    FOREIGN KEY (`id_trasy`)
    REFERENCES `mydb`.`Trasa` (`id_linka`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Úsek trasy_Úsek1`
    FOREIGN KEY (`id_zastávka_začiatok` , `id_zastávka_koniec`)
    REFERENCES `mydb`.`Úsek` (`id_zastávka_začiatok` , `id_zastávka_koniec`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Vozidlo`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Vozidlo` (
  `id_vozidlo` INT NOT NULL,
  `názov` VARCHAR(45) NULL,
  `druh_vozidla` VARCHAR(45) NULL,
  `značka_vozidla` VARCHAR(45) NULL,
  PRIMARY KEY (`id_vozidlo`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Uživateľ`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Uživateľ` (
  `id_uživateľ` INT NOT NULL,
  `meno_uživateľa` VARCHAR(45) NULL,
  `priezvisko_uživateľa` VARCHAR(45) NULL,
  `tel_číslo_uživateľa` VARCHAR(45) NULL,
  `heslo_uživateľa` VARCHAR(45) NULL,
  `rola_uživateľa` VARCHAR(45) NULL,
  PRIMARY KEY (`id_uživateľ`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Plánovaný spoj`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Plánovaný spoj` (
  `id_plán_trasy` INT GENERATED ALWAYS AS () VIRTUAL,
  `začiatok_trasy` DATETIME NULL,
  `id_trasa` INT NOT NULL,
  `id_vozidlo` INT NOT NULL,
  `id_uživateľ_dispečer` INT NOT NULL,
  `id_uživateľ_šofér` INT NOT NULL,
  PRIMARY KEY (`id_plán_trasy`),
  INDEX `fk_Plánovaný spoj_Trasa1_idx` (`id_trasa` ASC) VISIBLE,
  INDEX `fk_Plánovaný spoj_Vozidlo1_idx` (`id_vozidlo` ASC) VISIBLE,
  INDEX `fk_Plánovaný spoj_Uživateľ1_idx` (`id_uživateľ_dispečer` ASC) VISIBLE,
  INDEX `fk_Plánovaný spoj_Uživateľ1_idx1` (`id_uživateľ_šofér` ASC) VISIBLE,
  CONSTRAINT `fk_trasa`
    FOREIGN KEY (`id_trasa`)
    REFERENCES `mydb`.`Trasa` (`id_linka`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_vozidlo`
    FOREIGN KEY (`id_vozidlo`)
    REFERENCES `mydb`.`Vozidlo` (`id_vozidlo`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_uživateľ_šofér`
    FOREIGN KEY (`id_uživateľ_dispečer`)
    REFERENCES `mydb`.`Uživateľ` (`id_uživateľ`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Plánovaný spoj_Uživateľ1`
    FOREIGN KEY (`id_uživateľ_šofér`)
    REFERENCES `mydb`.`Uživateľ` (`id_uživateľ`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Údržba`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Údržba` (
  `id_údržba` INT NOT NULL AUTO_INCREMENT,
  `začiatok_údržby` DATETIME NULL,
  `id_vozidlo` INT NOT NULL,
  `id_uživateľ_správca` INT NOT NULL,
  PRIMARY KEY (`id_údržba`),
  INDEX `fk_Údržba_Vozidlo1_idx` (`id_vozidlo` ASC) VISIBLE,
  INDEX `fk_Údržba_Uživateľ1_idx` (`id_uživateľ_správca` ASC) VISIBLE,
  CONSTRAINT `fk_Údržba_Vozidlo1`
    FOREIGN KEY (`id_vozidlo`)
    REFERENCES `mydb`.`Vozidlo` (`id_vozidlo`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Údržba_Uživateľ1`
    FOREIGN KEY (`id_uživateľ_správca`)
    REFERENCES `mydb`.`Uživateľ` (`id_uživateľ`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Záznam údržby`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Záznam údržby` (
  `id_údržba` INT NULL,
  `id_uživateľ_technik` INT NOT NULL,
  INDEX `fk_Záznam údržby_Údržba1_idx` (`id_údržba` ASC) VISIBLE,
  INDEX `fk_Záznam údržby_Uživateľ1_idx` (`id_uživateľ_technik` ASC) VISIBLE,
  PRIMARY KEY (`id_údržba`, `id_uživateľ_technik`),
  CONSTRAINT `fk_Záznam údržby_Údržba1`
    FOREIGN KEY (`id_údržba`)
    REFERENCES `mydb`.`Údržba` (`id_údržba`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Záznam údržby_Uživateľ1`
    FOREIGN KEY (`id_uživateľ_technik`)
    REFERENCES `mydb`.`Uživateľ` (`id_uživateľ`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
