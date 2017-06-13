create PROCEDURE [dbo].[spVerificaProgramacionPlanta]
	@vehiculo	varchar(50),
	@empresa int
AS
/***************************************************************************
Nombre: spVerificaProgramacionDespachoPorteria
Tipo: Procedimiento Almacenado
Desarrollado: Infos Tecnologia SAS

Argumentos de entrada: Vehículo
Argumentos de salida:
Descripción: Selecciona la programación vigente de despachos.
*****************************************************************************/
 select * from bRegistroPorteria
where vehiculo = @vehiculo and  estado = 'EP' and empresa=@empresa