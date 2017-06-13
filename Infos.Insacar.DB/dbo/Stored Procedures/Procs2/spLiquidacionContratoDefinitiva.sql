CREATE proc [dbo].[spLiquidacionContratoDefinitiva]
@año int,
@mes int,
@periodo int,
@empresa int,
@empleado varchar(50) ,
@fechaGeneral date,
@tipoTransaccion varchar(50),
@usuario varchar(50),
@observacion varchar(900),
@liquidacionNomina bit,
@retorno int output,
@numero varchar(550) output
as
begin tran gTipoLiquidacion

--exec spLiquidacionContratoTrabajadorDefinitiva @empresa,@empleado,@Periodo,@año,@liquidacionNomina,@fechaGeneral
set @mes = isnull((select top 1 mes from nPeriodoDetalle where noPeriodo=@periodo and año=@año and empresa=@empresa),month(@fechaGeneral))
	---Inserta la liquidacion y ejecuta


	if exists(select * from nLiquidacionNomina a join  nLiquidacionNominaDetalle b on b.numero=a.numero and b.tipo=a.tipo and b.empresa=a.empresa
	 where a.empresa=@empresa and a.tipo=@tipoTransaccion and b.tercero=@empleado and a.anulado=0 and contrato = (select max(id) from nContratos where empresa=@empresa and tercero=@empleado))
	begin
		set @retorno = 2
		rollback tran gTipoLiquidacion 
		return
	end
	if exists(select * from tmpliquidacionNomina where empresa=@empresa)
	begin
		exec spRetornaConsecutivoTransaccion @tipotransaccion,@empresa,@numero output
		insert nLiquidacionNomina
		select @empresa,@tipoTransaccion,@numero,@año,@mes,@fechaGeneral,GETDATE(),@usuario,0,0,'L',@observacion,null,null
		insert nLiquidacionNominaDetalle
		select a.empresa,@tipoTransaccion,@numero,año,@mes,ROW_NUMBER() OVER(ORDER BY tercero,a.signo, concepto DESC) registro,
		noPeriodo,tercero,concepto,fechaInical,fechaFinal,ccosto,departamento,cantidad,a.porcentaje,valorUnitario,
		round(valorTotal,0),a.signo,saldo,noDias,entidad,noContrato, b.basePrimas,b.baseCajaCompensacion,b.baseCesantias,
		b.baseVacaciones,b.baseIntereses,b.baseSeguridadSocial,b.manejaRango,b.baseEmbargo,a.noPrestamo,a.cantidadPadelma,a.valorPadelma,a.fecha,
		a.tipoConcepto,a.desTipoConcepto
		from tmpliquidacionNomina  a
		join nConcepto b on b.codigo=a.concepto and b.empresa=a.empresa
		where a.empresa=@empresa


		insert nLiquidacionNominaDatos
		select distinct 
		a.empresa,	tipo,numero,año,mes,a.Noperiodo,a.tercero,		b.id,		b.salario,
		b.entidadEps, 		b.entidadPension,		b.entidadCesantias,		b.entidadArp,		b.entidadCaja,		b.entidadSena,
		b.entidadIcbf, b.centroTrabajo
		from nLiquidacionNominaDetalle a join nContratos b on a.tercero=b.tercero and a.empresa=b.empresa
		and a.contrato=b.id
		where a.numero=@numero and tipo=@tipoTransaccion and a.empresa=@empresa and a.noPeriodo=@periodo

		exec spActualizaConsecutivoTransaccion @tipotransaccion,@empresa,@retorno output
		--exec spRecalculaSaldosLiquidacion @empresa,@periodo,@mes,@año,@numero,1
	end

	if (@@error = 0 ) 
	begin 
		set @retorno = 0 
		commit tran gTipoLiquidacion 
	end 
	else 
	begin 
		set @retorno = 1 
		rollback tran gTipoLiquidacion 
	end