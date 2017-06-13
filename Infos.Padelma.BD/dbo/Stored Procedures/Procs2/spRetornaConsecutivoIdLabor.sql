CREATE proc [dbo].[spRetornaConsecutivoIdLabor]
@tabla varchar(50),
@id varchar(50)
--,@retorno int output
as
--if not exists(select top 1 * from @tabla)
--set @retorno=1
--else
--select top 1  @retorno= codigo + 1 from aLabor
--order by codigo desc

DECLARE @sql NVARCHAR(MAX)
SET @sql = 'SELECT  isnull((SELECT TOP 1 ' + @id + ' FROM ' + @Tabla + ' order BY '+@id + ' DESC),1) valor'

EXEC sp_executesql @sql