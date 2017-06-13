create proc [dbo].[spRetornaDsReferenciaTransaccion]
@empresa int,
@tipoTransaccion varchar(50),
@retorno varchar(50) output
as

select @retorno= vistaDs from gTipoTransaccion
where empresa=@empresa and codigo=@tipoTransaccion