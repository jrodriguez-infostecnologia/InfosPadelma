create proc [dbo].[liquidaEmbargos]
@empresa int,
@empleado int,
@base money,
@pagominimo money,
@diasLiquidados int,
@valor  money output
as

	declare @pagoSueldo money,
	@valorDescontar money=0, 
	@diasFijos int=30,
	@tipo varchar(10), @valorCuotas money,
	@manejaCuota int ,@manejaCuotaPosterior int, @manejaSaldo int,
	@valorFinal money, @valorCobroPosterior money, @pCobroPosterior decimal(18,3),
	@saldo money, @cobroPosterior bit, @valorBase money, @porcentaje money	, @valorCuota money 

	declare curEM insensitive cursor for
	select tipo,manejaCuota,manejaCuotaPosterior,valorBase, manejaSaldo,valorCuotas, porcentaje, valorfinal, valorCobroPosterior,pcobroPosterior, saldo, cobroPosterior from nEmbargos
	where empresa=@empresa and empleado=@empleado 
	and activo=1

	open curEM			
	fetch curEM into @tipo,@manejaCuota  ,@manejaCuotaPosterior ,@valorBase, @manejaSaldo ,@valorCuota, @porcentaje, @valorfinal, @valorCobroPosterior,@pcobroPosterior, @saldo, @cobroPosterior


	while( @@fetch_status = 0 )
	begin	

	set @valorCuota= @valorCuota/30* @diasLiquidados
	set @pagoSueldo = @base
	set @valor=0
		
	if @tipo ='EA' 
	begin
			if @valorBase <> 0
			begin
				set @base = @valorBase
			end

			if @pagoSueldo >(@pagoSueldo -@pagominimo)
			begin
				if @manejaSaldo<>0
				begin
					set @valorDescontar=0
				end
					else
					begin
						set @valorDescontar = @valorCuota + (@base-@valorCuota)*@porcentaje/100
					end
			end
			
	end
	
	set  @pagoSueldo = @pagoSueldo - @valorDescontar
	set @valor=@valorDescontar
		
	fetch curEM into @tipo,@manejaCuota  ,@manejaCuotaPosterior ,@valorBase, @manejaSaldo ,@valorCuota, @porcentaje, @valorfinal, @valorCobroPosterior,@pcobroPosterior, @saldo, @cobroPosterior
	end

	close curEM
	deallocate curEM