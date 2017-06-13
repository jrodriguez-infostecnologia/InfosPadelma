create PROCEDURE [dbo].[spAnulaLiquidacionPrima]
	@tipo		varchar(50),
	@numero		varchar(50),
	@usuario	varchar(50),
	@periodo	int,
	@año		int,
	@mes		int,
	@empresa	int,
	@retorno	int output
AS
/***************************************************************************
Nombre: spAnulaLiquidacionPrima
Tipo: Procedimiento Almacenado
INFOS TECNOLOGIA S.A.S
*****************************************************************************/

	declare @fecha		datetime,
			@referencia	varchar(50),
			@error		int	
	
	set @fecha = GETDATE()
	set @error = 0 

	begin tran Anulacion
	
		update nLiquidacionPrima
		set observacion = '**ANULADO**' + observacion,
		anulado=1,
		usuarioAnulado=@usuario,
		fechaAnulado=getdate()
		where
		tipo = @tipo and
		numero = @numero 
		and empresa=@empresa
		
		set @error = @@ERROR
		
						
	if( @error = 0 )
	begin
		commit tran Anulacion
		set @retorno = 0
	end
	else
	begin
		rollback tran Anulacion
		set @retorno = 1
	end