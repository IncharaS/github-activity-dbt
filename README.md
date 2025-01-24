#### **Automated GitHub Activity Analytics Pipeline**

### **Project Description**:

The **Automated GitHub Activity Analytics Pipeline** is a robust data processing and analysis system that tracks and analyzes GitHub event activities, such as pull requests, pushes, and issues. This project integrates several AWS and data engineering tools to automate the process of extracting, transforming, and loading (ETL) data into a cloud-based data warehouse (**Snowflake**) for advanced reporting and visualization in **Tableau Public**.

#### **ETL Pipeline Overview**:
1. **Extract**:
   - **Amazon EventBridge** triggers a scheduled event every hour to fetch GitHub event data from the **GitHub Archive**, ensuring timely and consistent updates.
   - The event invokes an **AWS Lambda** function, which extracts event data and stores it in **Amazon S3** in JSON format for further processing.

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
   - The dashboards have been **published on Tableau Public**: https://public.tableau.com/views/GithubActivity/Dashboard1?:language=en-US&publish=yes&:sid=&:redirect=auth&:display_count=n&:origin=viz_share_link, allowing for real-time sharing and access to the visualized insights.

---

### **Tools and Technologies Used**:

- **Amazon EventBridge**: Used to schedule and trigger data extraction events every hour from **GitHub Archive**.
- **AWS Lambda**: A serverless compute service used to process **EventBridge** triggers, fetch data from GitHub Archive, and store it in **Amazon S3**.
- **Amazon S3**: Object storage used to temporarily store the raw GitHub event data.
- **AWS Glue**: ETL service used to clean and process raw data before loading it into Snowflake.
- **AWS Secrets Manager**: Used to securely store and manage credentials, such as GitHub API tokens and Snowflake connection details, which are accessed by **AWS Glue** to ensure secure access to resources.
- **DBT**: Data transformation tool that processes data within Snowflake, applying complex transformations, aggregations, and data quality checks.
- **Snowflake**: Cloud-based data warehouse where the cleaned and transformed data is stored and queried.
- **Tableau**: Data visualization tool used to create interactive dashboards based on the transformed data in Snowflake.
- **GitHub Archive**: The source of GitHub event data (e.g., pull requests, pushes, issues).
- **DBT Cloud**: Cloud-based version of DBT that integrates with **GitHub** to store and version control DBT models. It automates the transformation processes and orchestrates model runs directly from GitHub repositories.

---

### **Project Workflow**:

1. **Amazon EventBridge** triggers an event every hour, invoking **AWS Lambda**.
2. **AWS Lambda** fetches data from **GitHub Archive** and stores it in **Amazon S3**.
3. **AWS Glue** processes the raw data in **S3**, applies basic cleaning, and loads it into a **Snowflake** staging table.
4. **DBT** connects to Snowflake, performs complex transformations, and writes the final, clean datasets into a **Snowflake database**.
5. **Tableau** connects to Snowflake, visualizes the data, and generates interactive dashboards for insights and reporting. These dashboards are **published on Tableau Public** for sharing and real-time access.

---

### **Conclusion**:

This enhanced pipeline integrates **Amazon EventBridge** to fetch data from **GitHub Archive** every hour, ensuring consistent and timely updates. The project automates the process of extracting, transforming, and visualizing GitHub event data, leveraging **AWS Lambda**, **AWS Glue**, **DBT**, **Snowflake**, and **Tableau**. It provides meaningful insights into GitHub activities, particularly focusing on bot vs. non-bot event analysis, and helps track trends and actor-level engagement. The interactive dashboards, published on Tableau Public, enable easy sharing and real-time access to insights.
