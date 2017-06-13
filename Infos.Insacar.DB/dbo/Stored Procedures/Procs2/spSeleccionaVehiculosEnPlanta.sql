CREATE PROCEDURE [dbo].[spSeleccionaVehiculosEnPlanta]
	@planta varchar(50),
	@empresa int
	
AS
/***************************************************************************
Nombre: spSeleccionaVehiculosEnPlanta
Tipo: Procedimiento Almacenado
Desarrollado: Inofos Tecnologia SAS
Fecha: 03/12/2014

Argumentos de entrada: Planta extractora
Argumentos de salida: 
Descripción: Selecciona los vehiculos que se encuentran en la planta.
*****************************************************************************/

			
	select a.fechaEntrada,a.remolque,a.vehiculo,a.codigoConductor,a.nombreConductor,a.numero
	from bRegistroPorteria a
	where
	(a.estado = 'EP' or a.estado='SP')and
	a.empresa=@empresa  and estado<>'FP' and ( a.numero in (select remision from bRegistroBascula
	where empresa=@empresa and tiquete<>'' and estado='SP')
	or a.numero in (select numero from bRegistroBascula
	where empresa=@empresa and tiquete<>'' and estado='SP'))