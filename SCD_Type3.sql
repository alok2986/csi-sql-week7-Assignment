Note: Track Limited History in Same Row
(Add columns like PreviousCity, update them during change.)

CREATE PROCEDURE sp_SCD_Type3
AS
BEGIN
    -- Update changed data with limited history
    UPDATE d
    SET d.PreviousCity = d.CustomerCity,
        d.CustomerCity = s.CustomerCity
    FROM Staging_Customer s
    JOIN Dim_Customer d ON s.CustomerID = d.CustomerID
    WHERE d.CustomerCity <> s.CustomerCity;

    -- Insert new customers
    INSERT INTO Dim_Customer (CustomerID, CustomerName, CustomerCity, PreviousCity)
    SELECT s.CustomerID, s.CustomerName, s.CustomerCity, NULL
    FROM Staging_Customer s
    LEFT JOIN Dim_Customer d ON s.CustomerID = d.CustomerID
    WHERE d.CustomerID IS NULL;
END
