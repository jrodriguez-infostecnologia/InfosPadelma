create proc [dbo].[spLiquidacionContratoTrabajadorDefinitiva]
@empresa int,
@tercero int,
@noPeriodo int,
@año int,
@liquidaNomina bit,
@fecha date
as
declare @diasCesantias  int,
@diasPrimas  int,
@diasVacaciones  int,
@fechaInicial date,
@fechaFinal date,
@fechaInicialAño date,
@fechaIngreso date,
@fechaRetiro date,
@ultimaFechaVacaciones date,
@valorPromedioAñoPasadoVaca int,
@valorPromedioAñoActualVaca int,
@valorPromedioAñoPasadoCesa int,
@valorPromedioAñoActualCesa int,
@diasPromedio int,
@valorMes int,@conceptoPrima varchar(50),
@conceptoCesantias varchar(50),
@conceptoInteres varchar(50),
@conceptoVacacion varchar(50),@mes int,
@fip date, @ffp date,@valorUltimaNominaVaca int =0,
@valorUltimaNominaPrima int=0 ,@valorUltimaNominacesa int=0,@baseCesantias int=0,
@baseVaca int, @basePrima int,@smlv int,@suledo int=0,@transporte int=0,@gtransporte bit,
@nombreTercero varchar(550),@retorno int 
declare @valorBaseEmbargo int=0,@valorUnitario int=0
delete from tmpliquidacionNomina where empresa=@empresa
if @liquidaNomina =1
begin
	exec spLiquidacionNominaPeriodo @año,1,@noPeriodo,@empresa,'',@tercero,@fecha,3,@retorno,@nombreTercero
	set @valorUltimaNominaVaca =  isnull((select sum(valorTotal) from tmpliquidacionNomina a
		join nConcepto b on b.codigo=a.concepto and b.empresa=a.empresa  where a.empresa=@empresa and b.baseVacaciones=1),0)
		set @valorUltimaNominaPrima =  isnull((select sum(valorTotal) from tmpliquidacionNomina a
		join nConcepto b on b.codigo=a.concepto and b.empresa=a.empresa  where a.empresa=@empresa and b.basePrimas=1),0)
		set @valorUltimaNominacesa =  isnull((select sum(valorTotal) from tmpliquidacionNomina a
		join nConcepto b on b.codigo=a.concepto and b.empresa=a.empresa  where a.empresa=@empresa and b.baseCesantias=1),0)
end
else
	set @retorno=20

delete tmpliquidacionNomina where empresa=@empresa
if @retorno<>20
	return

select top 1 @mes=mes,@fip=fechaInicial,@fip=fechaFinal  from nPeriodoDetalle where noPeriodo=@noPeriodo and año=@año and empresa=@empresa
select @conceptoCesantias = cesantias,@conceptoInteres=intereses,@conceptoPrima=primas, @conceptoVacacion=vacaciones
 from nParametrosGeneral where empresa=@empresa

 select @smlv=vSalarioMinimo,@transporte= vAuxilioTransporte from nParametrosAno
 where empresa=@empresa and ano=@año

select @fechaInicial = case when fechaIngreso > DATEADD(yy,DATEDIFF(yy,0,@fecha),0) 
then fechaIngreso else DATEADD(yy,DATEDIFF(yy,0,@fecha),0) end,
@fechaIngreso=fechaIngreso,@suledo=salario, @gtransporte= auxilioTransporte
 from  nContratos where tercero =@tercero and empresa=@empresa --and YEAR(fechaRetiro)=YEAR(@fecha)

set @fechaRetiro=@fecha
set @fechaFinal=@fecha
set @fechaInicialAño =   DATEADD(yy,DATEDIFF(yy,0,@fecha),0)

 select @ultimaFechaVacaciones= MAX(periodoFinal) from nVacaciones 
where empleado=@tercero and empresa=@empresa and anulado=0

if @ultimaFechaVacaciones is null
	set @ultimaFechaVacaciones = dateadd(day,-1,@fechaIngreso)
	
