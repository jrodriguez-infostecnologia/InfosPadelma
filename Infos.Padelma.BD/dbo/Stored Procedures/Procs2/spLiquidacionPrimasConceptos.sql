CREATE proc [dbo].[spLiquidacionPrimasConceptos]
@formaLiquidacion int,
@empresa int,
@ccosto varchar(50) ,
@añoInicial int,
@añoFinal int,
@periodoInicial int,
@periodoFinal int
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
@contrato int,
@concepto varchar(50)

select @conceptoVacaciones =vacaciones from nParametrosGeneral
where empresa=@empresa

delete from tmpLiquidacionPrimaConcepto
where empresa=@empresa

	declare cursorFuncionarios insensitive cursor for	
	select distinct  	a.tercero,b.fechaIngreso,max(b.id),b.salario,b.auxilioTransporte, d.concepto
	from nFuncionario  a
	join nContratos  b on a.tercero = b.tercero and a.empresa = b.empresa 
	join cCentrosCosto k on k.codigo=b.ccosto and k.empresa=b.empresa
	join nClaseContrato c on c.codigo=b.claseContrato and c.empresa=b.empresa and c.electivaProduccion=0
	join vValorAcumuladoPrimas d on d.empresa=a.empresa and d.tercero=a.tercero and d.contrato=b.id
	and d.basePrimas=1 and (d.año>=@añoInicial and d.noPeriodo>=@periodoInicial)
	and (d.año<=@añoFinal and d.noPeriodo<=@periodoFinal) 
	where  a.empresa=@empresa and b.activo=1 
	and  b.ccosto like (case when @formaLiquidacion=2 then @ccosto	else '%%'  end)
	and  k.mayor like (case when @formaLiquidacion=4  then @ccosto	else '%%'  end)
	group by a.tercero,b.fechaIngreso,b.salario,b.auxilioTransporte,d.concepto
	open cursorFuncionarios			
	fetch cursorFuncionarios into 	@tercero,@fechaIngreso,@contrato,@sueldo,@mTransporte,@concepto
	while( @@fetch_status = 0 )
	begin	
	 
	set @valorAcumulado = isnull((select sum(a.valorTotal) from vValorAcumuladoPrimas a
	where a.tercero=@tercero and a.empresa=@empresa and a.basePrimas=1 and a.contrato=@contrato
	and (a.año>=@añoInicial and a.noPeriodo>=@periodoInicial)
	and (a.año<=@añoFinal and a.noPeriodo<=@periodoFinal) and concepto=@concepto ),0)

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
		set @diasPrimas = (select sum(cantidad) from vValorAcumuladoPrimas where empresa=@empresa and tercero=@tercero  and sumaPrestacionSocial=1 and año=YEAR(@fechaFinalPrima) AND noPeriodo between @periodoInicial and  @periodoFinal  and contrato=@contrato and concepto=@concepto)
		if @diasPrimas>180
			set @diasPrimas =  180
	end
		
		set @diasPrimas = isnull((select sum(cantidad) from vValorAcumuladoPrimas where empresa=@empresa and tercero=@tercero  and sumaPrestacionSocial=1 and año=YEAR(@fechaFinalPrima) AND noPeriodo between @periodoInicial and  @periodoFinal  and contrato=@contrato and concepto=@concepto),0)
		set @diasPromedio = isnull((select sum(cantidad) from vValorAcumuladoPrimas where empresa=@empresa and tercero=@tercero  and sumaPrestacionSocial=1 and año=YEAR(@fechaFinalPrima) AND noPeriodo between @periodoInicial and  @periodoFinal  and contrato=@contrato and concepto=@concepto),0)
		+ isnull((select sum(case when cantidad <0 then -1 *  cantidad else cantidad end) from vValorAcumuladoPrimas where empresa=@empresa and tercero=@tercero  and ausentismo=1 and año=YEAR(@fechaFinalPrima) AND noPeriodo between @periodoInicial and  @periodoFinal  and contrato=@contrato and concepto=@concepto),0)
	if @mTransporte=0
		set @valorTransporte=0
	else
	begin
		select @valorTransporte= vAuxilioTransporte from nParametrosAno
		where empresa=@empresa and ano=@añoFinal
	end
	if @diasPromedio=0
		set @valorPromedioMes=0
	else
		set @valorPromedioMes = ((@valorAcumulado/@diasPromedio)*30)

	if @diasPromedio<0 
		set @diasPromedio=0

	insert tmpLiquidacionPrimaConcepto
	select @empresa,@tercero,@concepto, @añoInicial,@añoFinal,@periodoInicial,@periodoFinal,@fechaInicial,@fechaFinal,@fechaIngreso,@sueldo,@valorTransporte,@valorAcumulado,@valorPromedioMes,@diasPromedio,@diasPrimas,((@valorPromedioMes)*@diasPrimas)/360 ,@contrato
	
		fetch cursorFuncionarios into 	@tercero,@fechaIngreso,@contrato,@sueldo,@mTransporte,@concepto
	end	
		close cursorFuncionarios
	deallocate cursorFuncionarios 
	
	select a.*,f.descripcion nombreConcepto,b.codigo identificacionTercero,b.descripcion nombreTercero,c.ccosto,d.descripcion nombreCcosto,
e.codigo ccostoMayor,e.descripcion nombreccostoMayor from tmpLiquidacionPrimaConcepto a
join cTercero b on b.id=a.tercero and b.empresa=a.empresa
join nContratos c on c.id=a.contrato and c.tercero=a.tercero and c.empresa=a.empresa
join cCentrosCosto d on d.codigo=c.ccosto and d.empresa=c.empresa
join nConcepto f on f.codigo=a.concepto and f.empresa=a.empresa
left join cCentrosCosto e on e.codigo=d.mayor and e.empresa=d.empresa
where a.empresa=@empresa