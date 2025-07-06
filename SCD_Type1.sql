Note: Update existing data with new values.
  (Overwrite Old Data (No History))

CREATE PROCEDURE sp_SCD_Type1
AS
BEGIN
    -- Update existing rows
    UPDATE d
    SET d.CustomerName = s.CustomerName,
        d.CustomerCity = s.CustomerCity
    FROM Staging_Customer s
    JOIN Dim_Customer d ON s.CustomerID = d.CustomerID;

    -- Insert new rows
    INSERT INTO Dim_Customer (CustomerID, CustomerName, CustomerCity)
    SELECT s.CustomerID, s.CustomerName, s.CustomerCity
    FROM Staging_Customer s
    LEFT JOIN Dim_Customer d ON s.CustomerID = d.CustomerID
    WHERE d.CustomerID IS NULL;
END
