/*
Thema: Query Store
Funktionsweise: Speichert Abfrageplaene und Laufzeitstatistiken im Zeitverlauf.
Vorteile: Historische Daten erleichtern die Diagnose von Leistungseinbruechen.
Tipps: Speicherlimit, Aufbewahrung und Erfassungsmodus passend zur Datenbank konfigurieren.
*/

-- Aktiviert den Query Store fuer eine Datenbank.
ALTER DATABASE [Northwind]
SET QUERY_STORE = ON;
GO

-- Beispiel: aktuelle Query-Store-Statistiken mit Abfrage und Plan anzeigen.
SELECT TOP (20)
    q.query_id,
    p.plan_id,
    rs.count_executions,
    rs.avg_duration,
    rs.avg_cpu_time,
    rs.avg_logical_io_reads,
    rs.last_execution_time,
    qt.query_sql_text
FROM sys.query_store_query_text AS qt
INNER JOIN sys.query_store_query AS q
    ON qt.query_text_id = q.query_text_id
INNER JOIN sys.query_store_plan AS p
    ON q.query_id = p.query_id
INNER JOIN sys.query_store_runtime_stats AS rs
    ON p.plan_id = rs.plan_id
ORDER BY rs.last_execution_time DESC;
GO

-- Query-Store-Werte wie Dauer und CPU-Zeit werden in Mikrosekunden angegeben.
-- Plan-Forcing kann eine Regression abmildern, sollte aber regelmaessig ueberprueft werden.
