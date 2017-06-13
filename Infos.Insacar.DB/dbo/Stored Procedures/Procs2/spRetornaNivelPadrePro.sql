create PROCEDURE [dbo].[spRetornaNivelPadrePro]
	@jerarquia	int,
	@empresa int,
	@nivelPadre	int output
AS
/***************************************************************************
Nombre: spRetornaNivelPadrePro
INFOS TECNOLOGIA S.A.S
*****************************************************************************/

	declare @padre	int,
			@nivel	int

	select @padre = padre,@nivel = nivel 
	from pJerarquia
	where
	codigo = @jerarquia
	and empresa = @empresa

	select @nivelPadre = nivel
	from pJerarquia
	where
	hijo = @padre and
	nivel < @nivel
	and empresa = @empresa