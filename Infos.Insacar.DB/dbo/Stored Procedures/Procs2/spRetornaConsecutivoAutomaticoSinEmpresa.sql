create proc [dbo].[spRetornaConsecutivoAutomaticoSinEmpresa]
@tabla varchar(50),
@campo varchar(50)
as

DECLARE @sql NVARCHAR(MAX)
SET @sql = 'SELECT  isnull((SELECT TOP 1 ' + @campo + ' FROM ' + @Tabla + ' order BY '+@campo + ' DESC),0) + 1 valor'

EXEC sp_executesql @sql