
CREATE PROCEDURE [dbo].[spConsecutivoNovedades]
	@grupo		varchar(50),
	@empresa int,
	@consecutivo	varchar(50) output
AS
/***************************************************************************
Nombre: spConsecutivoNovedades
Tipo: Procedimiento Almacenado
Desarrollado: Infos Tecnologia
Fecha: 11/11/2014

Argumentos de entrada: Centro de costo
Argumentos de salida: Consecutivo de la entidad.
Descripción: Retorna el consecutivo del código para la entidad nNovedad
*****************************************************************************/

	declare @codigo	varchar(50)

	select @codigo = RIGHT( '00' + rtrim( isnull( max( codigo ) + 1,1 ) ),2 )
	from aNovedad
	where
	grupo = @grupo
	and empresa=@empresa
	
	select @consecutivo = @grupo + @codigo