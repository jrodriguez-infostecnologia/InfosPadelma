
create PROCEDURE [dbo].[spConsecutivoGrupoNovedad]
@empresa int,
	@consecutivo	varchar(50) output
AS
/***************************************************************************
Nombre: spConsecutivoGrupoNovedad
Tipo: Procedimiento Almacenado
Desarrollado: Infos Tecnologia
Fecha: 11/11/2014

Argumentos de entrada: 
Argumentos de salida: Consecutivo de la entidad.
Descripción: Retorna el consecutivo del código para la entidad nCcostoNomina
*****************************************************************************/

	select @consecutivo = RIGHT( '00' + rtrim( isnull( max( codigo ) + 1,1 ) ),2 )
	from aGrupoNovedad
	where empresa=@empresa