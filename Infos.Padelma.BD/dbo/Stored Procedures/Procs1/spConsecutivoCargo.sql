
CREATE PROCEDURE [dbo].[spConsecutivoCargo]
	@empresa int,
	@consecutivo	varchar(50) output
AS

/***************************************************************************
Nombre: spConsecutivoCargo
Tipo: Procedimiento Almacenado
Desarrollado: Infos Tecnologia SAS
Fecha: 11/11/2014

Argumentos de entrada: Departamento
Argumentos de salida: Consecutivo de la entidad.
Descripción: Retorna el consecutivo del código para la entidad nCuadrilla
*****************************************************************************/

	declare @codigo	varchar(50)

	select @codigo = RIGHT( '000' + rtrim( isnull( max( convert(int,codigo) ) + 1,1 ) ),3 )
	from nCargo
	where empresa = @empresa
	
	select @consecutivo =  @codigo