CREATE proc [dbo].[spLiquidacionVacacionesCorteTrabajador]
@empresa int,
@fechaCorte date
as
declare @tercero varchar(50),
@diasVacaciones  float,
@fechaInicial date,
@fechaFinal date,
@fechaInicialAño date,
@fechaIngreso date,
@fechaRetiro date,
@ultimaFechaVacaciones date,
@valorPromedioAñoPasadoVaca float,
@valorPromedioAñoActualVaca float,
@diasPromedio int,
@valorMes float,
@conceptoVacacion varchar(50),
@mes int,
@fip date, @ffp date,
@valorUltimaNominaVaca float =0,
@baseVaca float, 
@smlv int,
@año int =year(@fechacorte),
@suledo float=0,
@transporte int=0,
@gtransporte bit,
@contrato int,
@nombreTercero varchar(550),@retorno int 

select  @conceptoVacacion=vacaciones
 from nParametrosGeneral where empresa=@empresa

 select @smlv=vSalarioMinimo,@transporte= vAuxilioTransporte from nParametrosAno
 where empresa=@empresa and ano=@año

 create table #vacaciones
 (empresa int,
 tercero int,
 fechaCorte date,
 fechaIngreso date,
 fechaUltimaVacacion date,
 dias float,
 diasVaca float,
 valor float,
 contrato int,
 sueldo float
 )


 declare cursorFuncionarios insensitive cursor for	
	select distinct  	a.tercero,b.fechaIngreso,max(b.id),b.auxilioTransporte,case when b.salarioAnterior=0 then b.salario else  b.salarioAnterior end
	from nFuncionario  a
	join nContratos  b on a.tercero = b.tercero and a.empresa = b.empresa 
	join cCentrosCosto k on k.codigo=b.ccosto and k.empresa=b.empresa
	join nClaseContrato c on c.codigo=b.claseContrato and c.empresa=b.empresa and c.electivaProduccion=0
	where  a.empresa=@empresa and b.activo=1 
	and b.fechaIngreso<=@fechaCorte
	group by a.tercero,b.fechaIngreso,b.salarioAnterior,b.auxilioTransporte,b.salario
	open cursorFuncionarios			
	fetch cursorFuncionarios into 	@tercero,@fechaIngreso,@contrato,@gtransporte,@suledo

	while( @@fetch_status = 0 )
	begin	
	
			 set @fechaInicial = case when @fechaIngreso > DATEADD(yy,DATEDIFF(yy,0,@fechaCorte),0) 
			then @fechaIngreso else DATEADD(yy,DATEDIFF(yy,0,@fechaCorte),0) end
 
			set @fechaRetiro=@fechaCorte
			set @fechaFinal=@fechaCorte

			set @fechaInicialAño =  DATEADD(month,6, DATEADD(yy,DATEDIFF(yy,0,@fechaCorte),0))

			select @ultimaFechaVacaciones= MAX(periodoFinal) from nVacaciones 
			where empleado=@tercero and empresa=@empresa and anulado=0

			if @ultimaFechaVacaciones is null
				set @ultimaFechaVacaciones = dateadd(day,-1,@fechaIngreso)

			set @diasVacaciones = (DATEDIFF(MONTH,@ultimaFechaVacaciones,@fechaFinal) *30) +  case when (DATEPART(day,@fechaFinal))=31 then 30 else (DATEPART(day,@fechaFinal)) end - case when (DATEPART(day,@ultimaFechaVacaciones))=31 then 30 else (DATEPART(day,@ultimaFechaVacaciones)) end
			set @diasPromedio = case when DATEDIFF(day,@fechaIngreso,@fechaRetiro)>360 then 360 else (DATEDIFF(MONTH,@fechaIngreso,@fechaRetiro) *30) +  case when (DATEPART(day,@fechaRetiro))=31 then 30 else (DATEPART(day,@fechaRetiro)) end end -(datepart(day,@fechaInicial)-1)
					

	
		insert #vacaciones
		select @empresa,@tercero,@fechaCorte,@fechaIngreso,@ultimaFechaVacaciones,@diasVacaciones,(@diasVacaciones*15)/360,	(@suledo * @diasVacaciones)/720,	max(@contrato),@suledo

	
			
	fetch cursorFuncionarios into 	@tercero,@fechaIngreso,@contrato,@gtransporte,@suledo
	end	
		close cursorFuncionarios
	deallocate cursorFuncionarios 

	select b.descripcion nombreTercero, b.codigo identificacion, a.* from #vacaciones a
	join cTercero b on b.empresa=a.empresa and b.id=a.tercero

	drop table #vacaciones