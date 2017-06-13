CREATE proc [dbo].[spLiquidacionPrimas]
@formaLiquidacion int,
@empresa int,
@ccosto varchar(50) ,
@empleado varchar(50),
@añoInicial int,
@añoFinal int,
@periodoInicial int,
@periodoFinal int,
@fechaGeneral date,
@retorno int output
as

declare @tercero int,
@fechaInicial date,
@fechaIni date,
@fechaFinal date,
@valorAcumulado float,
@diasPrimas float,
@diasPromedio float,
@fechaIngreso date,
@fechaFinalPrima date,
@sueldo float,
@mTransporte bit,
@valorTransporte float,
@valorPromedioMes float,
@conceptoVacaciones varchar(50),
@contrato int

select @conceptoVacaciones =vacaciones from nParametrosGeneral
where empresa=@empresa
set @retorno = 20

delete from tmpLiquidacionPrima
where empresa=@empresa

	declare cursorFuncionarios insensitive cursor for	
	select distinct  	a.tercero,b.fechaIngreso,max(b.id),b.salario,b.auxilioTransporte
	from nFuncionario  a
	join nContratos  b on a.tercero = b.tercero and a.empresa = b.empresa 
	join cCentrosCosto k on k.codigo=b.ccosto and k.empresa=b.empresa
	join nClaseContrato c on c.codigo=b.claseContrato and c.empresa=b.empresa and c.electivaProduccion=0
	where  a.empresa=@empresa and b.activo=1 
	and  b.ccosto like (case when @formaLiquidacion=2 then @ccosto	else '%%'  end)
	and convert(varchar(50),a.tercero) like (case when @formaLiquidacion=3 then @empleado else '%%' end)
	and  k.mayor like (case when @formaLiquidacion=4  then @ccosto	else '%%'  end)
	group by a.tercero,b.fechaIngreso,b.salario,b.auxilioTransporte
	open cursorFuncionarios			
	fetch cursorFuncionarios into 	@tercero,@fechaIngreso,@contrato,@sueldo,@mTransporte

	while( @@fetch_status = 0 )
	begin	
	 
	set @valorAcumulado = isnull((select sum(a.valorTotal) from vValorAcumuladoPrimas a
	where a.tercero=@tercero and a.empresa=@empresa and a.basePrimas=1 and a.contrato=@contrato
	and (a.año>=@añoInicial and a.noPeriodo>=@periodoInicial)
	and (a.año<=@añoFinal and a.noPeriodo<=@periodoFinal) ),0)

	select @fechaInicial=fechaInicial,@fechaIni=fechaInicial from nPeriodoDetalle
	where empresa=@empresa and año=@añoInicial and noPeriodo=@periodoInicial

	select @fechaFinal=fechaFinal from nPeriodoDetalle
	where empresa=@empresa and año=@añoFinal and noPeriodo=@periodoFinal

	if @fechaIngreso>@fechaInicial
	begin
		set @fechaInicial=@fechaIngreso
	end
	if month(@fechaFinal)>6
		set @fechaFinalPrima= DATEADD(ms,-3,DATEADD(yy,0,DATEADD(yy,DATEDIFF(yy,0,@fechaFinal)+1,0))) 
	else
		set @fechaFinalPrima=dateadd(MONTH,-6,DATEADD(ms,-3,DATEADD(yy,0,DATEADD(yy,DATEDIFF(yy,0,@fechaFinal)+1,0))) )

	
	if @fechaIngreso>@fechaIni
	begin
		set @diasPrimas = (select sum(cantidad) from vValorAcumuladoPrimas where empresa=@empresa and tercero=@tercero  and sumaPrestacionSocial=1 and año=YEAR(@fechaFinalPrima) AND noPeriodo between @periodoInicial and  @periodoFinal  and contrato=@contrato)
		if @diasPrimas>180
			set @diasPrimas =  180
	end
		
		set @diasPrimas = (select sum(cantidad) from vValorAcumuladoPrimas where empresa=@empresa and tercero=@tercero  and sumaPrestacionSocial=1 and año=YEAR(@fechaFinalPrima) AND noPeriodo between @periodoInicial and  @periodoFinal  and contrato=@contrato)
		set @diasPromedio = (select sum(cantidad) from vValorAcumuladoPrimas where empresa=@empresa and tercero=@tercero  and sumaPrestacionSocial=1 and año=YEAR(@fechaFinalPrima) AND noPeriodo between @periodoInicial and  @periodoFinal  and contrato=@contrato)
		+ (select sum(case when cantidad <0 then -1 *  cantidad else cantidad end) from vValorAcumuladoPrimas where empresa=@empresa and tercero=@tercero  and ausentismo=1 and año=YEAR(@fechaFinalPrima) AND noPeriodo between @periodoInicial and  @periodoFinal  and contrato=@contrato)

		--select nombreconcepto, sum(case when cantidad <0 then -1 *  cantidad else cantidad end) from vValorAcumuladoPrimas where empresa=@empresa and tercero=@tercero  and ausentismo=1 and año=YEAR(@fechaFinalPrima) AND noPeriodo between @periodoInicial and  @periodoFinal  and contrato=@contrato
		--group by nombreconcepto
		--(select sum(cantidad) from vValorAcumuladoPrimas where empresa=@empresa and tercero=@tercero  and sumaPrestacionSocial=1 and año=YEAR(@fechaFinalPrima) AND noPeriodo between @periodoInicial and  @periodoFinal  and contrato=@contrato)

	if @mTransporte=0
		set @valorTransporte=0
	else
	begin
		select @valorTransporte= vAuxilioTransporte from nParametrosAno
		where empresa=@empresa and ano=@añoFinal
	end
		set @valorPromedioMes = ((@valorAcumulado/@diasPromedio)*30)

	if @diasPromedio<0 
		set @diasPromedio=0

	insert tmpLiquidacionPrima
	select @empresa,@tercero, @añoInicial,@añoFinal,@periodoInicial,@periodoFinal,@fechaInicial,@fechaFinal,@fechaIngreso,@sueldo,@valorTransporte,@valorAcumulado,@valorPromedioMes,@diasPromedio,@diasPrimas,((@valorPromedioMes)*@diasPrimas)/360 ,@contrato
	
		fetch cursorFuncionarios into 	@tercero,@fechaIngreso,@contrato,@sueldo,@mTransporte
	end	
		close cursorFuncionarios
	deallocate cursorFuncionarios