/*
Thema: Performance-Monitor-Indikatoren
Funktionsweise: Erlaeutert wichtige Windows- und SQL-Server-Leistungsindikatoren.
Vorteile: Perfmon kann Betriebssystem- und SQL-Metriken gemeinsam ueber Zeit aufzeichnen.
Tipps: Einzelne Schwellenwerte nie isoliert bewerten, sondern mit Workload und Verlauf vergleichen.
*/

/*
Prozessor: Prozessorzeit
------------------------
Eine dauerhaft hohe Prozessorzeit sollte untersucht werden. Moegliche Ursachen sind
Kompilierungen, Auslagerungen oder eine hohe Abfragelast.

PhysicalDisk: Average Disk Queue Length
---------------------------------------
Der Wert beschreibt ausstehende I/O-Anforderungen. Kurzzeitige Spitzen sind nicht
automatisch ein Problem; Datentraeger und Latenz gemeinsam beurteilen.

Memory: Pages/sec
-----------------
Dieser Zaehler zeigt Seitenbewegungen zwischen Arbeitsspeicher und Datentraeger.
Ein dauerhaft hoher Wert kann auf Speicherdruck hinweisen.

SQLServer: Buffer Manager: Buffer cache hit ratio
-------------------------------------------------
Der Zaehler beschreibt, wie oft angeforderte Seiten aus dem Buffer Pool bedient
werden. Er ist allein kein verlaesslicher Indikator fuer ausreichenden Arbeitsspeicher.

SQLServer: Buffer Manager: Page life expectancy
-----------------------------------------------
Die Verweildauer von Seiten im Buffer Pool ist im Verlauf und zusammen mit anderen
Kennzahlen zu beurteilen. Ein einzelner Grenzwert ist keine allgemeingueltige Diagnose.

SQLServer: SQL Statistics: Compilations/sec und Re-Compilations/sec
-------------------------------------------------------------------
Viele Kompilierungen koennen CPU kosten. Abfrageparametrisierung und Plan-Wiederverwendung
koennen helfen; Recompilierungen haben jedoch auch sinnvolle Ausloeser.

SQLServer: General Statistics: User Connections
-----------------------------------------------
Zeigt die Anzahl der Benutzerverbindungen. Zusammen mit Batch Requests/sec laesst
sich die aktuelle Auslastung besser einordnen.

SQLServer: Locks und Latches
----------------------------
Lange Wartezeiten koennen auf Sperrkonflikte oder konkurrierende Zugriffe auf interne
Ressourcen hindeuten. Die Ursache sollte mit DMVs oder Extended Events untersucht werden.
*/
