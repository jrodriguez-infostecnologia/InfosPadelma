create PROCEDURE [dbo].[SpInsertanProgramacionFuncionarios] 
	@empresa				int,
	@fecha					date,
	@turno					varchar(50),
	@funcionario			varchar(50),
	@cuadrilla				varchar(50),
	@dia					varchar(50),
	@usuario				varchar(50),
	@programado				bit,
	@Retorno				int output  
	
AS
	declare @turnoActual		varchar(50),
			@idProgramacion		varchar(150),
			@fechaRegistro		datetime,
			@horaActual			int,
			@horasActual		int,
			@horaEntrada		int,
			@horasTurno			int,
			@horasExtra			int,
			@verificaTurno		int

	set @Retorno = 0
	set @verificaTurno = 0
		
	if not exists( select * from nProgramacion	where convert(date,fecha) = @fecha and	turno = @turno and funcionario = @funcionario  and empresa= @empresa) 
	begin
		if( @programado = 1)
		begin

			if(@fecha < CONVERT(date,GETDATE()))
			begin
				set @Retorno = 3
				return
			end	
			
				
			select @horaEntrada = horaInicio,@horasTurno = horas
			from nTurno	where	codigo = @turno and empresa=@empresa
			
			declare curTurnos insensitive cursor for
			select turno	from nProgramacion
			where fecha = @fecha and turno <> @turno and funcionario = @funcionario and empresa=@empresa
			
			open curTurnos
			fetch curTurnos into @turnoActual
			
			while( @@FETCH_STATUS = 0 )
			begin

				select @horaActual = horaInicio,@horasActual = horas
				from nTurno
				where
				codigo = @turnoActual
				
				if( ( @horaEntrada + 0.1 between @horaActual and ( @horaActual + ( @horasActual * 100 ) ) ) or
					( @horaActual + 0.1 between @horaEntrada and ( @horaEntrada + ( @horasTurno * 100 ) ) ) )
				begin				
					set @verificaTurno = 1				
				end
			
				fetch curTurnos into @turnoActual
			end
			
			close curTurnos
			deallocate curTurnos
			
			if( @verificaTurno = 0 )
			begin
				if( @horasTurno >= 8 )
				begin
					set @horasExtra = ( @horasTurno - 8 )
					set @horasTurno = 8		
				end
				
				if((select horaInicio/100 from nTurno where codigo=@turno) =  DATEPART(hour,getdate())
				and convert(date,@fecha)=convert(date,GETDATE()) )
				begin
				set @Retorno=5
				return
				end
							
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
					null,
					null,
					@horasTurno,
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
				set @Retorno = 2
				return
			end							
		end
		else
		begin
			if( @programado = 0 )
			begin		
				begin tran Elimina
								
					delete nProgramacion where	fecha = @fecha and	turno = @turno and
					funcionario = @funcionario and empresa=@empresa	and estado = 'P'
					
				if( @@ERROR = 0 )
				begin
					commit tran Elimina
					set @Retorno = 0
				end
				else
				begin
					rollback tran Elimina
					set @Retorno = 1
				end				
			end
			end
	end
	else
	begin
		if( @programado = 0 )
		begin		
					
				if exists(select * from nProgramacion where fecha = @fecha and empresa=@empresa and
						turno = @turno and funcionario = @funcionario and estado <> 'P' and cuadrilla=@cuadrilla)
				begin
					set @Retorno = 4
					return
				end
			
			begin tran Elimina
			
				delete nProgramacion
				where	fecha = @fecha and	turno = @turno and funcionario = @funcionario and
				estado = 'P' and empresa=@empresa
				
			if( @@ERROR = 0 )
			begin
				commit tran Elimina
				set @Retorno = 0
			end
			else
			begin
				rollback tran Elimina
				set @Retorno = 1
			end				
		end
		
			if( @programado = 0 )
			begin		
				if exists(select * from nProgramacion where fecha = @fecha and
					turno = @turno and funcionario = @funcionario and estado='P' and cuadrilla=@cuadrilla	and empresa=@empresa)
				begin
					set @Retorno = 4
					return
				end
				
				begin tran Elimina
				
				delete nProgramacion
				where
				fecha = @fecha and
				turno = @turno and
				funcionario = @funcionario and empresa=@empresa and 
				estado = 'P'
				
			if( @@ERROR = 0 )
			begin
				commit tran Elimina
				set @Retorno = 0
			end
			else
			begin
				rollback tran Elimina
				set @Retorno = 1
			end				
		end
			else
			begin
			set @Retorno=0
			end
				
	
		
	end