CREATE PROCEDURE [dbo].[spVerificaRemisionSegundoPeso]
	@codigo		varchar(50),
	@empresa int,
	@retorno	int output
AS
/***************************************************************************
Nombre: spVerificaRemisionSegundoPeso
Tipo: Procedimiento Almacenado
Infos Tecnologia S.A.S
*****************************************************************************/

	declare @conteo int
	
	set @conteo = 0

	select @conteo = COUNT(*)
	from bRemision
	where
	codigo = @codigo and
	estado = 'U' and
	codigo in ( select remision
				from bRegistroBascula
				where
				analisisRegistrado = 1 and
				tiquete = '' and empresa=@empresa )
	and empresa=@empresa
					
	if( @conteo = 0 )
	begin
		set @retorno = 1
	end					
	else
	begin
		set @retorno = 0
	end