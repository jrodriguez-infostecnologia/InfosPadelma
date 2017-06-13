CREATE PROCEDURE [dbo].[spConsultaVehiculosPorteria]
	@fechaI	datetime,
	@fechaF	datetime,
	@empresa int
AS
/***************************************************************************
Nombre: spConsultaVehiculosPorteria
Tipo: Procedimiento Almacenado
Desarrollado: Infos Tecnologia SAS

Argumentos de entrada: Fecha inicial, fecha final
Argumentos de salida: 
Descripción: Consulta el movimiento de portería por rango de fecha
*****************************************************************************/

	select a.vehiculo + ' - ' + a.remolque as vehiculo,a.fechaEntrada  fechaIn,
	case a.estado
		when 'EP' then null
		else a.fechasalida  
	end fechaOut,a.codigoConductor idOperario,a.nombreConductor  nombreOperario,
	a.usuario funcionario,a.estado,b.descripcion ,a.remision
	from bRegistroPorteria a
	join sUsuarios b on  b.usuario =a.usuario
	where
	convert(date, a.fechaEntrada) between @fechaI and @fechaF
	
	order by fechaEntrada