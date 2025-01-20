#### **Automated GitHub Activity Analytics Pipeline**

### **Project Description**:

The **Automated GitHub Activity Analytics Pipeline** is a robust data processing and analysis system that tracks and analyzes GitHub event activities, such as pull requests, pushes, and issues. This project integrates several AWS and data engineering tools to automate the process of extracting, transforming, and loading (ETL) data into a cloud-based data warehouse (**Snowflake**) for advanced reporting and visualization in **Tableau Public**.

#### **ETL Pipeline Overview**:
1. **Extract**:
   - **AWS Lambda** is used to **automatically fetch GitHub event data** (e.g., pull requests, issues, and pushes) from the **GitHub API** at regular intervals.
   - The extracted event data is stored in **Amazon S3** in JSON format for further processing.

2. **Transform**:
   - **AWS Glue** is used for the **initial transformation**. It reads the raw data from S3, cleans, filters, and structures it before loading it into **Snowflake**. It performs basic operations such as removing null values and flattening nested JSON structures.
   - **DBT (Data Build Tool)** is used to apply **advanced transformations** and modeling within **Snowflake**. DBT focuses on aggregating and structuring data for analysis, such as categorizing bot vs. non-bot events, creating fact and dimension tables, and ensuring high data quality through automated tests.

3. **Load**:
   - The transformed data is stored in **Snowflake**—specifically in a separate database table optimized for querying and reporting.
   - **DBT** manages the loading of final analytics-ready tables into Snowflake for consumption by **Tableau Public**.

4. **Data Visualization**:
   - **Tableau** is used to create interactive dashboards that visualize key insights, including:
     - The distribution of event types (bot vs. non-bot).
     - Event trends over time.
     - Top active users/actors by event count.
     - In-depth analysis of bot activity and actor behavior.
   - The dashboards have been **published on Tableau Public**, allowing for real-time sharing and access to the visualized insights.

