CREATE proc [dbo].[spLiquidacionCesantias]
@formaLiquidacion int,
@empresa int,
@ccosto varchar(50) ,
@empleado varchar(50),
@año int,
@fechaGeneral date,
@sueldoActual bit,
@retorno int output
as

declare @tercero int,
@fechaInicial date,
@fechaIni date,
@fechaFinal date,
@diasPromedio float,
@fechaIngreso date,
@fechaFinalPrima date,
@sueldo float,
@mTransporte bit,
@valorTransporte float,
@contrato int,
@diasCesantias int,
@valorPromedioAñoActualCesa float,
@baseCesantias float,
@porcentaje float,@smlv int

set @retorno = 20

delete from tmpLiquidacionCesantia
where empresa=@empresa

select @porcentaje = porcentaje from nConcepto where empresa=@empresa and codigo in (select intereses from nParametrosGeneral where empresa=@empresa)
select @smlv= vSalarioMinimo,@valorTransporte= vAuxilioTransporte from nParametrosAno where ano=@año and empresa=@empresa

	declare cursorFuncionarios insensitive cursor for	
	select distinct  	a.tercero,b.fechaIngreso,max(b.id), case when @sueldoActual=1 then b.salario else b.salarioAnterior end,b.auxilioTransporte
	from nFuncionario  a
	join nContratos  b on a.tercero = b.tercero and a.empresa = b.empresa 
	join cCentrosCosto k on k.codigo=b.ccosto and k.empresa=b.empresa
	join nClaseContrato c on c.codigo=b.claseContrato and c.empresa=b.empresa and c.electivaProduccion=0
	where  a.empresa=@empresa and b.activo=1 
	and  b.ccosto like (case when @formaLiquidacion=2 then @ccosto	else '%%'  end)
	and convert(varchar(50),a.tercero) like (case when @formaLiquidacion=3 then @empleado else '%%' end)
	and  k.mayor like (case when @formaLiquidacion=4  then @ccosto	else '%%'  end)
	and b.fechaIngreso<=@fechaGeneral
	group by a.tercero,b.fechaIngreso,b.salarioAnterior,b.auxilioTransporte,b.salario
	open cursorFuncionarios			
	fetch cursorFuncionarios into 	@tercero,@fechaIngreso,@contrato,@sueldo,@mTransporte

	while( @@fetch_status = 0 )
	begin	
	
	set @fechaInicial =  DATEADD(yy,DATEDIFF(yy,0,@fechaGeneral),0)
	
	set @fechaFinal = @fechaGeneral 
	if @fechaIngreso>@fechaInicial
	begin
		set @fechaInicial=@fechaIngreso
	end
	
	set @diasPromedio = (select sum(cantidad) from vValorAcumuladoPrimas where empresa=@empresa and tercero=@tercero  and sumaPrestacionSocial=1 and año=@año and contrato=@contrato)
		+ isnull((select sum(case when cantidad <0 then -1 *  cantidad else cantidad end) from vValorAcumuladoPrimas where empresa=@empresa and tercero=@tercero  and ausentismo=1 and año=@año  and contrato=@contrato
		and concepto not in (select distinct concepto from vValorAcumuladoPrimas where empresa=@empresa and tercero=@tercero  and sumaPrestacionSocial=1 and año=@año and contrato=@contrato)),0)
	
	
	set @diasCesantias = (select sum(cantidad) from vValorAcumuladoPrimas where empresa=@empresa and tercero=@tercero  and sumaPrestacionSocial=1 and año=@año  and contrato=@contrato )
	
	

	--select concepto, nombreConcepto, sum(cantidad) from vValorAcumuladoPrimas where empresa=@empresa and tercero=@tercero  and sumaPrestacionSocial=1 and año=@año  and contrato=@contrato 
	--group by concepto, nombreConcepto
	
	--select concepto, nombreConcepto,sum(case when cantidad <0 then -1 *  cantidad else cantidad end) from vValorAcumuladoPrimas where empresa=@empresa and tercero=@tercero  and ausentismo=1 and año=@año  and contrato=@contrato
	--group by concepto, nombreConcepto

	--select @diasPromedio

	

	set @valorPromedioAñoActualCesa =  isnull((select sum(a.valorTotal) from vValorAcumuladoPrimas a
	where a.tercero=@tercero and a.empresa=@empresa and a.baseCesantias=1 and a.contrato=@contrato
	and a.año=@año ),0)

	set @baseCesantias =((((@valorPromedioAñoActualCesa)/@diasPromedio)*30))

	declare  @baseTotal float=0
	
	if @mTransporte=0	
		set @baseTotal =@sueldo 
	else
		set @baseTotal =@sueldo +@valorTransporte

	--if @baseCesantias < @baseTotal --@smlv 
	--	set @baseCesantias =  @baseTotal --@smlv

	insert tmpLiquidacionCesantia
	select @empresa,@tercero, @año,@fechaInicial,@fechaFinal,@fechaIngreso,@sueldo,@valorTransporte,
	@valorPromedioAñoActualCesa,@baseCesantias,@diasPromedio,@diasCesantias,(@baseCesantias * @diasCesantias)/360 , 
	(((((@baseCesantias *@diasCesantias)/360))*@diasCesantias)/360) * (@porcentaje/100),@contrato 
	
	
		fetch cursorFuncionarios into 	@tercero,@fechaIngreso,@contrato,@sueldo,@mTransporte
	end	
		close cursorFuncionarios
	deallocate cursorFuncionarios