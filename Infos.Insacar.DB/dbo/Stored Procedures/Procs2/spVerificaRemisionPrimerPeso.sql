
create PROCEDURE [dbo].[spVerificaRemisionPrimerPeso]
	@codigo		varchar(50),
	@empresa int,
	@retorno	int output
AS
/***************************************************************************
Nombre: spVerificaRemisionPrimerPeso
Tipo: Procedimiento Almacenado
Desarrollado: Infos Tecnologia SAS

Argumentos de entrada: Código remisión
Argumentos de salida: 0 Si la remisión es válida,
					  1 Si la remisión no es válida
Descripción: Valida si la remisión seleccionada se puede usar en el primer
			 peso de materia prima.
*****************************************************************************/

	declare @conteo int
	
	set @conteo = 0

	select @conteo = COUNT(*)
	from bRemision
	where
	codigo = @codigo and
	estado = 'U' and
	empresa=@empresa and
	codigo not in ( select remision
					from bRegistroBascula )
					
	if( @conteo = 0 )
	begin
		set @retorno = 1
	end					
	else
	begin
		set @retorno = 0
	end