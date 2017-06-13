create proc [dbo].[spLiquidacionCesantiasDefinitiva]
@formaLiquidacion int,
@empresa int,
@ccosto varchar(50) ,
@empleado varchar(50),
@año int,
@fechaGeneral date,
@sueldoActual bit,
@tipoTransaccion varchar(50),
@usuario varchar(50),
@observacion varchar(900),
@añoPago int,@periodoPago int,
@retorno int output,
@numero varchar(550) output
as
begin tran gTipoLiquidacion

exec spLiquidacionCesantias  @formaLiquidacion,@empresa,@ccosto,@empleado,@año,@fechaGeneral,@sueldoActual, @retorno output

	if exists(select * from tmpliquidacionNomina where empresa=@empresa)
	begin
		declare @retornoo int
		exec spRetornaConsecutivoTransaccion @tipotransaccion,@empresa,@numero output
		insert nLiquidacioncesantia
		select @empresa,@tipoTransaccion,@numero,@fechaGeneral,@añoPago,@periodoPago,@observacion,0,@usuario,null,GETDATE(),null
		insert nLiquidacionCesantiaDetalle
		select a.empresa,@tipoTransaccion,@numero,a.tercero, a.año,a.fechaInicial,a.fechaFinal,a.fechaIngreso,a.basico,a.valorTransporte,a.valorPromedio,
		a.base,a.diasPromedio,a.diasCesantia,a.valorCesantia,a.valorInteresCesantia,a.contrato
		from tmpLiquidacionCesantia  a
		where a.empresa=@empresa

			
			select * from nLiquidacionCesantiaDetalle
		exec spActualizaConsecutivoTransaccion @tipotransaccion,@empresa,@retornoo output
		


		select * from tmpLiquidacionCesantia
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