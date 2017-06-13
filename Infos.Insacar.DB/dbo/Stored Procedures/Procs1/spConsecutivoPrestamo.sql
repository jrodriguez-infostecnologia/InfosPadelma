
create PROCEDURE [dbo].[spConsecutivoPrestamo]
	@empresa int,
	@consecutivo	varchar(50) output
AS
/***************************************************************************
Nombre: spConsecutivoPrestamo
Tipo: Procedimiento Almacenado
Desarrollado: Infos Tecnologia
Fecha: 11/11/2014

Argumentos de entrada: Centro de costo
Argumentos de salida: Consecutivo de la entidad.
Descripción: Retorna el consecutivo del código para la entidad nNovedad
*****************************************************************************/

	declare @codigo	varchar(50)

	select @codigo = RIGHT( '000000000000' + rtrim( isnull( max( codigo ) + 1,1 ) ),12 )
	from nPrestamo
	where empresa=@empresa
	
	select @consecutivo = @codigo