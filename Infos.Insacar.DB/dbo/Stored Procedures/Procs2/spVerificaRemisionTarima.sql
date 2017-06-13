
CREATE PROCEDURE [dbo].[spVerificaRemisionTarima]
	@codigo		varchar(50),
	@producto	int,
	@empresa	int,
	@retorno	int output
AS
/***************************************************************************
Nombre: spVerificaRemisionTarima
Tipo: Procedimiento Almacenado
Desarrollado: Infos Tecnologia SAS

Argumentos de entrada: Código remisión
Argumentos de salida: 0 Si la remisión es válida,
					  1 Si la remisión no es válida
Descripción: Valida si la remisión seleccionada se puede usar en el análisis
			 de tarima.
*****************************************************************************/

	declare @conteo int
	
	set @conteo = 0

	select @conteo = COUNT(*)
	from bRemision
	where
	codigo = @codigo and
	empresa=@empresa and
	estado = 'U' and
	codigo in ( select remision
				from bRegistroBascula
				where
				estado in ( 'PP','SP' ) and
				ltrim( rtrim( item ) ) = ltrim( rtrim( @producto ) ) and
				analisisRegistrado = 0 and empresa=@empresa )
					
	if( @conteo = 0 )
	begin
		set @retorno = 1
	end					
	else
	begin
		set @retorno = 0
	end