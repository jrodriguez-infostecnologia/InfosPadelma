CREATE proc [dbo].[spLiquidacionPrimasDefinitiva]
@formaLiquidacion int,
@empresa int,
@ccosto varchar(50) ,
@empleado varchar(50),
@añoInicial int,
@añoFinal int,
@periodoInicial int,
@periodoFinal int,
@fechaGeneral date,
@tipoTransaccion varchar(50),
@usuario varchar(50),
@observacion varchar(900),
@añoPago int,
@periodoPago int,
@retorno int output,
@numero varchar(550) output
as
begin tran gTipoLiquidacion

exec spLiquidacionPrimas @formaLiquidacion,@empresa,@ccosto,@empleado,@añoInicial,@añoFinal,@periodoInicial,@periodoFinal,@fechaGeneral, @retorno output

	--if exists(select * from nLiquidacionPrima where empresa=@empresa and año=@añoPago and periodo=@periodoPago)
	--begin
	--	--select 'entro'
	--	set @retorno =5
	--	rollback tran gTipoLiquidacion 
	--	return
	--end

	if exists(select * from tmpliquidacionNomina where empresa=@empresa)
	begin
		declare @retornoo int
		exec spRetornaConsecutivoTransaccion @tipotransaccion,@empresa,@numero output
		insert nLiquidacionPrima
		select @empresa,@tipoTransaccion,@numero,@fechaGeneral,@añoPago,@periodoPago,@observacion,0,@usuario,null,GETDATE(),null
		insert nLiquidacionPrimaDetalle
		select a.empresa,@tipoTransaccion,@numero,a.tercero,a.añoInicial,a.añoFinal,a.periodoInicial,a.periodoFinal,
		a.fechaInicial,a.fechaFinal,a.fechaIngreso,a.basico,a.valorTransporte,a.valorPromedio,a.base,
		a.diasPromedio,a.diasPrimas,a.valorPrima,a.contrato		
		from tmpLiquidacionPrima  a
		where a.empresa=@empresa
			
		exec spActualizaConsecutivoTransaccion @tipotransaccion,@empresa,@retornoo output
		
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