CREATE PROCEDURE [dbo].[spSeleccionaProgramacionCargaCab]
	@año	int,
	@mes	int,
	@empresa int
AS
/***************************************************************************
Nombre: spSeleccionaProgramacionCargaCab
Tipo: Procedimiento Almacenado
Desarrollado: Infos Tecnologia SAS

Argumentos de entrada: Periodo
Argumentos de salida: 
Descripción: Selecciona la programación de carga por periodo
*****************************************************************************/

	select a.programacion,a.año,a.mes, b.descripcion,a.producto , c.descripcionAbreviada desProducto ,sum( a.cantidad ) cantidad,
	( select isnull( sum( cantidad ),0 ) from logProgramacionVehiculo b
	  where
	  b.programacionCarga = a.programacion ) cantidadProgramada,
	( select isnull( sum( pesoNeto / 1000 ),0 ) from bRegistroBascula c
	  where
	  c.remision = a.programacion ) cantidadDespachada	
	from logProgramacionGeneral a
	join fMercado b  on b.codigo=a.mercado and b.empresa=a.empresa
	join iItems c on c.codigo=a.producto and c.empresa=a.empresa
	where
	a.año=@año
	and a.mes=@mes
	and a.empresa=@empresa
	group by a.programacion,b.descripcion,a.producto,a.año,a.mes,c.descripcionAbreviada
	order by b.descripcion,a.producto