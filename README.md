# csi-sql-week7-Assignment
# SCD Assignment – SQL Stored Procedures

This repository contains stored procedures for implementing all types of Slowly Changing Dimensions (SCD) using SQL Server (SSMS).

## 📘 Description

Each file implements one of the following SCD types:
- **SCD Type 0**: Fixed Attributes (No changes)
- **SCD Type 1**: Overwrites data
- **SCD Type 2**: Maintains full history by adding rows
- **SCD Type 3**: Stores limited history in the same row
- **SCD Type 4**: Maintains a separate history table
- **SCD Type 6**: Hybrid of Type 1, 2, and 3

## 🧱 Schema Setup

Run the `Staging_and_Dimension_Schema.sql` file first to create the necessary tables.

## 💻 How to Use

1. Open SQL Server Management Studio (SSMS).
2. Run `Staging_and_Dimension_Schema.sql`.
3. Run any of the stored procedures (`SCD_Type1.sql`, etc.).
4. Populate `Staging_Customer` table and execute procedures to see changes in `Dim_Customer`.

## 📦 Software Used

- Microsoft SQL Server Management Studio (SSMS)
