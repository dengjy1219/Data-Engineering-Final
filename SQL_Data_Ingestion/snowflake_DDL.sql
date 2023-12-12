CREATE TABLE DimCustomer (
  customer_id VARCHAR(100) PRIMARY KEY,
  customer_unique_id VARCHAR(100),
  customer_zip_code_prefix VARCHAR(45),
  customer_city VARCHAR(45),
  customer_state VARCHAR(45)
);

CREATE TABLE DimProduct (
  product_id VARCHAR(100) PRIMARY KEY,
  product_category_name VARCHAR(100),
  product_name_lengtht INT,
  product_description_length INT,
  product_photos_qty INT,
  product_weight_g INT,
  product_length_cm INT,
  product_height_cm INT,
  product_width_cm INT
);

CREATE TABLE DimSeller (
  seller_id VARCHAR(100) PRIMARY KEY,
  seller_zip_code_prefix VARCHAR(45),
  seller_city VARCHAR(45),
  seller_state VARCHAR(45)
);

CREATE TABLE DimGeolocation (
  geolocation_zip_code_prefix VARCHAR(45) PRIMARY KEY,
  geolocation_lat DOUBLE,
  geolocation_lng DOUBLE,
  geolocation_city VARCHAR(45),
  geolocation_state VARCHAR(45),
  geolocation_country VARCHAR(45)
);

CREATE TABLE DimDate (
  date_key INT PRIMARY KEY,
  date DATE,
  year YEAR,
  month INT,
  day INT,
  quarter INT,
  week INT
);

CREATE TABLE DimReview (
  review_id VARCHAR(100) PRIMARY KEY,
  order_id VARCHAR(100),
  review_comment_title VARCHAR(45),
  review_comment_message VARCHAR(250),
  review_creation_date DATETIME,
  review_answer_timestamp DATETIME
);

CREATE TABLE DimPayment (
  payment_id VARCHAR(100) PRIMARY KEY,
  order_id VARCHAR(100),
  payment_type VARCHAR(45),
  payment_installments INT
);

CREATE TABLE DimBrazilMacroeconomic (
  state_abbr VARCHAR(45) PRIMARY KEY,
  state_name VARCHAR(45),
  enrollment_in_primary_education INT,
  human_develop_index DOUBLE,
  monthly_household_income_per_capita DOUBLE,
  country VARCHAR(45)
);

CREATE TABLE FactSales (
  order_id VARCHAR(100),
  customer_id VARCHAR(100),
  order_item_id INT,
  product_id VARCHAR(100),
  seller_id VARCHAR(100),
  payment_id VARCHAR(100),
  review_id VARCHAR(100),
  date_key INT,
  price DOUBLE,
  freight_value DOUBLE,
  review_score DOUBLE,
  payment_value DOUBLE,
  state_abbr VARCHAR(45),
  PRIMARY KEY (order_id, order_item_id),
  FOREIGN KEY (customer_id) REFERENCES DimCustomer(customer_id),
  FOREIGN KEY (product_id) REFERENCES DimProduct(product_id),
  FOREIGN KEY (seller_id) REFERENCES DimSeller(seller_id),
  FOREIGN KEY (date_key) REFERENCES DimDate(date_key),
  FOREIGN KEY (state_abbr) REFERENCES DimBrazilMacroeconomic(state_abbr),
  FOREIGN KEY (payment_id) REFERENCES DimPayment(payment_id),
  FOREIGN KEY (review_id) REFERENCES DimReview(review_id)
);
