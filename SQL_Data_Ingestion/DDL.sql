-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema mydb
-- -----------------------------------------------------
-- -----------------------------------------------------
-- Schema olist
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema olist
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `olist` DEFAULT CHARACTER SET latin1 ;
USE `olist` ;

-- -----------------------------------------------------
-- Table `olist`.`brazil_macroeconomic`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `olist`.`brazil_macroeconomic` (
  `state_abbr` VARCHAR(45) NOT NULL,
  `state_name` VARCHAR(45) NULL DEFAULT NULL,
  `enrollment_in_primary_education` INT NULL DEFAULT NULL,
  `human_develop_index` DOUBLE NULL DEFAULT NULL,
  `monthly_household_income_per_capita` DOUBLE NULL DEFAULT NULL,
  `country` VARCHAR(45) NULL DEFAULT NULL,
  PRIMARY KEY (`state_abbr`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = latin1;


-- -----------------------------------------------------
-- Table `olist`.`geolocation`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `olist`.`geolocation` (
  `geolocation_zip_code_prefix` VARCHAR(45) NOT NULL,
  `geolocation_lat` DOUBLE NULL DEFAULT NULL,
  `geolocation_lng` DOUBLE NULL DEFAULT NULL,
  `geolocation_city` VARCHAR(45) NULL DEFAULT NULL,
  `geolocation_state` VARCHAR(45) NULL DEFAULT NULL,
  `geolocation_country` VARCHAR(45) NULL DEFAULT NULL,
  PRIMARY KEY (`geolocation_zip_code_prefix`),
  INDEX `geolocation_state_idx` (`geolocation_state` ASC) VISIBLE,
  CONSTRAINT `geolocation_state`
    FOREIGN KEY (`geolocation_state`)
    REFERENCES `olist`.`brazil_macroeconomic` (`state_abbr`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = latin1;


-- -----------------------------------------------------
-- Table `olist`.`customers`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `olist`.`customers` (
  `customer_id` VARCHAR(100) NOT NULL,
  `customer_unique_id` VARCHAR(100) NULL DEFAULT NULL,
  `customer_zip_code_prefix` VARCHAR(45) NULL DEFAULT NULL,
  `customer_city` VARCHAR(45) NULL DEFAULT NULL,
  `customer_state` VARCHAR(45) NULL DEFAULT NULL,
  PRIMARY KEY (`customer_id`),
  INDEX `customer_zip_code_prefix_idx` (`customer_zip_code_prefix` ASC) VISIBLE,
  CONSTRAINT `customer_zip_code_prefix`
    FOREIGN KEY (`customer_zip_code_prefix`)
    REFERENCES `olist`.`geolocation` (`geolocation_zip_code_prefix`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = latin1;


-- -----------------------------------------------------
-- Table `olist`.`orders`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `olist`.`orders` (
  `order_id` VARCHAR(100) NOT NULL,
  `customer_id` VARCHAR(100) NULL DEFAULT NULL,
  `order_status` VARCHAR(45) NULL DEFAULT NULL,
  `order_purchase_timestamp` DATETIME NULL DEFAULT NULL,
  `order_approved_at` DATETIME NULL DEFAULT NULL,
  `order_delivered_carrier_date` DATETIME NULL DEFAULT NULL,
  `order_delivered_customer_date` DATETIME NULL DEFAULT NULL,
  `order_estimated_delivery_date` DATETIME NULL DEFAULT NULL,
  PRIMARY KEY (`order_id`),
  UNIQUE INDEX `order_id_UNIQUE` (`order_id` ASC) VISIBLE,
  INDEX `customer_id_idx` (`customer_id` ASC) VISIBLE,
  CONSTRAINT `customer_id`
    FOREIGN KEY (`customer_id`)
    REFERENCES `olist`.`customers` (`customer_id`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = latin1;


-- -----------------------------------------------------
-- Table `olist`.`products`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `olist`.`products` (
  `product_id` VARCHAR(100) NOT NULL,
  `product_category_name` VARCHAR(100) NULL DEFAULT NULL,
  `product_name_lenght` INT NULL DEFAULT NULL,
  `product_description_lenght` INT NULL DEFAULT NULL,
  `product_photos_qty` INT NULL DEFAULT NULL,
  `product_weight_g` INT NULL DEFAULT NULL,
  `product_length_cm` INT NULL DEFAULT NULL,
  `product_height_cm` INT NULL DEFAULT NULL,
  `product_width_cm` INT NULL DEFAULT NULL,
  PRIMARY KEY (`product_id`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = latin1;


-- -----------------------------------------------------
-- Table `olist`.`sellers`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `olist`.`sellers` (
  `seller_id` VARCHAR(100) NOT NULL,
  `seller_zip_code_prefix` VARCHAR(45) NULL DEFAULT NULL,
  `seller_city` VARCHAR(45) NULL DEFAULT NULL,
  `seller_state` VARCHAR(45) NULL DEFAULT NULL,
  PRIMARY KEY (`seller_id`),
  INDEX `seller_zip_code_prefix_idx` (`seller_zip_code_prefix` ASC) VISIBLE,
  CONSTRAINT `seller_zip_code_prefix`
    FOREIGN KEY (`seller_zip_code_prefix`)
    REFERENCES `olist`.`geolocation` (`geolocation_zip_code_prefix`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = latin1;


-- -----------------------------------------------------
-- Table `olist`.`order_items`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `olist`.`order_items` (
  `order_id_tt2` VARCHAR(100) NOT NULL,
  `order_item_id` INT NOT NULL,
  `product_id` VARCHAR(100) NULL DEFAULT NULL,
  `seller_id` VARCHAR(100) NULL DEFAULT NULL,
  `shipping_limit_date` DATETIME NULL DEFAULT NULL,
  `price` DOUBLE NULL DEFAULT NULL,
  `freight_value` DOUBLE NULL DEFAULT NULL,
  PRIMARY KEY (`order_id_tt2`, `order_item_id`),
  INDEX `product_id_idx` (`product_id` ASC) VISIBLE,
  INDEX `seller_id_idx` (`seller_id` ASC) VISIBLE,
  CONSTRAINT `order_id_tt2`
    FOREIGN KEY (`order_id_tt2`)
    REFERENCES `olist`.`orders` (`order_id`),
  CONSTRAINT `product_id`
    FOREIGN KEY (`product_id`)
    REFERENCES `olist`.`products` (`product_id`),
  CONSTRAINT `seller_id`
    FOREIGN KEY (`seller_id`)
    REFERENCES `olist`.`sellers` (`seller_id`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = latin1;


-- -----------------------------------------------------
-- Table `olist`.`order_payments`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `olist`.`order_payments` (
  `order_id_tt` VARCHAR(100) NOT NULL,
  `payment_sequential` INT NOT NULL,
  `payment_type` VARCHAR(45) NULL DEFAULT NULL,
  `payment_installments` INT NULL DEFAULT NULL,
  `payment_value` DOUBLE NULL DEFAULT NULL,
  PRIMARY KEY (`order_id_tt`, `payment_sequential`),
  CONSTRAINT `order_id_tt`
    FOREIGN KEY (`order_id_tt`)
    REFERENCES `olist`.`orders` (`order_id`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = latin1;


-- -----------------------------------------------------
-- Table `olist`.`order_reviews`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `olist`.`order_reviews` (
  `review_id` VARCHAR(100) NOT NULL,
  `order_id` VARCHAR(100) NOT NULL,
  `review_score` DOUBLE NULL DEFAULT NULL,
  `review_comment_title` VARCHAR(45) NULL DEFAULT NULL,
  `review_comment_message` VARCHAR(250) NULL DEFAULT NULL,
  `review_creation_date` DATETIME NULL DEFAULT NULL,
  `review_answer_timestamp` VARCHAR(45) NULL DEFAULT NULL,
  PRIMARY KEY (`review_id`, `order_id`),
  INDEX `order_id` (`order_id` ASC) VISIBLE,
  CONSTRAINT `order_id`
    FOREIGN KEY (`order_id`)
    REFERENCES `olist`.`orders` (`order_id`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = latin1;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;