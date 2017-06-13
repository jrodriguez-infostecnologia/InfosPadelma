CREATE PROCEDURE [dbo].[spSeleccionaVehiculosAnalisisRemisionModificacion]
	@remision			varchar(50),
	@empresa			int
AS
/***************************************************************************
Nombre: spSeleccionaVehiculosAnalisisRemision
Tipo: Procedimiento Almacenado
Desarrollado: Infos Tecnologia SAS

Argumentos de entrada: Tipo de transacción, número de remisión
Argumentos de salida: 
Descripción: Selecciona los vehículos listos para el registro de análisis de
		     laboratorio por número de remisión.
*****************************************************************************/

	declare @tipotraentrada varchar(50) =  (select entradas from gParametrosGenerales where empresa=@empresa)
	declare @tipotrasalida varchar(50) =  (select salidas from gParametrosGenerales where empresa=@empresa)
		declare @tipotraentradaAlt varchar(50) =  (select entradasAlt from gParametrosGenerales where empresa=@empresa)
	declare @tipotrasalidaAlt varchar(50) =  (select salidasAlt from gParametrosGenerales where empresa=@empresa)

	select distinct a.numero,a.pesoTara,b.descripcion cliente,d.descripcion proveedor,c.producto,c.cantidad,
	c.vehiculo,c.remolque,c.nombreConductor,c.vehiculo + ' - ' + c.remolque + ' - ' + e.descripcionAbreviada as cadena
	from bRegistroBascula a
	join logProgramacionVehiculo c on c.numero=a.remision and c.empresa=a.empresa
	left join cTercero b on b.codigo= c.cliente and b.empresa=c.empresa
	left join  cTercero d on d.id=c.comercializadora and d.empresa=a.empresa
	left join iItems e on e.codigo=a.item and e.empresa=a.empresa

	--select * from logProgramacionVehiculo where numero='DPT000000000350'

	where
	a.analisisRegistrado = 0
	and a.empresa=@empresa
	and a.tipo in ( @tipotrasalida, @tipotrasalidaAlt) and
	a.estado='PP' 
	union
	select  distinct a.numero,a.pesoTara,a.procedencia,'',a.item  producto,a.pesoNeto,a.vehiculo,a.remolque,b.nombreConductor nombreOperario,
	a.vehiculo + ' - ' + a.remolque + ' - ' + + e.descripcionAbreviada as cadena
	from bRegistroBascula a
	join bRegistroPorteria b on b.numero=a.remision and b.empresa=a.empresa
	join iItems e on e.codigo=a.item and e.empresa=a.empresa
	where
	a.empresa=@empresa and 
	a.estado='PP' and
	a.analisisRegistrado = 0 and	
    a.tipo in (@tipotraentrada, @tipotraentradaAlt) and
	a.item not in ( select valor from gParametros where	codigo IN ( 'codigoFruta', 'codigoFrutaPAL') )