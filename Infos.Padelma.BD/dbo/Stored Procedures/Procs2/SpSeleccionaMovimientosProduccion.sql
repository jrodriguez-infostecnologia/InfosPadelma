CREATE proc [dbo].[SpSeleccionaMovimientosProduccion]
@producto int,
@empresa int,
@modulo varchar(150)
as


	select ROW_NUMBER()  OVER(ORDER BY a.orden asc) AS Registro, a.movimiento, b.descripcion, 0 valor, a.resultado, b.tipo,
	a.orden, c.desCorta umedida, a.mCalcular
	 from pProductoMovimiento a
	join iItems b on b.codigo=a.movimiento and b.empresa=a.empresa and b.tipo in('M','V','C', 'SA','VS','CS')	and a.modulo=@modulo
	join gUnidadMedida c on c.codigo=b.uMedidaConsumo and c.empresa=b.empresa
	where a.producto=@producto
	and a.empresa=@empresa and b.activo=1
	order by Registro