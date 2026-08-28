-- ========================================================================
-- RUNBOOK STEP 11: WORKLOAD SYNCHRONIZATION PIPELINE MIGRATIONS
-- ========================================================================

-- Execute on Primary Server Endpoint Configuration Connection Windows:
USE master;
GO

CREATE DATABASE PayLab;
GO
ALTER DATABASE PayLab SET RECOVERY FULL; -- Critical transaction trail requirement
GO

-- Prepare complete initial full and differential log recovery file loops
BACKUP DATABASE PayLab TO DISK = '/var/opt/mssql/backup/dr_db.bak' WITH COMPRESSION, STATS = 30;
BACKUP LOG PayLab TO DISK = '/var/opt/mssql/backup/dr_db.trn' WITH COMPRESSION, STATS = 30;
GO

-- Inject workspace parameters into active replication queues
ALTER AVAILABILITY GROUP [ptag] ADD DATABASE [PayLab];
GO

-- ========================================================================
-- AUTOMATED STORAGE RESTORATION ASSIGNMENTS
-- Run on Secondary Instance Query Profiles to confirm ingestion streams:
-- ========================================================================
/*
ALTER AVAILABILITY GROUP [ptag] GRANT CREATE ANY DATABASE;
GO
*/
