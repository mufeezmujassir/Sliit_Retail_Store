
# 🏪 ABC Retail Store — End-to-End Data Warehouse & Business Intelligence Solution

A fully implemented **DWBI project** built using SQL Server, SSIS, SSAS, and Power BI — designed to analyze **sales, customers, and product performance** for a retail environment.
This project follows real industry architecture with **Source → Staging → Data Warehouse → OLAP Cube → Power BI**.

---

## 📌 Overview

This project is a complete Business Intelligence solution developed using the **SLIIT DW/BI practicals** and extended to form an end-to-end real-world retail analytics system.

It includes:

* 🔹 Building a **dimensional data warehouse** using a snowflake schema
* 🔹 Creating **ETL pipelines** using SSIS
* 🔹 Implementing **Slowly Changing Dimensions (Customer – SCD Type 2)**
* 🔹 Designing an **SSAS OLAP Cube** with calculated measures
* 🔹 Developing an interactive **Power BI dashboard**
* 🔹 Performing analytical insights: sales, customers, products, trends

All datasets originate from **SQL Server** and **flat files**, and the flow is automated through SSIS.

---

## 🚀 Key Features

### 🔄 ETL (SSIS)

* Extract data from **SQL Server** and **flat files (CustomerAddress.txt)**
* Load data into **Staging** and **Data Warehouse**
* Data cleansing, type conversions, and lookups
* Customer dimension implemented with **SCD Type 2**
* Surrogate key generation for all dimensions
* Error-handling and incremental loading pattern

---

### 🗄️ Dimensional Data Warehouse (Star Schema)

**Dimensions:**

* **DimDate** – full date dimension
* **DimCustomer** – history-tracked customer data (SCD2)
* **DimProduct**
* **DimProductSubCategory**
* **DimProductCategory**

**Fact Table:**

* **FactSales** (joins Product, Customer, and Date dimensions)

Includes derived fields:

* TotalUnitCostBeforeTaxFreight
* TotalUnitCostWithTaxFreight
* TotalCostPerItem
* RemainingPayment

---

### 🎲 SSAS OLAP Cube

* OLAP cube built on top of the Data Warehouse
* Includes:

  * Product hierarchy (**Category → SubCategory → Product**)
  * Date hierarchies
  * Customer attributes
  * Sales measures: LineTotal, Tax, Freight, Discounts
* Calculated measures
* KPI: **Remaining Payment**

---

### 📊 Power BI Dashboard

Built using the DW and SSAS Cube, containing:

#### ✔ Sales Analytics

* Total sales, orders, revenue, and transactions
* Sales trend by month/year
* Sales by category & subcategory
* Top 10 products by revenue (with dynamic filters)

#### ✔ Customer Analytics

* Customer segmentation
* Customer history with SCD2
* Geographic & demographic insights

#### ✔ Product Insights

* Best / worst performing products
* Revenue by product hierarchy
* Price vs quantity correlation

Includes slicers, drill-down, cross-filtering, and responsive design.

---

## 🏗️ Architecture

```
SQL Database + Flat Files
          ↓
      SSIS ETL
(Source → Staging → DW)
          ↓
    SSAS OLAP Cube
          ↓
      Power BI Reports
```

---

## 🛠️ Technology Stack

| Area           | Technology                             |
| -------------- | -------------------------------------- |
| Database       | SQL Server                             |
| ETL            | SSIS (SQL Server Integration Services) |
| Data Warehouse | SQL Server DW (Star Schema)            |
| OLAP           | SSAS Multidimensional                  |
| Visualization  | Power BI Desktop                       |
| Tools          | SSMS, Visual Studio SSDT               |

---

## 📦 Project Components You Built

### ✔ SQL Server Source Database

Contains tables:

* Product
* ProductCategory
* ProductSubCategory
* SalesOrderHeader
* SalesOrderDetail
* IndividualCustomer
* CustomerAddress (flat file)

### ✔ Staging Schema

Mirror of source tables, used for cleaning & integration.

### ✔ Data Warehouse Schema

* Dimensions (Date, Customer (SCD2), Product, SubCategory, Category)
* FactSales (fully populated via ETL)

### ✔ SSIS Packages

* **Load Staging** (`SLIIT_Retail_Load_Staging`)
* **Load Data Warehouse** (`SLIIT_Retail_Load_DW`)

### ✔ SSAS Cube

* Cube with hierarchies, measures, KPIs
* Deployed successfully to SSAS server

### ✔ Power BI Report

* Multi-page dashboard
* Dynamic filters, visuals, and DAX measures

---

## 📊 Data Model (Star Schema)

```
                    DimDate
                       │
         ┌─────────────┼──────────────┐
         │              │              │
   DimCustomer      FactSales     DimProduct
                       │              │
                       │              │
             DimProductSubCategory
                       │
                       │
              DimProductCategory
```

---

## 🧪 ETL Process Summary

### **Phase 1 – Source → Staging**

* Truncate & load
* CustomerAddress flat file parsing
* Data type conversions
* Basic transformations

### **Phase 2 – Staging → Data Warehouse**

* Generate surrogate keys
* Customer SCD2 implementation
* Lookup for all dimension keys
* Load FactSales only after all dimensions

Order of load:

1. DimProductCategory
2. DimProductSubCategory
3. DimProduct
4. DimCustomer (SCD2)
5. FactSales

---

## 📈 Power BI Dashboard Pages

1. **Executive Summary**
2. **Sales Performance**
3. **Customer Analytics**
4. **Product Insights**

Features:

* Slicers (date, category, customer, product)
* Drill-down and drill-through
* Dynamic Top N
* Trend visualizations
* DAX measures for revenue, counts, discounts

---

## 🔍 Key Insights Enabled

* Monthly & yearly sales trends
* Top 10 performing products
* Category and subcategory performance
* Customer purchase behavior
* Outstanding payments & revenue breakdown
* Historical customer data through SCD2

---

## 📁 Project Structure 

```
/SQL Scripts
/SSIS Packages
/SSAS Project
/Power BI Dashboard
/Source Files
```

---

## 🙋 Author

**Mufeez Mujassir**
Undergraduate — SLIIT
Data Engineering & BI Enthusiast
Power BI | SQL | SSIS | SSAS | Data Warehousing

---

## ⭐ Support the Project

If this project helped you, please ⭐ star the repository!

---
