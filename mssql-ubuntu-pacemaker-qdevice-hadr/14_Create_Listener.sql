USE [master];
GO

-- Link datacenter network address coordinates onto availability endpoints definitions
ALTER AVAILABILITY GROUP [ptag]
ADD LISTENER N'Listenerdc' (
    WITH IP ( (N'192.168.1.20', N'255.255.255.0') ), PORT = 1433
);
GO

-- Inject secondary cross-subnet endpoint map reference block variables
ALTER AVAILABILITY GROUP [ptag]
MODIFY LISTENER N'Listenerdc' (
    ADD IP (N'10.0.1.10', N'255.255.255.0')
);
GO
