create PROCEDURE [dbo].[spConsecutivoTurno]
@empresa int,
	@consecutivo	varchar(50) output
AS
/***************************************************************************
Nombre: spConsecutivoTurno
Tipo: Procedimiento Almacenado
Desarrollado: Infos Tecnologia SAS

Argumentos de entrada: 
Argumentos de salida: Consecutivo de la entidad.
Descripción: Retorna el consecutivo del código para la entidad nTurno
*****************************************************************************/

	select @consecutivo = RIGHT( '00' + rtrim( isnull( max( codigo ) + 1,1 ) ),2 )
	from nTurno