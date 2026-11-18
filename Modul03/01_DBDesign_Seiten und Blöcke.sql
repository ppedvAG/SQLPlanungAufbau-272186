/*
Thema: Datenseiten und Extents
Funktionsweise: Zeigt den Aufbau von Seiten und den Einfluss breiter Zeilen.
Vorteile: Das Verstaendnis des Seitenlayouts hilft bei der Analyse von Speicher und I/O.
Tipps: Fuer aktuelle Analysen sys.dm_db_index_physical_stats statt DBCC SHOWCONTIG nutzen.
*/

USE Northwind;
GO

-- Eine breite Zeile veranschaulicht den Einfluss des Seitenauslastungsgrads.
DROP TABLE IF EXISTS dbo.t1;
CREATE TABLE dbo.t1
(
    id INT IDENTITY(1, 1),
    spx CHAR(4100)
);
GO

-- Wiederhole den Einfuegevorgang, um ausreichend Seiten zu belegen.
INSERT INTO dbo.t1 (spx)
VALUES ('XY');
GO 20000

-- DBCC SHOWCONTIG ist veraltet, veranschaulicht aber die Seitenverteilung.
DBCC SHOWCONTIG ('dbo.t1');
GO

-- Die DMV liefert detaillierte physische Statistiken zum Heap.
SELECT *
FROM sys.dm_db_index_physical_stats
(
    DB_ID(),
    OBJECT_ID(N'dbo.t1'),
    NULL,
    NULL,
    N'DETAILED'
);
GO

-- CHAR(4100) verhindert eine volle Belegung jeder einzelnen Datenseite.
