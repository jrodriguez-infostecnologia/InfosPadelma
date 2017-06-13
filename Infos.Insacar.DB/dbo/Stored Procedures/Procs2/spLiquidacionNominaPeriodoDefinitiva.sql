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

exec spLiquidacionNominaPeriodo @año,@mes,@periodo,@empresa,@ccosto,@empleado,@fecheGeneral,@formaLiquidacion,@retorno output,@nombreTercero output
set @mes = (select top 1 mes from nPeriodoDetalle where noPeriodo=@periodo and año=@año and empresa=@empresa)
	---Inserta la liquidacion y ejecuta

	if exists(select * from tmpliquidacionNomina where empresa=@empresa)
	begin
		declare @retornoo int
		exec spRetornaConsecutivoTransaccion @tipotransaccion,@empresa,@numero output
		insert nLiquidacionNomina
		select @empresa,@tipoTransaccion,@numero,@año,@mes,@fecheGeneral,GETDATE(),@usuario,0,0,'L',@observacion,null,null
		insert nLiquidacionNominaDetalle
		select a.empresa,@tipoTransaccion,@numero,año,mes,ROW_NUMBER() OVER(ORDER BY tercero,a.signo, concepto DESC) registro,
		noPeriodo,tercero,concepto,fechaInical,fechaFinal,ccosto,departamento,cantidad,a.porcentaje,valorUnitario,
		round(valorTotal,0),a.signo,saldo,noDias,entidad,noContrato, b.basePrimas,b.baseCajaCompensacion,b.baseCesantias,
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
		from nLiquidacionNominaDetalle a join nContratos b on a.tercero=b.tercero and a.empresa=b.empresa
		and a.contrato=b.id
		where a.numero=@numero and tipo=@tipoTransaccion and a.empresa=@empresa and a.noPeriodo=@periodo
		
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