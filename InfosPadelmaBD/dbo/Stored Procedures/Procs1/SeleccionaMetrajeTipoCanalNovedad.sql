CREATE proc [dbo].[SeleccionaMetrajeTipoCanalNovedad]
@novedad varchar(50),
@lote varchar(50),
@empresa int,
@retorno decimal(18,2) output
as

declare @tipocanal varchar(50)
set @tipocanal = (select tipoCanal from anovedad where codigo=@novedad and empresa=@empresa)

set @retorno = isnull((select  sum(metros)  from alotescanal 
where lote=@lote and tipocanal = @tipoCanal and empresa=@empresa),0)