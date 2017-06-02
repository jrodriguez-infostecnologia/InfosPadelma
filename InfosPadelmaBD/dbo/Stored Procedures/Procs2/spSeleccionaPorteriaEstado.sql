create procedure [dbo].[spSeleccionaPorteriaEstado]
	@estado	char(2),
	@empresa int
AS
/***************************************************************************
Nombre: spSeleccionaPorteriaEstado
Tipo: Procedimiento Almacenado
Desarrollado: Infos tecnologia S.A.S
Fecha: 11/12/2015

Argumentos de entrada: Estado del vehículo
Argumentos de salida: 
Descripción: Selecciona el registro de portería por estado.
*****************************************************************************/

	select *
	from bRegistroPorteria
	where
	estado = @estado
	and empresa=@empresa