CREATE PROCEDURE [dbo].[spGeneraPeriodosAno]
	@ano		int,
	@empresa    int,
	@retorno	int output,
	@conteo		int output
AS

	declare @mes int=1
	declare @periodo int,
			@error	 int
			
			declare @descripcion varchar(250),
			 @periodoArmado varchar(6)
declare @fecha varchar(8)



	set @mes = 13
	set @error = 0
	set @conteo = 0

	begin tran Inserta

		while( @mes > 0 )
		begin

			if( not exists ( select top 1 * from cPeriodo
							 where año = @ano and mes=@mes))
			begin

			if ( @mes = 13)
				set @descripcion = 'Cierre del año ' + cast(@ano as varchar(4))
				else							
			set @descripcion = DATENAME(month,convert(date,(cast(@ano as char(4))+'/'+cast(@mes as varchar(50))+'/01'))) + ' del año ' + cast(@ano as varchar(4))
			
			set  @periodoArmado=  cast(@ano as varchar(4)) + RIGHT('00' + Ltrim(Rtrim(@mes)),2)
			
			
				

				insert cPeriodo(
					año,mes,
					cerrado,
					empresa,
					periodo,
					descripcion )
				select
				@ano, @mes,0,@empresa,@periodoArmado,@descripcion
	
				select @error = @@error,@conteo = @conteo + 1, @mes=@mes-1 				
	
			end
			else
			begin
				select @error = @@error,@conteo = @conteo + 1, @mes=@mes-1 	
			end
				
		
		end

	if( @error = 0 )
	begin
		commit tran Inserta
		set @retorno = 0
	end
	else
	begin
		rollback tran Inserta
		set @retorno = 1
	end

	
	--declare @retorno int, @conteo int
	--exec [spGenercPeriodosAnoAgro] 1991,1, @retorno output, @conteo output
	
	--select @conteo, @retorno