-- MySQL Script generated by MySQL Workbench
-- Tue Jan  9 22:59:45 2018
-- Model: New Model    Version: 1.0
-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='TRADITIONAL,ALLOW_INVALID_DATES';

-- -----------------------------------------------------
-- Schema mydb
-- -----------------------------------------------------
DROP SCHEMA IF EXISTS `mydb` ;

-- -----------------------------------------------------
-- Schema mydb
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `mydb` DEFAULT CHARACTER SET utf8 ;
USE `mydb` ;

-- -----------------------------------------------------
-- Table `mydb`.`student`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `mydb`.`student` ;

CREATE TABLE IF NOT EXISTS `mydb`.`student` (
  `id` INT NOT NULL,
  `name` VARCHAR(255) NULL,
  `wechatId` VARCHAR(255) NULL,
  `wechatName` VARCHAR(255) NULL,
  `remaining` DOUBLE NULL,
  `joinTime` DATETIME NULL,
  `mark` VARCHAR(255) NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`parent`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `mydb`.`parent` ;

CREATE TABLE IF NOT EXISTS `mydb`.`parent` (
  `id` INT NOT NULL,
  `name` VARCHAR(255) NULL,
  `wechatId` VARCHAR(255) NULL,
  `wechatName` VARCHAR(255) NULL,
  `mark` VARCHAR(255) NULL,
  `studentId` INT NULL,
  `joinTime` DATETIME NULL,
  PRIMARY KEY (`id`),
  INDEX `par_stu_idx` (`studentId` ASC),
  CONSTRAINT `par_stu`
    FOREIGN KEY (`studentId`)
    REFERENCES `mydb`.`student` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`teacher`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `mydb`.`teacher` ;

CREATE TABLE IF NOT EXISTS `mydb`.`teacher` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(255) NULL,
  `wechatId` VARCHAR(255) NULL,
  `wechatName` VARCHAR(255) NULL,
  `joinTime` DATETIME NULL,
  `mark` VARCHAR(255) NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`course`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `mydb`.`course` ;

CREATE TABLE IF NOT EXISTS `mydb`.`course` (
  `id` INT NOT NULL,
  `name` VARCHAR(45) NULL,
  `description` VARCHAR(255) NULL,
  `week` VARCHAR(255) NULL,
  `startTime` VARCHAR(255) NULL,
  `endTime` VARCHAR(255) NULL,
  `weekday` VARCHAR(10) NULL,
  `teacherId` INT NULL,
  PRIMARY KEY (`id`),
  INDEX `course_teacher_idx` (`teacherId` ASC),
  INDEX `course_time` (`week` ASC),
  CONSTRAINT `course_teacher`
    FOREIGN KEY (`teacherId`)
    REFERENCES `mydb`.`teacher` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`take_course`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `mydb`.`take_course` ;

CREATE TABLE IF NOT EXISTS `mydb`.`take_course` (
  `studentId` INT NULL,
  `courseId` INT NULL,
  INDEX `student_take_idx` (`studentId` ASC),
  INDEX `course_key_idx` (`courseId` ASC),
  CONSTRAINT `student_take`
    FOREIGN KEY (`studentId`)
    REFERENCES `mydb`.`student` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `course_key`
    FOREIGN KEY (`courseId`)
    REFERENCES `mydb`.`course` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`homework`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `mydb`.`homework` ;

CREATE TABLE IF NOT EXISTS `mydb`.`homework` (
  `id` INT NOT NULL COMMENT '作业的唯一标识',
  `name` VARCHAR(255) NULL COMMENT '\'作业名称\'',
  `week` VARCHAR(255) NULL COMMENT '\'这是哪一周的作业，如\'2018-01\'\'',
  `weekday` VARCHAR(255) NULL COMMENT '\'这是星期几的作业\'，如星期三',
  `content` VARCHAR(2000) NULL COMMENT '\'作业的文本内容，如“今天要做的是1+1=？”\'',
  `pics` VARCHAR(1000) NULL COMMENT '\'作业的图片路径，最多三张图片，用英文分号分开，如‘C:/pic1.jpg;C:/pic2.jpg’\'',
  `studentId` INT NULL COMMENT '这次家庭作业的学生id',
  `mark` VARCHAR(255) NULL COMMENT '\'备注\'',
  PRIMARY KEY (`id`),
  INDEX `student_homework_idx` (`studentId` ASC),
  INDEX `homewrok_time` (`week` ASC),
  CONSTRAINT `student_homework`
    FOREIGN KEY (`studentId`)
    REFERENCES `mydb`.`student` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`courseBook`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `mydb`.`courseBook` ;

CREATE TABLE IF NOT EXISTS `mydb`.`courseBook` (
  `id` INT NOT NULL,
  `name` VARCHAR(255) NULL,
  `time` DATETIME NULL,
  `consume` DOUBLE NULL,
  `remain` DOUBLE NULL,
  `description` VARCHAR(255) NULL,
  `charge` DOUBLE NULL,
  `studentId` INT NULL,
  `mark` VARCHAR(1000) NULL,
  PRIMARY KEY (`id`),
  INDEX `student_purchase_idx` (`studentId` ASC),
  INDEX `purchase_time` (`time` ASC),
  CONSTRAINT `student_purchase`
    FOREIGN KEY (`studentId`)
    REFERENCES `mydb`.`student` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`course_feedback`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `mydb`.`course_feedback` ;

CREATE TABLE IF NOT EXISTS `mydb`.`course_feedback` (
  `id` INT NOT NULL,
  `name` VARCHAR(255) NULL,
  `content` VARCHAR(2000) NULL,
  `pics` VARCHAR(1000) NULL,
  `courseId` INT NULL,
  `uploadTime` DATETIME NULL,
  PRIMARY KEY (`id`),
  INDEX `course_feedback_ref_idx` (`courseId` ASC),
  CONSTRAINT `course_feedback_ref`
    FOREIGN KEY (`courseId`)
    REFERENCES `mydb`.`course` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`homework_feedback`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `mydb`.`homework_feedback` ;

CREATE TABLE IF NOT EXISTS `mydb`.`homework_feedback` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(255) NULL,
  `content` VARCHAR(2000) NULL,
  `pics` VARCHAR(1000) NULL,
  `studentId` INT NULL,
  `uploadTime` DATETIME NULL,
  PRIMARY KEY (`id`),
  INDEX `student_homework_feedback_idx` (`studentId` ASC),
  CONSTRAINT `student_homework_feedback`
    FOREIGN KEY (`studentId`)
    REFERENCES `mydb`.`student` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`test_feedback`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `mydb`.`test_feedback` ;

CREATE TABLE IF NOT EXISTS `mydb`.`test_feedback` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(255) NULL,
  `content` VARCHAR(2000) NULL,
  `pics` VARCHAR(1000) NULL,
  `studentId` INT NULL,
  `uploadTime` DATETIME NULL,
  PRIMARY KEY (`id`),
  INDEX `student_test_feedback_idx` (`studentId` ASC),
  CONSTRAINT `student_test_feedback`
    FOREIGN KEY (`studentId`)
    REFERENCES `mydb`.`student` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

USE `mydb` ;

-- -----------------------------------------------------
-- Placeholder table for view `mydb`.`view1`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`view1` (`id` INT);

-- -----------------------------------------------------
-- View `mydb`.`view1`
-- -----------------------------------------------------
DROP VIEW IF EXISTS `mydb`.`view1` ;
DROP TABLE IF EXISTS `mydb`.`view1`;
USE `mydb`;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
