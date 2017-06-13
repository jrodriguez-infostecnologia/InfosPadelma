CREATE PROCEDURE [dbo].[SpGetgDiagnostico] AS 
select empresa, codigo, codigo +' - '+ descripcion as descripcion from gDiagnostico GO