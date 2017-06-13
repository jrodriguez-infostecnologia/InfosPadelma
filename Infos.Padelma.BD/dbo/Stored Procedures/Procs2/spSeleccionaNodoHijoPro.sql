create PROCEDURE [dbo].[spSeleccionaNodoHijoPro]
	@codigo int,
	@empresa int
AS
/***************************************************************************
Nombre: spSeleccionaNodoHijoPro
INFOS TECNOLOGIA S.A.S
*****************************************************************************/

	declare @padre	int,
			@nivel	int

	select @padre = hijo,@nivel = nivel
	from pJerarquia
	where
	codigo = @codigo	
	and empresa=@empresa

	select codigo,hijo,Convert(varchar(50),hijo) + ' - ' + descripcion as descripcion,nivel
	from pJerarquia
	where
	padre = @padre and
	nivel > @nivel
	and 
	empresa=@empresa
	order by codigo,hijo desc