create PROCEDURE [dbo].[spSeleccionaMovimientosResultadoProducto]
	@producto	int,
	@empresa int
AS
/***************************************************************************
Nombre: spSeleccionaMovimientosResultadoProducto
Tipo: Procedimiento Almacenado
Desarrollado: Infos Tegnologia SAS

Argumentos de entrada: Jerarquía de producción, transacción
Argumentos de salida: 
Descripción: Selecciona los análisis resultado asociados a la 
			 jerarquía seleccionada ordenadas por prioridad.
*****************************************************************************/

	select a.movimiento
	from pProductoMovimiento a
	left join iItems b on b.codigo=a.movimiento and b.empresa=a.empresa and b.tipo='M'	and b.activo=1
	where
	a.resultado = 1 and
	a.producto=@producto and
	b.activo = 1 and a.empresa=@empresa
	order by a.prioridad