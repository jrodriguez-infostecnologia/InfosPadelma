
CREATE PROCEDURE [dbo].[spSeleccionaVehiculosAnalisis]
	@empresa int
AS
/***************************************************************************
Nombre: spSeleccionaVehiculosAnalisis
Tipo: Procedimiento Almacenado
Desarrollado: Infos Tecnologia SAS

Argumentos de entrada:
Argumentos de salida: 
Descripción: Selecciona los vehículos listos para el registro de análisis de
		     laboratorio.
*****************************************************************************/

	select a.numero,a.pesoTara,b.descripcion cliente,d.descripcion proveedor,c.producto,c.cantidad,
	c.vehiculo,c.remolque,c.nombreConductor,c.vehiculo + ' - ' + c.remolque + ' - ' + e.descripcionAbreviada as cadena
	from bRegistroBascula a
	join logProgramacionVehiculo c on c.numero=a.remision and c.empresa=a.empresa
	left join cTercero b on b.codigo= c.cliente and b.empresa=c.empresa
	left join  cTercero d on d.id=c.comercializadora
	left join iItems e on e.codigo=a.item and e.empresa=a.empresa
	where
	a.analisisRegistrado = 0
	and a.empresa=@empresa
	union
	select a.numero,a.pesoTara,a.procedencia,'',a.item  producto,a.pesoNeto,a.vehiculo,a.remolque,b.nombreConductor nombreOperario,
	a.vehiculo + ' - ' + a.remolque + ' - ' + + e.descripcionAbreviada as cadena
	from bRegistroBascula a
	join bRegistroPorteria b on b.numero=a.remision and b.empresa=a.empresa
	join iItems e on e.codigo=a.item and e.empresa=a.empresa
	where
	a.empresa=@empresa and 
	a.analisisRegistrado = 0 and	
	a.tipo not in ('PES','DPT','ANULADO') and
	a.item not in ( select valor from gParametros where	codigo IN ( 'codigoFruta', 'codigoFrutaPAL') )



	--SELECT * FROM iItems