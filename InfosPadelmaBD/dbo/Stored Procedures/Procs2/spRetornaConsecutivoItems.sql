create proc [dbo].[spRetornaConsecutivoItems]
@empresa int,
@consecutivo int output
as

set @consecutivo = isnull((select top 1 codigo from iItems 
					order by codigo desc),0) + 1