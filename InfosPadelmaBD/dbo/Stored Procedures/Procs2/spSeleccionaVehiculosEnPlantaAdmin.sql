CREATE PROCEDURE [dbo].[spSeleccionaVehiculosEnPlantaAdmin]
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

			
	select a.fechaEntrada,a.remolque,a.vehiculo,a.codigoConductor,a.nombreConductor,a.numero,a.remision
	from bRegistroPorteria a
	where
	a.empresa=@empresa and a.estado = 'EP'