set @diasCesantias = (DATEDIFF(MONTH,@fechaInicial,@fechaFinal) *30) +  case when (DATEPART(day,@fechaFinal))=31 then 30 else (DATEPART(day,@fechaFinal)) end  -(datepart(day,@fechaInicial)-1)
set @diasPrimas = (DATEDIFF(MONTH,@fechaInicialAño,@fechaFinal) *30) +  case when (DATEPART(day,@fechaFinal))=31 then 30 else (DATEPART(day,@fechaFinal)) end 
set @diasVacaciones = (DATEDIFF(MONTH,@ultimaFechaVacaciones,@fechaFinal) *30) +  case when (DATEPART(day,@fechaFinal))=31 then 30 else (DATEPART(day,@fechaFinal)) end - case when (DATEPART(day,@ultimaFechaVacaciones))=31 then 30 else (DATEPART(day,@ultimaFechaVacaciones)) end
set @diasPromedio = case when DATEDIFF(day,@fechaInicialAño,@fechaRetiro)>360 then 360 else (DATEDIFF(MONTH,@fechaInicialAño,@fechaRetiro) *30) +  case when (DATEPART(day,@fechaRetiro))=31 then 30 else (DATEPART(day,@fechaRetiro)) end end -(datepart(day,@fechaInicialAño)-1)

set @valorPromedioAñoActualVaca =  isnull((select SUM(valorTotal) from vLiquidacionDefinitivaReal
where tercero=@tercero and empresa=@empresa  and anulado=0
and año = DATEPART(YY,@fechaFinal)  
and baseVacaciones=1) ,0) + @valorUltimaNominaVaca

set @valorPromedioAñoActualCesa =  isnull((select SUM(valorTotal) from vLiquidacionDefinitivaReal
where tercero=@tercero and empresa=@empresa  and anulado=0
and año = DATEPART(YY,@fechaFinal)  
and baseCesantias=1) ,0) + @valorUltimaNominacesa

set @baseCesantias =(((@valorPromedioAñoActualCesa)/@diasPromedio)*30)
set @baseVaca = ((@valorPromedioAñoActualVaca)/@diasPromedio)*30

if @baseVaca<@suledo
	set @baseVaca=@suledo
if @gtransporte=1
	set @suledo=@suledo+@transporte
