
create PROCEDURE [dbo].[spConsecutivoCuadrilla]
	@empresa int, 
	@departamento	varchar(50),
	@consecutivo	varchar(50) output
AS

/***************************************************************************
Nombre: spConsecutivoCuadrilla
Tipo: Procedimiento Almacenado
Desarrollado: Infos Tecnologia SAS
Fecha: 11/11/2014

Argumentos de entrada: Departamento
Argumentos de salida: Consecutivo de la entidad.
Descripción: Retorna el consecutivo del código para la entidad nCuadrilla
*****************************************************************************/

	declare @codigo	varchar(50)

	select @codigo = RIGHT( '00' + rtrim( isnull( max( codigo ) + 1,1 ) ),2 )
	from nCuadrilla
	where
	departamento = @departamento
	and empresa = @empresa
	
	select @consecutivo = @departamento + @codigo