create proc [dbo].[spSeleccionaNoPalmasLote]
@empresa int,
@lote varchar(50),
@retorno int output
as

select @retorno =  sum(palmasProduccion) from aLotes
where empresa=@empresa and codigo=@lote

if @retorno is null
set @retorno=0