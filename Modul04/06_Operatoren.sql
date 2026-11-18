/*
Thema: SQL-Agent-Operatoren
Funktionsweise: Legt in msdb einen Operator als Empfaenger fuer Agent-Benachrichtigungen an.
Vorteile: Operatoren zentralisieren die Kontaktinformationen fuer Warnungen und Auftraege.
Tipps: Vor Ausfuehrung die Beispiel-E-Mail-Adresse durch eine gueltige Adresse ersetzen.
*/

-- Kontaktliste

--nur Operatoren können innerhalb eines Auftrags als  Nachrichten gesendet bekommen

USE [msdb]
GO
EXEC msdb.dbo.sp_add_operator @name=N'SQLAdmins', 
		@enabled=1, 
		@pager_days=0, 
		@email_address=N'andreasr@ppedv.de'
GO
