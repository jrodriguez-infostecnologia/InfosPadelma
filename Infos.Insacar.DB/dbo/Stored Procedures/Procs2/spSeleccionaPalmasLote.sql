CREATE proc [dbo].[spSeleccionaPalmasLote]
@lote varchar(50),
@empresa int,
@retorno int output
as
set  @retorno = isnull((select palmasProduccion from alotes
where codigo=@lote and empresa=@empresa),0)