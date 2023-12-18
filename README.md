# Enhancing E-Commerce Recommendation: Tailored User Experience
Data Engineering Platform Final Project

### Executive Summary
- This project delves into the dynamic Brazilian **e-commerce** market, focusing on Olist, a platform that integrates small businesses into larger online marketplaces. 
- Utilizing a rich Kaggle dataset alongside Brazil's macroeconomic indicators, including household income, we aim to uncover deep insights into consumer purchasing patterns and market trends. 
- Our analysis includes a detailed **RFM (Recency, Frequency, Monetary) assessment** and **K-means Clustering** to enhance customer segmentation and purchasing behavior understanding. 
- The objective is to derive strategic recommendations for Olist, targeting product portfolio optimization, marketing strategies, and overall sales enhancement to solidify their competitive edge in Brazil's flourishing e-commerce sector.

### End-to-End Data Pipeline
![image](https://github.com/dengjy1219/Data-Engineering-Final/assets/104877920/b791be6e-fa19-4f4f-bd83-f158692e45bb)

### Data Ingestion
- E-Commerce Data: Public Dataset by Olist, Tables connected by foreign keys
- Web Scraping: Brazilian state-level macro-economic data

### ETL Process & Details
![image](https://github.com/dengjy1219/Enhancing-Ecommerce-Recommendation/assets/104877920/4c26d2ad-f3bd-4754-836b-ecaeb04e8c6a)

### Data Modeling Design
**Database Modeling**
- OLTP: Normalized physical entity-relationship model
- OLAP: Multi-dimensional snowflake model

**Data Types**
- Choose VARCHAR datatypes for primary keys and other string attributes
- Define Date attributes with datatypes DATETIME or TIMESTAMP
- Follow standard naming convention for attributes

**Granularity of Data**
- E-commerce data is atomic in nature and can be stored in a fact table and rolled up by month/quarter

**Data Integrity**
- Establish a unique primary key for each entity/table
- Set foreign key relationships and constraints (not null, unique)
- Define default values for missing values wherever applicable (e.g. -1 for INT, None for VARCHAR)

**EER Model:**
![image](https://github.com/dengjy1219/Enhancing-Ecommerce-Recommendation/assets/104877920/cec6a16e-10e5-454a-a96b-62671cf44852)

**Snowflake Schema:**
![image](https://github.com/dengjy1219/Enhancing-Ecommerce-Recommendation/assets/104877920/3574afe0-9c5f-4dbc-8d39-a254e964b1a1)

### Insights
![image](https://github.com/dengjy1219/Enhancing-Ecommerce-Recommendation/assets/104877920/7ca23750-dc0a-4fe3-b314-b7f521429e32)
![image](https://github.com/dengjy1219/Enhancing-Ecommerce-Recommendation/assets/104877920/96196eea-e53b-4feb-b4bd-8f461291c00b)
![image](https://github.com/dengjy1219/Enhancing-Ecommerce-Recommendation/assets/104877920/a7c3ec2c-6443-43e6-82d2-14448b1c8f60)

### Analysis and Recommendations
![image](https://github.com/dengjy1219/Enhancing-Ecommerce-Recommendation/assets/104877920/bb2dc68e-acf9-4cc2-8adf-a93e0883fd1b)
![image](https://github.com/dengjy1219/Enhancing-Ecommerce-Recommendation/assets/104877920/1c95112a-6abf-4d32-938b-188bf6d5cc0a)
![image](https://github.com/dengjy1219/Enhancing-Ecommerce-Recommendation/assets/104877920/875eb923-2a99-453f-8459-664dd7d76844)
![image](https://github.com/dengjy1219/Enhancing-Ecommerce-Recommendation/assets/104877920/5cfb151e-e1c3-41ef-9754-9b7c8239036c)

