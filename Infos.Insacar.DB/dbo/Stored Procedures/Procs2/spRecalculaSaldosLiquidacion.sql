CREATE proc [dbo].[spRecalculaSaldosLiquidacion]
@empresa int,
@periodo int,
@mes int,
@año int,
@numero varchar(50),
@ejecutado bit
as

declare @tercero int,
		@concepto varchar(50),
		@fechaInicialLiquidacion date,
		@fechaFinalLiquidacion date,
		@noPrestamo varchar(50),@tipoConcepto varchar(50),
		@cantidad decimal(18,3),@valorTotal money

	declare curLiquidacion insensitive cursor for
	select codTercero,codConcepto,fechaInicial,fechaFinal,noPrestamo,cantidad,ValorTotal,tipoConcepto from vSeleccionaLiquidacionDefinitiva
	where empresa=@empresa and noPeriodo=@periodo and numero=@numero
	open curLiquidacion			
	fetch curLiquidacion into @tercero,@concepto,@fechaInicialLiquidacion,@fechaFinalLiquidacion,@noPrestamo,@cantidad,@valorTotal,@tipoConcepto
	while( @@fetch_status = 0 )
	begin	
		
		if exists( select * FROM aTransaccionTercero a join atransaccion b 
					on b.numero=a.numero and b.tipo=a.tipo and a.empresa=b.empresa	
					where tercero=@tercero and  fecha between @fechaInicialLiquidacion and @fechaFinalLiquidacion and a.empresa=@empresa  )
		begin
			UPDATE aTransaccionTercero
			SET aTransaccionTercero.ejecutado=@ejecutado
			FROM dbo.aTransaccionTercero  a
			join atransaccion b on b.numero=a.numero and b.tipo=a.tipo and a.empresa=b.empresa
			where tercero=@tercero and  fecha between @fechaInicialLiquidacion and @fechaFinalLiquidacion  and a.empresa=@empresa
		end

		if exists(select * from nPrestamo where empleado=@tercero and codigo=@noPrestamo and concepto=@concepto and empresa=@empresa)
		begin
			if (@ejecutado=0)
			begin
				update nPrestamo set
				cuotasPendiente =cuotasPendiente + @cantidad,
				valorSaldo=valorSaldo +@valorTotal
				where empleado=@tercero and codigo=@noPrestamo and concepto=@concepto and empresa=@empresa
			end
			if (@ejecutado=1)
			begin
				update nPrestamo set
				cuotasPendiente =cuotasPendiente - @cantidad,
				valorSaldo=valorSaldo -@valorTotal
				where empleado=@tercero and codigo=@noPrestamo and concepto=@concepto and empresa=@empresa
			end
		end

		if exists(select * from nEmbargos where empleado=@tercero and tipo=@tipoConcepto and empresa=@empresa and manejaSaldo=1 and saldo>0 and activo=1 and codigo=@noPrestamo)
		begin
			if (@ejecutado=0)
			begin
				update nEmbargos set
				saldo = saldo+@valorTotal
				where empleado=@tercero and codigo=@noPrestamo and tipo=@tipoConcepto and empresa=@empresa
			end
			if (@ejecutado=1)
			begin
				update nEmbargos set
				saldo = saldo-@valorTotal
				where empleado=@tercero and codigo=@noPrestamo and tipo=@tipoConcepto and empresa=@empresa
			end
		end

		if exists( select * FROM nProgramacion	where empresa=@empresa and  funcionario=@tercero and  fecha between @fechaInicialLiquidacion and @fechaFinalLiquidacion  )
		begin
			update nProgramacion set
			estado='L'
			where empresa=@empresa and  funcionario=@tercero and  fecha between @fechaInicialLiquidacion and @fechaFinalLiquidacion
		end

		if exists(select * from nVacaciones where empresa=@empresa and empleado=@tercero and anulado=0 and añoPago=@año and periodo=@periodo)
		begin
			update nVacaciones set
			ejecutado=@ejecutado,
			liquidada=@ejecutado,
			acumulada=@ejecutado
			where empresa=@empresa and empleado=@tercero and anulado=0 and añoPago=@año and periodo=@periodo
		end

	fetch curLiquidacion into @tercero,@concepto,@fechaInicialLiquidacion,@fechaFinalLiquidacion,@noPrestamo,@cantidad,@valorTotal,@tipoConcepto
	end
	close curLiquidacion
	deallocate curLiquidacion