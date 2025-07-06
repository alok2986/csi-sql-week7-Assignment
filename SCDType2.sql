Note: Track changes by inserting a new version with StartDate, EndDate, and IsCurrent.
(  Add New Row (Track History) )

CREATE PROCEDURE sp_SCD_Type2
AS
BEGIN
    -- Expire existing row
    UPDATE d
    SET d.EndDate = GETDATE(), d.IsCurrent = 0
    FROM Dim_Customer d
    JOIN Staging_Customer s ON d.CustomerID = s.CustomerID
    WHERE d.IsCurrent = 1 AND (d.CustomerName <> s.CustomerName OR d.CustomerCity <> s.CustomerCity);

    -- Insert new row
    INSERT INTO Dim_Customer (CustomerID, CustomerName, CustomerCity, StartDate, EndDate, IsCurrent)
    SELECT s.CustomerID, s.CustomerName, s.CustomerCity, GETDATE(), NULL, 1
    FROM Staging_Customer s
    JOIN Dim_Customer d ON s.CustomerID = d.CustomerID
    WHERE d.IsCurrent = 1 AND (d.CustomerName <> s.CustomerName OR d.CustomerCity <> s.CustomerCity);

    -- Insert brand new customer
    INSERT INTO Dim_Customer (CustomerID, CustomerName, CustomerCity, StartDate, EndDate, IsCurrent)
    SELECT s.CustomerID, s.CustomerName, s.CustomerCity, GETDATE(), NULL, 1
    FROM Staging_Customer s
    LEFT JOIN Dim_Customer d ON s.CustomerID = d.CustomerID
    WHERE d.CustomerID IS NULL;
END