---
![image](https://github.com/user-attachments/assets/b49dc9eb-72c5-4260-94d4-d0df020a79fc)

### **Tools and Technologies Used**:

- **AWS Lambda**: A serverless compute service used to extract data from GitHub's API and store it in Amazon S3.
- **Amazon S3**: Object storage used to temporarily store the raw GitHub event data.
- **AWS Glue**: ETL service used to clean and process raw data before loading it into Snowflake.
- **AWS Secrets Manager**: Used to securely store and manage credentials, such as GitHub API tokens and Snowflake connection details, which are accessed by **AWS Glue** to ensure secure access to resources.
- **DBT**: Data transformation tool that processes data within Snowflake, applying complex transformations, aggregations, and data quality checks.
- **Snowflake**: Cloud-based data warehouse where the cleaned and transformed data is stored and queried.
- **Tableau**: Data visualization tool used to create interactive dashboards based on the transformed data in Snowflake.
- **GitHub API**: The source of GitHub event data (e.g., pull requests, pushes, issues).
- **DBT Cloud**: Cloud-based version of DBT that integrates with **GitHub** to store and version control DBT models. It automates the transformation processes and orchestrates model runs directly from GitHub repositories.

---

### **IAM Roles and Snowflake Roles**:

#### **IAM Roles in AWS**:

1. **IAM Role for AWS Glue** (`GlueExecutionRole`):
   - Grants **AWS Glue** permission to access **Amazon S3**, interact with **Snowflake**, and perform ETL operations.
   - **Permissions**:
     - **Amazon S3**: `s3:GetObject`, `s3:PutObject` (to read/write data).
     - **Snowflake**: Access via the `Snowflake-connector` for Glue, allowing Glue to load and read data from Snowflake.
     - **AWS Secrets Manager**: Permissions to access credentials stored in **AWS Secrets Manager** for securely accessing GitHub API tokens and Snowflake credentials.
     - **CloudWatch Logs**: For logging Glue execution activity.

2. **IAM Role for AWS Lambda** (`LambdaExecutionRole`):
   - Grants **AWS Lambda** permission to fetch data from **GitHub API** and store it in **Amazon S3**.
   - **Permissions**:
     - **Amazon S3**: `s3:PutObject` (to write data).
     - **GitHub API**: API credentials (authentication tokens, handled externally).
     - **CloudWatch Logs**: For logging Lambda execution activity.

#### **Snowflake Roles**:

1. **Snowflake Role for AWS Glue** (`GLUE_ROLE`):
   - Allows **AWS Glue** to read from Snowflake staging tables and load data into Snowflake.
   - **Permissions**:
     - **Warehouse**: `USAGE` on the relevant Snowflake warehouse (e.g., `COMPUTE_WH`).
     - **Database & Schema**: `SELECT`, `INSERT` on staging tables.
     - **Data Loading**: `CREATE`, `INSERT` for loading data into Snowflake.

2. **Snowflake Role for DBT** (`DBT_ROLE`):
   - Allows **DBT** to transform data within **Snowflake** and load final models.
   - **Permissions**:
     - **Warehouse**: `USAGE` on a Snowflake warehouse (e.g., `TRANSFORM_WH`).
     - **Database & Schema**: `SELECT`, `INSERT`, `CREATE`, `ALTER` on Snowflake schemas (e.g., `PULLREQUESTDATA`).
     - **Model Execution**: `CREATE`, `DROP`, `SELECT` on final models and tables.

---

### **Project Workflow**:

1. **AWS Lambda** fetches data from GitHub API and stores it in **Amazon S3**.
2. **AWS Glue** processes the raw data in **S3**, applies basic cleaning, and loads it into a **Snowflake** staging table.
3. **DBT** connects to Snowflake, performs complex transformations, and writes the final, clean datasets into a **Snowflake database**.
4. **Tableau** connects to Snowflake, visualizes the data, and generates interactive dashboards for insights and reporting. These dashboards are **published on Tableau Public** for sharing and real-time access.

---

### **Key Insights and Features**:
- **Event Type Breakdown**: Distinguish between bot-generated and non-bot-generated events.
- **Actor Activity**: Visualize the top actors by event count and activity level.
- **Event Trends**: Track GitHub event trends over time.
- **Bot Activity Analysis**: Focus on bot activity patterns and how bots impact event distribution.
- **Automated Pipeline**: The entire ETL process is automated, ensuring timely updates to the dataset.
- **Interactive Dashboards**: Dashboards have been **published on Tableau Public**, providing an accessible view of key insights and trends.

---

### **Running the Project**:

1. **Set Up AWS Lambda**:
   - Create an AWS Lambda function that pulls data from GitHub and uploads it to Amazon S3.
   - Set up a CloudWatch event to trigger the Lambda function at regular intervals (e.g., hourly, daily).

2. **Configure AWS Glue**:
   - Set up AWS Glue jobs to clean, transform, and load the data into **Snowflake** from S3.
  
3. **Use DBT**:
   - Configure DBT to connect to Snowflake, write your models, and perform transformations on the loaded data.
   - Run DBT jobs to process the data and load it into final tables.

4. **Create Tableau Dashboards**:
   - Connect **Tableau** to the Snowflake database.
   - Build interactive dashboards to visualize GitHub event data insights and publish them on **Tableau Public** for sharing and real-time access.

---

### **Conclusion**:

This project automates the process of extracting, transforming, and visualizing GitHub event data, leveraging **AWS Lambda**, **AWS Glue**, **DBT**, **Snowflake**, and **Tableau**. It provides meaningful insights into GitHub activities, particularly focusing on bot vs. non-bot event analysis, and helps track trends and actor-level engagement. The entire pipeline is automated for efficient data processing and analysis, making it an ideal solution for real-time reporting and decision-making. Additionally, the **interactive dashboards** have been **published on Tableau Public**, enabling easy sharing of insights.

---
