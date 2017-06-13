create PROCEDURE [dbo].[spRetornaNumeroDespachoCarnet]
	@codigo		varchar(50),
	@empresa	int,
	@despacho	varchar(50) output
AS
/***************************************************************************
Nombre: spRetornaNumeroDespachoCarnet
Tipo: Procedimiento Almacenado
Desarrollado: Infos Tecnologia SAS

Argumentos de entrada: Código de carnet
Argumentos de salida: Número consecutivo de programación
Descripción: Retorna el número consecutivo asignado a la programación de vehículos
*****************************************************************************/
	
	select @despacho = a.numero
	from bRegistroPorteria a 
	join  logCarnetDespacho b on b.codigo=a.remision and b.empresa=a.empresa
	where
	a.remision = @codigo and
	b.estado in ( 'U','T' )
	and a.empresa=@empresa 
	order by a.fechaEntrada asc