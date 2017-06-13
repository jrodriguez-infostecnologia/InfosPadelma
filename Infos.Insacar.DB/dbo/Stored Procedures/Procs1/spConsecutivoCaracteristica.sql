
CREATE PROCEDURE [dbo].[spConsecutivoCaracteristica]
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

	select @consecutivo =  max( codigo ) + 1
	from aCaracteristica
	where empresa=@empresa

	--go

	--exec 