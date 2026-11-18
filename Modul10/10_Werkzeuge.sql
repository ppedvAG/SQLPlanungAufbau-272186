/*
Thema: Werkzeuge fuer SQL-Server-Monitoring und Performanceanalyse
Funktionsweise: Stellt Diagnosewerkzeuge und ihre typischen Einsatzgebiete gegenueber.
Vorteile: Die Auswahl des passenden Werkzeugs verbessert die Analyse von Engpaessen.
Tipps: Fuer neue Ereignisaufzeichnungen Extended Events dem SQL Server Profiler vorziehen.
*/

/*
Aktivitaetsmonitor
-----------------
Einsatz: Schnelle Ad-hoc-Diagnose aktiver Sessions, Sperren und Ressourcennutzung.
Vorteile: Direkt in SSMS verfuegbar und leicht zugaenglich.
Hinweis: Kein Ersatz fuer ein dauerhaftes Monitoring.

Dynamische Verwaltungssichten (DMVs)
-----------------------------------
Einsatz: Detaillierte Analysen und eigene T-SQL-Berichte, z. B. zu Waits oder Indizes.
Vorteile: Flexibel abfragbar und gut mit weiteren Katalogsichten kombinierbar.
Hinweis: Viele Werte sind Momentaufnahmen oder werden beim Neustart zurueckgesetzt.

Extended Events
---------------
Einsatz: Gezielte Aufzeichnung von Fehlern, Deadlocks, Waits und lang laufenden Abfragen.
Vorteile: Geringer Overhead und detaillierte Filtermoeglichkeiten.
Tipp: Ereignisse moeglichst eng filtern und die Aufzeichnung zeitlich begrenzen.

SQL Server Profiler
-------------------
Einsatz: Nur fuer bestehende Ablaeufe oder wenn eine Profiler-Aufzeichnung benoetigt wird.
Hinweis: Profiler ist eine aeltere Technik; fuer neue Aufzeichnungen Extended Events nutzen.

Windows-Systemmonitor (Perfmon)
-------------------------------
Einsatz: Gemeinsame Langzeitmessung von Betriebssystem- und SQL-Server-Kennzahlen.
Vorteile: CPU, Arbeitsspeicher, Datentraeger und SQL-Zaehler lassen sich korrelieren.

Systemfunktionen
----------------
Einsatz: Einzelne Werte direkt in T-SQL abfragen.
Hinweis: Systemfunktionen liefern in der Regel keine Historie.

Datenbankoptimierungsratgeber (Database Tuning Advisor, DTA)
------------------------------------------------------------
Einsatz: Eine definierte Abfrage-Workload analysieren und Indexvorschlaege erhalten.
Hinweis: Empfehlungen vor der Umsetzung pruefen; zusaetzliche Indizes belasten Schreibvorgaenge.

Query Store
-----------
Einsatz: Abfragen, Ausfuehrungsplaene und Laufzeitstatistiken ueber Zeit vergleichen.
Vorteile: Regressionen koennen auch nach einem Neustart nachvollzogen werden.
Tipp: Query Store muss auf Datenbankebene aktiviert und passend konfiguriert werden.
*/
