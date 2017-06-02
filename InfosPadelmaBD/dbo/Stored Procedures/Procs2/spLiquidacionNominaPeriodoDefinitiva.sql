CREATE proc [dbo].[spLiquidacionNominaPeriodoDefinitiva]
@año int,
@mes int,
@periodo int,
@empresa int,
@ccosto varchar(50),
@empleado varchar(50) ,
@fecheGeneral date,
@tipoTransaccion varchar(50),
@usuario varchar(50),
@observacion varchar(900),
@formaLiquidacion int,
@retorno int output,
@nombreTercero varchar(550) output,
@numero varchar(550) output
as
begin tran gTipoLiquidacion
declare @acumulado varchar(50),@numeroAcu varchar(50)
exec spLiquidacionNominaPeriodo @año,@mes,@periodo,@empresa,@ccosto,@empleado,@fecheGeneral,@formaLiquidacion,@retorno output,@nombreTercero output
set @mes = (select top 1 mes from nPeriodoDetalle where noPeriodo=@periodo and año=@año and empresa=@empresa)

select @acumulado= acu from nParametrosGeneral where empresa=@empresa
 	---Inserta la liquidacion y ejecuta

	if exists(select * from tmpliquidacionNomina where empresa=@empresa)
	begin
		declare @retornoo int
		exec spRetornaConsecutivoTransaccion @tipotransaccion,@empresa,@numero output
		exec spRetornaConsecutivoTransaccion @acumulado,@empresa,@numeroAcu output
		insert nLiquidacionNomina
		select @empresa,@tipoTransaccion,@numero,@año,@mes,@fecheGeneral,GETDATE(),@usuario,0,0,'L',@observacion,null,null
		insert nLiquidacionNominaDetalle
		select a.empresa,@tipoTransaccion,@numero,año,mes,ROW_NUMBER() OVER(ORDER BY tercero,a.signo, concepto DESC) registro,
		noPeriodo,tercero,concepto,fechaInical,fechaFinal,ccosto,departamento,cantidad,a.porcentaje,valorUnitario,
		round(valorTotal,0),a.signo,saldo,noDias,entidad,a.noContrato, b.basePrimas,b.baseCajaCompensacion,b.baseCesantias,
		b.baseVacaciones,b.baseIntereses,b.baseSeguridadSocial,b.manejaRango,b.baseEmbargo,a.noPrestamo,a.cantidadPadelma,a.valorPadelma,a.fecha,
		a.tipoConcepto,a.desTipoConcepto
		from tmpliquidacionNomina  a
		join nConcepto b on b.codigo=a.concepto and b.empresa=a.empresa
		where a.empresa=@empresa

		insert nLiquidacionNominaDatos
		select distinct 
		a.empresa,		tipo,		numero, 	año,	mes,		a.Noperiodo,		a.tercero,		b.id,		b.salario,
		b.entidadEps, 		b.entidadPension,		b.entidadCesantias,		b.entidadArp,		b.entidadCaja,		b.entidadSena,
		b.entidadIcbf, b.centroTrabajo
		from nLiquidacionNominaDetalle a 
		join nContratos b on a.tercero=b.tercero and a.empresa=b.empresa and a.contrato=b.id
		where a.numero=@numero and tipo=@tipoTransaccion and a.empresa=@empresa and a.noPeriodo=@periodo
		

		if exists(select * from nVacaciones where empresa=@empresa  and anulado=0 and añoPago=@año and periodo=@periodo and pagaNomina=0)
		begin
			insert nLiquidacionNomina
			select @empresa,@acumulado,@numeroAcu,@año,@mes,@fecheGeneral,GETDATE(),@usuario,0,0,'L',@observacion,null,null
			insert nLiquidacionNominaDetalle
			select a.empresa,@acumulado,@numeroAcu,año,mes,ROW_NUMBER() OVER(ORDER BY tercero,a.signo, concepto DESC) registro,
			c.periodo,c.empleado,concepto,c.fechaSalida,fechaRetorno,ccosto,departamento,cantidad,a.porcentaje,valorUnitario,
			round(valorTotal,0),a.signo,saldo,noDias,entidad,d.id, b.basePrimas,b.baseCajaCompensacion,b.baseCesantias,
			b.baseVacaciones,b.baseIntereses,b.baseSeguridadSocial,b.manejaRango,b.baseEmbargo,a.noPrestamo,a.cantidad,a.valorTotal,c.fechaSalida,
			c.tipo, case when c.tipo=1 then 'Disfrutada' when c.tipo=2 then 'Compensada' else 'Compensadas 8/7' end
			from nVacaciones c 
			join nVacacionesDetalle  a on  c.empresa=a.empresa	and c.registro=a.registro and c.empleado=a.empleado
			join nConcepto b on b.codigo=a.concepto and b.empresa=a.empresa
			join nContratos d on d.tercero=c.empleado and d.empresa=c.empresa and d.id in (select max(id) from nContratos where tercero=c.empleado and empresa=c.empresa)
 			where a.empresa=@empresa and c.periodo=@periodo and c.añoPago=@año and c.pagaNomina=0
		end

		exec spActualizaConsecutivoTransaccion @tipotransaccion,@empresa,@retornoo output
		exec spRecalculaSaldosLiquidacion @empresa,@periodo,@mes,@año,@numero,1
		exec spSeleccionaPesoPromedioLotePeriodoAutomatico @empresa,@año,@mes
		
	end

	if (@@error = 0  and @retorno=20) 
	begin 
		set @retornoo = 0 
		commit tran gTipoLiquidacion 
	end 
	else 
	begin 
		--set @Retornoo = 1 
		rollback tran gTipoLiquidacion 
	end