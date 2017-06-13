
create PROCEDURE [dbo].[spRetornaEstadoCarnet]
	@codigo	varchar(50),
	@empresa int,
	@estado	char(1) output
AS
/***************************************************************************
Nombre: spRetornaEstadoCarnet
Tipo: Procedimiento Almacenado
Desarrollado: Infos Tecnologia SAS

Argumentos de entrada: Código
Argumentos de salida: Estado del carnet
Descripción: Retorna el estado de un carnet seleccionado
*****************************************************************************/

	set @estado = ''
	
	select @estado = estado
	from logCarnetDespacho
	where
	empresa=@empresa and 
	codigo = @codigo