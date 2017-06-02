CREATE PROCEDURE [dbo].[SpInsertanRegistroPorteriaManual] 
	@fecha					date,
	@fechaEntrada			datetime,
	@fechaSalida			datetime,
	@turno					varchar(50),
	@funcionario			varchar(50),
	@cuadrilla				varchar(50),
	@usuario				varchar(50),
	@tipoEntrada			varchar(10),
	@empresa				int,
	@Retorno				int output  
	
AS
	declare @turnoActual		varchar(50),	@idProgramacion		varchar(150),
			@fechaRegistro		datetime,		@horaActual			int,
			@horasActual		int,			@horaEntrada		int,
			@horasTurno			int,			@horasExtra			int,
			@verificaTurno		int,			@turnoCnt		int

	set @Retorno = 0
	set @verificaTurno = 0	   
		
			if not exists( select * from nProgramacion where convert(date,fecha) = @fecha and turno = @turno 
	and funcionario = @funcionario and empresa=@empresa 
	and (cuadrilla like '%' + @cuadrilla + '%' or cuadrilla is null) ) 
	begin
			select @horaEntrada = horaInicio,@horasTurno = horas			from nTurno
			where			codigo = @turno and empresa=@empresa
			
			select * from nParametrosGeneral
			set @turnoCnt =isnull(( select jornadaDiaria from nParametrosGeneral
			where empresa=@empresa),0)
			
			set @horasExtra =@horasTurno - @turnoCnt
		
		if (@tipoEntrada = 'OUT')		
			begin					
				begin tran nProgramacion
					insert nProgramacion( 
					fecha,
					turno,
					funcionario,
					cuadrilla,
					horaEntrada,
					horaSalida,
					horasTurno,
					horasExtras,
					estado,
					fechaRegistro,
					usuario,
					horaInicio,
					empresa ) 
					select 
					@fecha,
					@turno,
					@funcionario,
					@cuadrilla,
					@fechaEntrada,
					@fechaSalida,
					@turnoCnt,
					@horasExtra,
					'P',
					GETDATE(),
					@usuario,
					@horaEntrada,
					@empresa
					
				if ( @@error = 0 ) 
				begin 
					set @Retorno = 0 
					commit tran nProgramacion 
				end 
				else 
				begin 
					set @Retorno = 1 
					rollback tran nProgramacion 
				end
			end
		else
		begin					
				begin tran nProgramacion
					insert nProgramacion( 
					fecha,
					turno,
					funcionario,
					cuadrilla,
					horaEntrada,
					horaSalida,
					horasTurno,
					horasExtras,
					estado,
					fechaRegistro,
					usuario,
					horaInicio, empresa ) 
					select 
					@fecha,
					@turno,
					@funcionario,
					@cuadrilla,
					@fechaEntrada,
					null,
					@turnoCnt,
					@horasExtra,
					'E',
					GETDATE(),
					@usuario,
					@horaEntrada,@empresa
					
				if ( @@error = 0 ) 
				begin 
					set @Retorno = 0 
					commit tran nProgramacion 
				end 
				else 
				begin 
					set @Retorno = 1 
					rollback tran nProgramacion 
				end
			end
	end								
	else
	begin
		begin tran edicion
		if @tipoEntrada='IN'
		BEGIN
				update nProgramacion set horaEntrada=@fechaEntrada, estado='E'  , horaSalida=null
				where  convert(date,fecha) = convert(date,@fecha) and turno = @turno 
					and funcionario = @funcionario and empresa=@empresa 
		END
		else
		BEGIN 
		if @tipoEntrada='OUT'
		begin
				update nProgramacion
				set horaEntrada=@fechaEntrada,horaSalida=@fechaSalida,estado='S'
				where  convert(date,fecha) = convert(date,@fecha) and turno = @turno 
					and funcionario = @funcionario and empresa=@empresa 
		end
		end	
		if( @@ERROR = 0 )
		begin
		commit tran edicion
			set @Retorno = 0
		end
		else
		begin
				rollback tran edicion
				set @Retorno = 1
		end				
end