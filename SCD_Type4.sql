Note: Add History Table (Separate Table for Changes)

CREATE PROCEDURE sp_SCD_Type4
AS
BEGIN
    -- Insert into history table before update
    INSERT INTO Dim_Customer_History (CustomerID, CustomerName, CustomerCity, ChangeDate)
    SELECT d.CustomerID, d.CustomerName, d.CustomerCity, GETDATE()
    FROM Staging_Customer s
    JOIN Dim_Customer d ON s.CustomerID = d.CustomerID
    WHERE d.CustomerCity <> s.CustomerCity;

    -- Update main dimension
    UPDATE d
    SET d.CustomerName = s.CustomerName,
        d.CustomerCity = s.CustomerCity
    FROM Staging_Customer s
    JOIN Dim_Customer d ON s.CustomerID = d.CustomerID;

    -- Insert new customers
    INSERT INTO Dim_Customer (CustomerID, CustomerName, CustomerCity)
    SELECT s.CustomerID, s.CustomerName, s.CustomerCity
    FROM Staging_Customer s
    LEFT JOIN Dim_Customer d ON s.CustomerID = d.CustomerID
    WHERE d.CustomerID IS NULL;
END

