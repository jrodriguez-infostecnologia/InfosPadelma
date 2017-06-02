CREATE proc [dbo].[spRetornaConsecutivoAutomatico]
@tabla varchar(50),
@campo varchar(50),
@empresa int
as

DECLARE @sql NVARCHAR(MAX)
SET @sql = 'SELECT  isnull((SELECT TOP 1 ' + 'max('+ @campo + ') + 1 FROM ' + @Tabla + ' where empresa=' + convert(varchar(50),@empresa) + '),0) + 1 valor'

EXEC sp_executesql @sql