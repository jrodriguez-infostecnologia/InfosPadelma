CREATE proc [dbo].[spSeleccionaListaPrecios] 
@empresa int
as

select distinct a.año
from aNovedadLotePrecio a join aNovedad b on a.novedad=b.codigo
where a.empresa=@empresa