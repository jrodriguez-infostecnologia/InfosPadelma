
create PROCEDURE [dbo].[spVerificaCarnetPrimerPeso]
	@codigo		varchar(50),
	@empresa int,
	@retorno	int output
AS
/***************************************************************************
Nombre: spVerificaCarnetPrimerPeso
Tipo: Procedimiento Almacenado
Desarrollado: Infos Tecnologia SAS

Argumentos de entrada: Código remisión
Argumentos de salida: 0 Si la remisión es válida,
					  1 Si la remisión no es válida
Descripción: Valida si el carnet seleccionado se puede usar en el primer
			 peso de materia prima.
*****************************************************************************/

	declare @conteo		int

	select @conteo = COUNT(*)
	from logCarnetDespacho
	where
	empresa=@empresa and
	codigo = @codigo and
	estado = 'T' and 
	codigo in ( select remision
				from bRegistroPorteria
				where empresa=@empresa and
				remision = @codigo and
				(estado = 'EP' or  propio=1) )
					
	if( @conteo = 0 )
	begin
		set @retorno = 1
	end					
	else
	begin
		set @retorno = 0
	end