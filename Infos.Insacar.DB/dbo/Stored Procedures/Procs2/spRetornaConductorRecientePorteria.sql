
create PROCEDURE [dbo].[spRetornaConductorRecientePorteria]
	@empresa int,
	@codigo		varchar(50),
	@nombre		varchar(250) output
AS
/***************************************************************************
Nombre: spRetornaConductorRecientePorteria
Tipo: Procedimiento Almacenado
Desarrollado: Infos Tecnologia SAS
Fecha: 12/11/2014

*****************************************************************************/

	set @nombre = '';

	set @nombre = isnull((select top 1 nombreConductor 
	from bRegistroPorteria
	where
	codigoConductor = @codigo 
	and empresa=@empresa
	order by fechaSalida desc),'')