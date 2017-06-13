
create PROCEDURE [dbo].[spSeleccionaVehiculosDesCargaPlanta]
	@empresa int
AS
/***************************************************************************
Nombre: spSeleccionaVehiculosDesCargaPlanta
Tipo: Procedimiento Almacenado
Desarrollado: InfoS Tecnologia SAS
Fecha: 08/11/2014

Argumentos de entrada:
Argumentos de salida: 
Descripción: Selecciona los vehiculos de descarga de materia prima dentro de
			 la planta.
*****************************************************************************/

	select a.fechaEntrada,a.remolque,a.vehiculo,a.codigoConductor,a.nombreConductor,a.numero
	from bRegistroPorteria a
	where
	a.estado = 'EP' 
	and empresa=@empresa