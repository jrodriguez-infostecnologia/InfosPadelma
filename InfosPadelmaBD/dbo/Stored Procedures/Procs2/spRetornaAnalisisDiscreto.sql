create PROCEDURE [dbo].[spRetornaAnalisisDiscreto]
	@variable		varchar(50),
	@jerarquia		int,
	@empresa int,
	@discreto		bit output
AS
/***************************************************************************
Nombre: spRetornaAnalisisDiscreto
Tipo: Procedimiento Almacenado
Infos tecnologia s.a.s
*****************************************************************************/
	
	set @discreto = 0

	select @discreto = discreta
	from pJerarquiaAnalisis
	where
	jerarquia = @jerarquia and
	analisis = @variable and
	empresa=@empresa
	
	if (@discreto is null)
	begin
		set @discreto = 0
	end