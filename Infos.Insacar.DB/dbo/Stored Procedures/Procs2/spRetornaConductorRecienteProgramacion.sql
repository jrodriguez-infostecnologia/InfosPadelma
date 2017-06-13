
create PROCEDURE [dbo].[spRetornaConductorRecienteProgramacion]
	@codigo		varchar(50),
	@empresa int,
	@nombre		varchar(250) output
AS
/***************************************************************************
Nombre: spRetornaConductorRecienteProgramacion
Tipo: Procedimiento Almacenado
Desarrollado: Infos Tenologia SAS

Argumentos de entrada: Id conductor
Argumentos de salida: Nombre conductor
Descripción: Retorna el nombre del conductor asociado a la cédula ingresada
*****************************************************************************/

	set @nombre = '';

	select @nombre = nombreConductor 
	from logProgramacionVehiculo
	where
	codigoConductor = @codigo and
	empresa=@empresa and
	fechaDespacho = ( select MAX( fechaDespacho )
				 from logProgramacionVehiculo
				 where
				 codigoConductor = @codigo and empresa=@empresa)