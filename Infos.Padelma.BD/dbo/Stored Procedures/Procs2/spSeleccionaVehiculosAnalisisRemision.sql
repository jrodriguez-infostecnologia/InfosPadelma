
CREATE PROCEDURE [dbo].[spSeleccionaVehiculosAnalisisRemision]
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


	select a.numero,a.pesoTara,b.descripcion cliente,d.descripcion proveedor,c.producto,c.cantidad,
	c.vehiculo,c.remolque,c.nombreConductor,a.tipo
	from bRegistroBascula a
	left join logProgramacionVehiculo c on c.numero=a.remision and c.empresa=a.empresa
	left join cTercero b on b.id= c.tercero and b.empresa=a.empresa
	join  cTercero d on d.id=c.comercializadora 
	join iItems e on e.codigo=a.item and e.empresa=a.empresa
	where
	a.numero = @remision and
	a.estado = 'PP' and
	a.empresa=@empresa
	and a.analisisRegistrado=0
	and a.tipo in ( @tipotrasalida, @tipotrasalidaAlt)
	
	union
	
	select a.numero,a.pesoTara,'','',a.item producto,a.pesoNeto,a.vehiculo,a.remolque,b.nombreConductor  nombreOperario,
	a.tipo
	from bRegistroBascula a
	join bRegistroPorteria b on b.numero=a.remision and b.empresa=a.empresa
	join iItems e on e.codigo=a.item and e.empresa=a.empresa
	where
	a.remision = b.numero and
	a.numero = @remision and
	a.estado='PP'
	and 
	a.empresa=@empresa
	and analisisRegistrado=0
	and a.tipo in (@tipotraentrada, @tipotraentradaAlt)