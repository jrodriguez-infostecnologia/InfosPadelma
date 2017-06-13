CREATE PROCEDURE [dbo].[spAbrirPeriodosAnoAgro]
	@ano		int,
	@empresa    int,
	@cerrado    bit,
	@retorno	int output,
	@conteo		int	output
AS
/***************************************************************************
Nombre: spAbrirPeriodosAno
Tipo: Procedimiento Almacenado
Desarrollado: INFOS TECNOLOGIA S.A.S.

*****************************************************************************/

	declare @error int

	begin tran Actualiza

		update aPeriodo
		set
		cerrado =  @cerrado
		where
		año = @ano
		and empresa=@empresa
		
		select @error = @@error,@conteo = @@rowcount

	if( @error = 0 )
	begin
		commit tran Actualiza
		set @retorno = 0
	end		
	else
	begin
		rollback tran Actualiza		
		set @retorno = 1
	end