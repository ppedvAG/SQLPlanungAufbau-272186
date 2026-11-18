/*
Thema: Views, gespeicherte Prozeduren und Funktionen
Funktionsweise: Zeigt wiederverwendbare Abfragen und Logik in Datenbankobjekten.
Vorteile: Datenbankobjekte koennen Code zentralisieren und wiederverwenden.
Tipps: Beispiele setzen die Northwind-Datenbank voraus; Namen und Schema vor Ausfuehrung pruefen.
*/

USE Northwind;
GO

-- Eine View stellt eine wiederverwendbare Abfrage wie eine Tabelle bereit.
CREATE OR ALTER VIEW dbo.vKundeumsatz
AS
SELECT
    c.CompanyName,
    c.City,
    c.Country,
    o.OrderID,
    o.OrderDate,
    o.Freight,
    o.CustomerID,
    od.ProductID,
    od.UnitPrice,
    od.Quantity,
    p.ProductName
FROM dbo.Customers AS c
INNER JOIN dbo.Orders AS o
    ON c.CustomerID = o.CustomerID
INNER JOIN dbo.[Order Details] AS od
    ON o.OrderID = od.OrderID
INNER JOIN dbo.Products AS p
    ON od.ProductID = p.ProductID;
GO

SELECT *
FROM dbo.vKundeumsatz;
GO

-- Eine Prozedur kann Parameter entgegennehmen und mehrere Anweisungen kapseln.
CREATE OR ALTER PROCEDURE dbo.procDemo
    @par1 INT
AS
BEGIN
    SET NOCOUNT ON;

    SELECT
        c.CompanyName,
        c.City,
        c.Country,
        o.OrderID,
        o.OrderDate,
        o.Freight,
        od.ProductID,
        od.UnitPrice,
        od.Quantity,
        p.ProductName
    FROM dbo.Customers AS c
    INNER JOIN dbo.Orders AS o
        ON c.CustomerID = o.CustomerID
    INNER JOIN dbo.[Order Details] AS od
        ON o.OrderID = od.OrderID
    INNER JOIN dbo.Products AS p
        ON od.ProductID = p.ProductID
    WHERE od.ProductID = @par1;
END;
GO

EXEC dbo.procDemo @par1 = 1;
GO

-- Eine skalare Funktion berechnet die Summe einer Bestellung.
CREATE OR ALTER FUNCTION dbo.fRsumme (@bestnr INT)
RETURNS MONEY
AS
BEGIN
    RETURN
    (
        SELECT SUM(UnitPrice * Quantity)
        FROM dbo.[Order Details]
        WHERE OrderID = @bestnr
    );
END;
GO

SELECT dbo.fRsumme(10248) AS Bestellsumme;
GO

-- Der LIKE-Praefix kann einen Index nutzen; LEFT auf der Spalte meist nicht.
SELECT *
FROM dbo.Customers
WHERE CustomerID LIKE 'A%';

SELECT *
FROM dbo.Customers
WHERE CustomerID = 'ALFKI';
GO
