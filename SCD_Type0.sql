Note:Only inserts new rows. No updates.

CREATE PROCEDURE sp_SCD_Type0
AS
BEGIN
    INSERT INTO Dim_Customer (CustomerID, CustomerName, CustomerCity)
    SELECT s.CustomerID, s.CustomerName, s.CustomerCity
    FROM Staging_Customer s
    LEFT JOIN Dim_Customer d ON s.CustomerID = d.CustomerID
    WHERE d.CustomerID IS NULL;
END
