-- Create Staging Table
CREATE TABLE Staging_Customer (
    CustomerID INT,
    CustomerName VARCHAR(100),
    CustomerCity VARCHAR(100)
);

-- Dimension Table for SCD Types 0, 1, 3
CREATE TABLE Dim_Customer (
    CustomerID INT PRIMARY KEY,
    CustomerName VARCHAR(100),
    CustomerCity VARCHAR(100),
    PreviousCity VARCHAR(100) NULL,      -- For SCD Type 3 and 6
    StartDate DATETIME NULL,             -- For SCD Type 2 and 6
    EndDate DATETIME NULL,               -- For SCD Type 2 and 6
    IsCurrent BIT                        -- For SCD Type 2 and 6
);

-- History Table for SCD Type 4
CREATE TABLE Dim_Customer_History (
    CustomerID INT,
    CustomerName VARCHAR(100),
    CustomerCity VARCHAR(100),
    ChangeDate DATETIME
);
