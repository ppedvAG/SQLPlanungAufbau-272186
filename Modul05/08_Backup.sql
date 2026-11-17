/* BACKUP


1. DB korrupt
2. Daten versehentlich verfälscht
3. Tabelle gelöscht
4. Server tot-- > DB Backup auf anderen Server restoren
5. Server tot--> HDD sind noch ok
  a) beide Dateien (mdf und ldf) sind vorhanden
  b) mdf vohanden , aber ldf ist futsch
6. Wenn ich wüsste, dass gleich was passiert
   

Backuptypen:

V ollständige Sicherung
Checkpoint
alle Dateien gesichert inkl Pfad , Größe
sichert einen Zeitpunkt 
Sicherung ist online

D ifferentielle Sicherung
Checkpoint
merkt sich alle Blöcke, die Änderungen 
seit dem letzten V enthalten
Sicherung ist online

T ransaktionsprotkollsicherung
Checkpoint
merkt sich alle Anweisungen
(wie ein Makro)
Sicherung ist online
mit dem T läßt sich ein beliebiger Zeitpunkt restoren
auf Sekunde genau 


Wiederherstellungsmodel

Einfach 
es werden alle TX rudimentär mitgeschrieben
und dann gelöscht

------------------
TXUC  TXUC   TX 
------------------

dann keine Sicherung des T Log

nur V und D möglich


Massenprotokolliert
wie Einfach
aber es wird nichts gelöscht
es läßt sich ein Zeitpukt restoren


==> du musst das TLog sichern !! da es sonst permanent wächst


Vollständig
protokolliert umfangreich
es schreibt mehr weg
man kann auf die sek restoren


--in Prodktionsumgebung mist vollständig


 




! V
	T
	T
	T
	 D
	T
	T
	T
	! D
	! T
	! T
	! T



--Fall 2: Daten vesehentlich manipuliert
--= Fall 3


--Idee: wir stellen die DB unter anderen Namen wieder her

funktioniert nur, wenn wir wissen was exakt geändert wurde

USE [master]
RESTORE DATABASE [NORTHWIND2] FROM  DISK = N'C:\_SQLBackup\NORTHWIND.bak' WITH  FILE = 1,  MOVE N'NORTHWIND'
TO N'C:\_SQLDB\NORTHWINDdsd2.mdf',  MOVE N'NORTHWIND_log'
TO N'C:\_SQLDB\NORTHWIND2_log.ldf',  NORECOVERY,  NOUNLOAD,  STATS = 5
RESTORE DATABASE [NORTHWIND2] FROM  DISK = N'C:\_SQLBackup\NORTHWIND.bak' WITH  FILE = 9,  NORECOVERY,  NOUNLOAD,  STATS = 5
RESTORE LOG [NORTHWIND2] FROM  DISK = N'C:\_SQLBackup\NORTHWIND.bak' WITH  FILE = 10,  NORECOVERY,  NOUNLOAD,  STATS = 5
RESTORE LOG [NORTHWIND2] FROM  DISK = N'C:\_SQLBackup\NORTHWIND.bak' WITH  FILE = 11,  NORECOVERY,  NOUNLOAD,  STATS = 5
RESTORE LOG [NORTHWIND2] FROM  DISK = N'C:\_SQLBackup\NORTHWIND.bak' WITH  FILE = 12,  NOUNLOAD,  STATS = 5

GO


Fall 4: Bak DAtein in Backup Ordner legen.
	    evtl Pfade korrigieren

Fall 5 : DB Dateien konnten vom toten Server gerettet werden

DB Dateien wieder anfügen
Fehlendes Logfile kann automatisch ersetzt werden (bzw wird erstellt)



--Fall 1 : DB muss tats direkt restored werden.. DB läuft

--Es soll so wenig wie möglich DAtenverlust entstehen

--Letzte TLog:             11:00
--nächste Sicherung Tlog : 12:00

--Error um : 11:17
--Aktuelle Zeit : 11:21

--Idee Nr1: Restore von 11 Uhr --> Verlust: 21 min

--Idee2: Wir warten bis 12 Uhr.  
		Autom. Logsicherung läuft
		Restore von 11:16
		Verlust: im Backup fast alles da
		DB aber ZUstand 11:16

-- Idee 3: 
		manuelle Sicherung um 11:21..dauert 5 min 
		Restore von 11:16:59
		Verlust 5 min, weil Sicherung online lief und Leute weiter gearbeitet haben

-- Idee 4:
         User von der DB runterwerfen
		 Sicherung um 11:21 des Tlog
		 Restore von 11:16:59

USE [master]
ALTER DATABASE [NORTHWIND] SET SINGLE_USER WITH ROLLBACK IMMEDIATE
BACKUP LOG [NORTHWIND] TO  DISK = N'C:\_SQLBackup\NORTHWIND_LogBackup_2026-11-17_11-49-02.bak' WITH NOFORMAT, NOINIT,  NAME = N'NORTHWIND_LogBackup_2026-11-17_11-49-02', NOSKIP, NOREWIND, NOUNLOAD,  NORECOVERY ,  STATS = 5
RESTORE DATABASE [NORTHWIND] FROM  DISK = N'C:\_SQLBackup\NORTHWIND.bak' WITH  FILE = 1,  NORECOVERY,  NOUNLOAD,  REPLACE,  STATS = 5
RESTORE DATABASE [NORTHWIND] FROM  DISK = N'C:\_SQLBackup\NORTHWIND.bak' WITH  FILE = 9,  NORECOVERY,  NOUNLOAD,  STATS = 5
RESTORE LOG [NORTHWIND] FROM  DISK = N'C:\_SQLBackup\NORTHWIND.bak' WITH  FILE = 10,  NORECOVERY,  NOUNLOAD,  STATS = 5
RESTORE LOG [NORTHWIND] FROM  DISK = N'C:\_SQLBackup\NORTHWIND.bak' WITH  FILE = 11,  NORECOVERY,  NOUNLOAD,  STATS = 5
RESTORE LOG [NORTHWIND] FROM  DISK = N'C:\_SQLBackup\NORTHWIND.bak' WITH  FILE = 12,  NORECOVERY,  NOUNLOAD,  STATS = 5
RESTORE LOG [NORTHWIND] FROM  DISK = N'C:\_SQLBackup\NORTHWIND_LogBackup_2026-11-17_11-49-02.bak' WITH  NOUNLOAD,  STATS = 5,  STOPAT = N'2026-11-17T11:16:52'
ALTER DATABASE [NORTHWIND] SET MULTI_USER

GO