if @baseCesantias < @suledo 
	set @baseCesantias =@suledo

	declare @valorBaseEmbargo1 int = isnull((select sum(case when signo = 1  then valorSS else (-1)*valorSS end) 
						from vSeleccionaRealLiquidacion where baseEmbargos = 1 and tercero=@tercero and empresa=@empresa) ,0)

		insert tmpliquidacionNomina
		select a.empresa,tercero,ccosto,@fecha,departamento,@conceptoCesantias,@año,@mes,@noPeriodo,@diasCesantias,
		b.porcentaje,
		@baseCesantias,
		(@baseCesantias * @diasCesantias)/360,
		b.signo,0,@diasCesantias,@fip,@ffp,b.baseSeguridadSocial,baseEmbargo,NULL,
		@diasCesantias,
		(@baseCesantias * @diasCesantias)/360,
		max(a.id),null,null,null
		 from nContratos a
		join nConcepto b on b.empresa=a.empresa and b.codigo=@conceptoCesantias
		where tercero=@tercero and a.empresa=@empresa
		group by a.empresa,a.tercero,a.ccosto,a.departamento,b.signo,b.porcentaje,b.baseSeguridadSocial,b.baseEmbargo

		insert tmpliquidacionNomina
		select a.empresa,tercero,ccosto,@fecha,departamento,@conceptoInteres,@año,@mes,@noPeriodo,@diasCesantias,b.porcentaje,
		 @baseCesantias,
		((((@baseCesantias *@diasCesantias)/360)*@diasCesantias)/360)*(b.porcentaje/100),
		b.signo,0,@diasCesantias,@fip,@ffp,b.baseSeguridadSocial,baseEmbargo,NULL,
		@diasCesantias,
		((((@baseCesantias *@diasCesantias)/360)*@diasCesantias)/360)*(b.porcentaje/100),
		max(a.id),null,null,null
		 from nContratos a
		join nConcepto b on b.empresa=a.empresa and b.codigo=@conceptoInteres
		where tercero=@tercero and a.empresa=@empresa
		group by a.empresa,a.tercero,a.ccosto,a.departamento,b.signo,b.porcentaje,b.baseSeguridadSocial,b.baseEmbargo
			
		insert tmpliquidacionNomina
		select a.empresa,tercero,ccosto,@fecha,departamento,@conceptoPrima,@año,@mes,@noPeriodo,@diasPrimas,b.porcentaje,
		 @baseCesantias,
		(@baseCesantias * @diasPrimas)/360,
		b.signo,0,@diasCesantias,@fip,@ffp,b.baseSeguridadSocial,baseEmbargo,NULL,
		@diasPrimas,
		(@baseCesantias * @diasPrimas)/360,
		max(a.id),null,null,null
		 from nContratos a
		join nConcepto b on b.empresa=a.empresa and b.codigo=@conceptoPrima
		where tercero=@tercero and a.empresa=@empresa
		group by a.empresa,a.tercero,a.ccosto,a.departamento,b.signo,b.porcentaje,b.baseSeguridadSocial,b.baseEmbargo
		
		insert tmpliquidacionNomina
		select a.empresa,tercero,ccosto,@fecha,departamento,@conceptoVacacion,@año,@mes,@noPeriodo,@diasVacaciones,b.porcentaje,
		 @baseVaca,
		(@baseVaca * @diasVacaciones)/720,
		b.signo,0,@diasCesantias,@fip,@ffp,b.baseSeguridadSocial,baseEmbargo,NULL,
		@diasVacaciones,
		(@baseVaca * @diasVacaciones)/720,
		max(a.id),null,null,null
		 from nContratos a
		join nConcepto b on b.empresa=a.empresa and b.codigo=@conceptoVacacion
		where tercero=@tercero and a.empresa=@empresa
	group by a.empresa,a.tercero,a.ccosto,a.departamento,b.signo,b.porcentaje,b.baseSeguridadSocial,b.baseEmbargo

	insert tmpliquidacionNomina
	select a.empresa,c.tercero,c.ccosto,a.fecha,c.departamento,a.concepto,@año,@mes,@noPeriodo,1,0,a.valorSaldo,isnull(a.valorSaldo,0) - isnull(b.valorTotal,0),
	d.signo,0,1,@fip,@ffp,d.baseSeguridadSocial,d.baseEmbargo,null,1,isnull(a.valorSaldo,0) - isnull(b.valorTotal,0),c.id,a.codigo,null,null
	from nPrestamo a
	join nContratos c on c.tercero=a.empleado and c.empresa=a.empresa
	join nConcepto d on d.codigo=a.concepto and d.empresa=a.empresa
	left join tmpliquidacionNomina  b on b.empresa=a.empresa and b.tercero=a.empleado and b.noPrestamo=a.codigo
	where empleado=@tercero and a.empresa=@empresa and a.valorSaldo>0
	
	declare  @pagoMinimo int =	isnull((select distinct vminimoperiodo from nParametrosAno where empresa=@empresa and @año=@año),0)
	if exists (select * from nEmbargos where  empleado=@tercero and empresa=@empresa and activo=1 ) and (select sum(valortotal) from vSeleccionaDiferenciaLiquidacionTercero where tercero=@tercero and empresa=@empresa)>@pagoMinimo
				begin
					if (select embargos from nParametrosGeneral where empresa=@empresa) is not null
					begin
						declare @tipoEmbargo varchar(50),  @destipoEmbargo varchar(200)
						set @valorBaseEmbargo = (select sum(case when signo = 1  then valorSS else (-1)*valorSS end) 
						from vSeleccionaRealLiquidacion where baseEmbargos = 1 and tercero=@tercero and empresa=@empresa) -@valorBaseEmbargo1
						declare @conceptoEmbargo varchar(50) = (select embargos from nParametrosGeneral where empresa=@empresa)
						exec spliquidaEmbargosNomina  @empresa , @tercero,@valorBaseEmbargo ,@pagominimo,1, @noPeriodo,@año,@valorUnitario output , @tipoEmbargo output, @destipoEmbargo output						
						insert  tmpliquidacionNomina 
						select @empresa, @tercero, b.ccosto, @fecha, b.departamento, @conceptoEmbargo, @año, @mes, @noperiodo, 1,0, @valorUnitario,round(@valorUnitario,0),signo, 0, 1, @fip, @ffp,baseSeguridadSocial, baseEmbargo,null,1,@valorUnitario,id,null,
						@tipoEmbargo, @desTipoEmbargo
						from nConcepto a 
						join nContratos b on b.empresa=a.empresa and b.tercero=@tercero
						  where a.empresa=@empresa and codigo=@conceptoEmbargo
					end
				end

		--select a.concepto codConcepto, b.descripcion desConcepto,sum(a.cantidad) cantidad, avg(a.valorUnitario) valorUnitario,sum(a.valorTotal)valorTotal,b.signo
		--from tmpliquidacionNomina a
		--join nConcepto b on b.codigo=a.concepto and b.empresa=a.empresa
		--join cTercero c on c.id=a.tercero and c.empresa=a.empresa
		--where a.empresa=@empresa
		--group by   a.concepto , b.descripcion , b.signo