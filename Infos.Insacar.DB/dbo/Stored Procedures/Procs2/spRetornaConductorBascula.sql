
CREATE PROCEDURE [dbo].[spRetornaConductorBascula]
	@empresa int,
	@codigo		varchar(50),
	@nombre		varchar(250) output
AS
/***************************************************************************
Nombre: spRetornaConductorBascula
Tipo: Procedimiento Almacenado
Desarrollado: Infos Tecnologia SAS
Fecha: 12/11/2014

*****************************************************************************/

	set @nombre = '';

	set @nombre = isnull((select top 1 nombreConductor 
	from bregistroBascula
	where
	codigoConductor = @codigo 
	and empresa=@empresa
	order by fecha desc),'')