-- ========================================================================
-- RUNBOOK STEP 9: CONNECT CROSS-NODE CREDENTIAL REPLICATION HANDSHAKES
-- ========================================================================

-- SECTION A: RUN THIS BLOCK ON THE PRIMARY NODE (rh-staging1 / 10.1.0.5)
USE [MASTER];
GO
CREATE LOGIN aglogin WITH PASSWORD = 'C!axPa$$lp';
GO
CREATE USER aglogin FOR LOGIN aglogin;
GO
-- Import secondary security block mapping tracks
CREATE CERTIFICATE db2 AUTHORIZATION aglogin FROM FILE = '/var/opt/mssql/backup/agcerts/db2.cer';
GO
GRANT CONNECT ON ENDPOINT::mssqldbep TO [aglogin];
GO


-- SECTION B: RUN THIS BLOCK ON THE SECONDARY NODE (rh-staging2 / 10.1.0.6)
/*
USE [MASTER];
GO
CREATE LOGIN aglogin WITH PASSWORD = 'C!axPa$$lp';
GO
CREATE USER aglogin FOR LOGIN aglogin;
GO
-- Import primary security block mapping tracks
CREATE CERTIFICATE db1 AUTHORIZATION aglogin FROM FILE = '/var/opt/mssql/backup/agcerts/db1.cer';
GO
GRANT CONNECT ON ENDPOINT::mssqldbep TO [aglogin];
GO
*/
