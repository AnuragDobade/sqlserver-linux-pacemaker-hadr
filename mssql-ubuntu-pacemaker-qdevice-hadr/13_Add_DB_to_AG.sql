USE [master];
GO

-- Construct production target operational schema
IF NOT EXISTS(SELECT * FROM sys.databases WHERE name = 'paylab')
    CREATE DATABASE [paylab];
GO

ALTER DATABASE [paylab] SET RECOVERY FULL;
GO

-- Take standard database baseline sync backups logs markers
BACKUP DATABASE [paylab] TO DISK = '/var/opt/mssql/data/paylab_base_seed.bak' WITH FORMAT, INIT;
GO

-- Bind target schemas onto tracking availability group layout matrices
ALTER AVAILABILITY GROUP [ptag] ADD DATABASE [paylab];
GO
