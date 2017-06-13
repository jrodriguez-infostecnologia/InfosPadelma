CREATE proc [dbo].[SpSeleccionaMovimientosProduccion]
@producto int,
@empresa int
as


	select ROW_NUMBER()  OVER(ORDER BY a.orden asc) AS Registro, a.movimiento, b.descripcion, 0 valor, a.resultado 
	 from pProductoMovimiento a
	join iItems b on b.codigo=a.movimiento and b.empresa=a.empresa and b.tipo='M'
	where a.producto=@producto
	and a.empresa=@empresa
	order by Registro