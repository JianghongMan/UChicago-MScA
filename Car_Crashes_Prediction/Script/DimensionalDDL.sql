-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema mydb
-- -----------------------------------------------------
-- -----------------------------------------------------
-- Schema Carcrash
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema Carcrash
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `Carcrash` DEFAULT CHARACTER SET utf8mb4 ;
USE `Carcrash` ;

-- -----------------------------------------------------
-- Table `Carcrash`.`car_info`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Carcrash`.`car_info` (
  `VEHICLE_ID` INT(11) NOT NULL,
  `MAKE` VARCHAR(45) NULL DEFAULT NULL,
  `MODEL` VARCHAR(45) NULL DEFAULT NULL,
  `VEHICLE_YEAR` VARCHAR(45) NULL DEFAULT NULL,
  `VEHICLE_DEFECT` VARCHAR(45) NULL DEFAULT NULL,
  PRIMARY KEY (`VEHICLE_ID`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_unicode_ci;


-- -----------------------------------------------------
-- Table `Carcrash`.`injury_info`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Carcrash`.`injury_info` (
  `PERSON_ID` VARCHAR(32) NOT NULL,
  `INJURY_CLASSIFICATION` VARCHAR(45) NULL DEFAULT NULL,
  PRIMARY KEY (`PERSON_ID`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_unicode_ci;



-- -----------------------------------------------------
-- Table `Carcrash`.`people_condition`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Carcrash`.`people_condition` (
  `PERSON_ID` VARCHAR(32) NOT NULL,
  `PHYSICAL_CONDITION` VARCHAR(45) NULL DEFAULT NULL,
  `BAC_RESULT` VARCHAR(45) NULL DEFAULT NULL,
  `BAC_RESULT_VALUE` DOUBLE NULL DEFAULT NULL,
  PRIMARY KEY (`PERSON_ID`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_unicode_ci;


-- -----------------------------------------------------
-- Table `Carcrash`.`people_in_crash`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Carcrash`.`people_in_crash` (
  `PERSON_ID` VARCHAR(32) NOT NULL,
  `PERSON_TYPE` VARCHAR(16) NULL DEFAULT NULL,
  `SAFETY_EQUIPMENT` VARCHAR(45) NULL DEFAULT NULL,
  `AIRBAGE_DEPLOYED` VARCHAR(45) NULL DEFAULT NULL,
  `DRIVER_ACTION` VARCHAR(45) NULL DEFAULT NULL,
  `DRIVER_VISION` VARCHAR(45) NULL DEFAULT NULL,
  `PHYSICAL_CONDITION` VARCHAR(45) NULL DEFAULT NULL,
  `VEHICLE_ID` INT(11) NULL DEFAULT NULL,
  PRIMARY KEY (`PERSON_ID`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_unicode_ci;


-- -----------------------------------------------------
-- Table `Carcrash`.`people_info`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Carcrash`.`people_info` (
  `PERSON_ID` VARCHAR(32) NOT NULL,
  `SEX` CHAR(2) NULL DEFAULT NULL,
  `AGE` INT(11) NULL DEFAULT NULL,
  PRIMARY KEY (`PERSON_ID`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_unicode_ci;


-- -----------------------------------------------------
-- Table `Carcrash`.`crash_info`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Carcrash`.`crash_info` (
  `CRASH_RECORD_ID` VARCHAR(200) NOT NULL,
  `CRASH_TYPE` VARCHAR(45) NULL DEFAULT NULL,
  `INTERSECTION_RELATED` VARCHAR(45) NULL DEFAULT NULL,
  `NOT_RIGHT_OF_WAY` VARCHAR(45) NULL DEFAULT NULL,
  `HIT_AND_RUN` VARCHAR(45) NULL DEFAULT NULL,
  `DAMAGE` VARCHAR(45) NULL DEFAULT NULL,
  `PRIMARY_CAUSE` VARCHAR(45) NULL DEFAULT NULL,
  `SECONDARY_CAUSE` VARCHAR(45) NULL DEFAULT NULL,
  `DOORING` VARCHAR(45) NULL DEFAULT NULL,
  `NUM_UNITS` INT(11) NULL DEFAULT NULL,
  `DATE` CHAR(45) NULL DEFAULT NULL,
  `HOUR` INT(11) NULL DEFAULT NULL,
  `LATITUDE` DOUBLE NULL DEFAULT NULL,
  `LONGTITUDE` DOUBLE NULL DEFAULT NULL,
  PRIMARY KEY (`CRASH_RECORD_ID`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_unicode_ci;


-- -----------------------------------------------------
-- Table `Carcrash`.`road_info`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Carcrash`.`road_info` (
  `CRASH_RECORD_ID` VARCHAR(200) NOT NULL,
  `POSTED_SPEED` INT(11) NULL DEFAULT NULL,
  `TRAFFICE_CONTROL_DEVICE` VARCHAR(45) NULL DEFAULT NULL,
  `DEVICE_CONDITION` VARCHAR(45) NULL DEFAULT NULL,
  `WEATHER_CONDITION` VARCHAR(45) NULL DEFAULT NULL,
  `LIGHTING_CONDITION` VARCHAR(45) NULL DEFAULT NULL,
  `TRAFFICWAY_TYPE` VARCHAR(45) NULL DEFAULT NULL,
  `ALIGNMENT` VARCHAR(45) NULL DEFAULT NULL,
  `ROAD_SURFACE_COND` VARCHAR(45) NULL DEFAULT NULL,
  `ROAD_DEFECT` VARCHAR(45) NULL DEFAULT NULL,
  PRIMARY KEY (`CRASH_RECORD_ID`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_unicode_ci;



-- -----------------------------------------------------
-- Table `Carcrash`.`vehicle_info`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Carcrash`.`vehicle_info` (
  `CRASH_UNIT_ID` INT(11) NOT NULL,
  `UNIT_TYPE` VARCHAR(45) NULL DEFAULT NULL,
  `NUMBER_OF_PASSENGER` INT(11) NULL DEFAULT NULL,
  `VEHICLE_ID` INT(11) NULL DEFAULT NULL,
  `MANEUVER` VARCHAR(45) NULL DEFAULT NULL,
  `EXCEED_SPEED_LIMIT` VARCHAR(32) NULL DEFAULT NULL,
  PRIMARY KEY (`CRASH_UNIT_ID`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_unicode_ci;


-- -----------------------------------------------------
-- Table `Carcrash`.`FACT`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Carcrash`.`FACT` (
  `CRASH_RECORD_ID` VARCHAR(200) NOT NULL,
  `CRASH_UNIT_ID` INT(11) NOT NULL,
  `PERSON_ID` VARCHAR(32) NOT NULL,
  `VEHICLE_ID` INT(11) NULL DEFAULT NULL,
  INDEX `fk_crash_crash_info1_idx` (`CRASH_RECORD_ID` ASC),
  INDEX `fk_fact_people_vehicle_info1_idx` (`CRASH_UNIT_ID` ASC),
  INDEX `fk_FACT_injury_info1_idx` (`PERSON_ID` ASC),
  INDEX `fk_FACT_car_info1_idx` (`VEHICLE_ID` ASC),
  CONSTRAINT `fk_FACT_car_info1`
    FOREIGN KEY (`VEHICLE_ID`)
    REFERENCES `Carcrash`.`car_info` (`VEHICLE_ID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_FACT_injury_info1`
    FOREIGN KEY (`PERSON_ID`)
    REFERENCES `Carcrash`.`injury_info` (`PERSON_ID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_FACT_people_condition1`
    FOREIGN KEY (`PERSON_ID`)
    REFERENCES `Carcrash`.`people_condition` (`PERSON_ID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_FACT_people_in_crash1`
    FOREIGN KEY (`PERSON_ID`)
    REFERENCES `Carcrash`.`people_in_crash` (`PERSON_ID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_FACT_people_info1`
    FOREIGN KEY (`PERSON_ID`)
    REFERENCES `Carcrash`.`people_info` (`PERSON_ID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_crash_crash_info1`
    FOREIGN KEY (`CRASH_RECORD_ID`)
    REFERENCES `Carcrash`.`crash_info` (`CRASH_RECORD_ID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_crash_road_info1`
    FOREIGN KEY (`CRASH_RECORD_ID`)
    REFERENCES `Carcrash`.`road_info` (`CRASH_RECORD_ID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_fact_people_vehicle_info1`
    FOREIGN KEY (`CRASH_UNIT_ID`)
    REFERENCES `Carcrash`.`vehicle_info` (`CRASH_UNIT_ID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_unicode_ci;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;