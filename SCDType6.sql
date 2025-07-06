Note: Hybrid of Types 1 + 2 + 3
Maintains full history (like Type 2), overwrites some fields (Type 1), and stores some past values (Type 3).

CREATE PROCEDURE sp_SCD_Type6
AS
BEGIN
    -- Expire current row
    UPDATE d
    SET d.EndDate = GETDATE(), d.IsCurrent = 0
    FROM Dim_Customer d
    JOIN Staging_Customer s ON s.CustomerID = d.CustomerID
    WHERE d.IsCurrent = 1 AND (d.CustomerCity <> s.CustomerCity);

    -- Insert new row with history (Type 2), and keep PreviousCity (Type 3), overwrite other fields (Type 1)
    INSERT INTO Dim_Customer (CustomerID, CustomerName, CustomerCity, PreviousCity, StartDate, EndDate, IsCurrent)
    SELECT s.CustomerID, s.CustomerName, s.CustomerCity, d.CustomerCity, GETDATE(), NULL, 1
    FROM Staging_Customer s
    JOIN Dim_Customer d ON s.CustomerID = d.CustomerID
    WHERE d.IsCurrent = 1 AND (d.CustomerCity <> s.CustomerCity);

    -- Insert new customers
    INSERT INTO Dim_Customer (CustomerID, CustomerName, CustomerCity, PreviousCity, StartDate, EndDate, IsCurrent)
    SELECT s.CustomerID, s.CustomerName, s.CustomerCity, NULL, GETDATE(), NULL, 1
    FROM Staging_Customer s
    LEFT JOIN Dim_Customer d ON s.CustomerID = d.CustomerID
    WHERE d.CustomerID IS NULL;
END
