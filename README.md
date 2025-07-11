# 📊 Layoff Analysis (2020–2023)

## Project Overview

This project focuses on analyzing **employee layoffs** from companies around the world between 2020 and 2023. The aim was to **clean** and **explore** the dataset to uncover key trends and insights related to layoffs during this period.

---

## 📋 Dataset Overview

- **Source**: A dataset containing records of company layoffs, including information such as company name, industry, location, number of employees laid off, total staff, percentage laid off, funding, stage, and the date of layoff.
- **Time Period**: 2020 to 2023
- **Rows**: ~2,361
- **Columns**:
  - Company
  - Industry
  - Location
  - Total Laid Off
  - Percentage Laid Off
  - Date
  - Other relevant details

---

## 🧹 Data Cleaning Process

The following steps were applied to clean and prepare the dataset for analysis using SQL:

### 1. **Removed Duplicates**:
   - Applied **`ROW_NUMBER()`** and **`DELETE`** to identify and remove duplicate rows.

### 2. **Standardized Data**:
   - Cleaned and standardized columns for consistency:
     - Converted text to lowercase.
     - Trimmed excess spaces.
     - Fixed inconsistent company and industry names.

### 3. **Handled Missing Data**:
   - Replaced blank strings with **`NULL`**.
   - Removed rows with missing critical information like company or industry.

### 4. **Removed Unnecessary Columns**:
   - Dropped irrelevant or empty columns to optimize the dataset.

### 5. **Converted Data Types**:
   - Used **`STR_TO_DATE()`** to properly convert date strings to the **DATE** format.

---

## 🔍 Exploratory Data Analysis (EDA)

SQL queries were used to perform **Exploratory Data Analysis (EDA)** on the cleaned dataset, answering questions like:

- 🏢 **Which companies had the highest number of layoffs?**
- 🌐 **Which industries were most impacted?**
- 🌎 **What countries or cities saw the most layoffs?**
- 📅 **How did layoffs evolve from 2020 to 2023?**
- 📊 **What percentage of employees were laid off at each company?**

---

## 🛠️ Tools & Technologies Used

- **SQL** (MySQL Workbench)
- **ROW_NUMBER()**, **CTEs**, **Joins**, **Aggregates** for data manipulation
- **Data Cleaning Techniques** implemented in SQL
- **Exploratory Data Analysis (EDA)** using SQL queries

---

## 🏁 Conclusion

This project demonstrates how to **clean** and **analyze** data about employee layoffs. By applying **data cleaning** methods and performing **exploratory data analysis (EDA)**, valuable insights from the 2020–2023 period were uncovered, showing the impact of layoffs across industries and regions.
