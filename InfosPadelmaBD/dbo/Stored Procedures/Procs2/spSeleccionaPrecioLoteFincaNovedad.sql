CREATE proc [dbo].[spSeleccionaPrecioLoteFincaNovedad]
@empresa int,
@novedad int,
@finca varchar(50),
@lote varchar(50),
@manejaLote bit,
@precio money output
as

if @manejaLote=1
begin
	set @precio=  isnull((select precio  FROM aNovedadLotePrecio
	where empresa= @empresa and novedad=@novedad and finca=@finca
	and lote =@lote and modificado=0),0)
end
else
begin
	set @precio=  isnull((select precio  FROM aNovedadLotePrecio
	where empresa= @empresa and novedad=@novedad and finca=@finca and lote is null
	and modificado=0),0)
end