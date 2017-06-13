
CREATE proc [dbo].[spCalulaIncapacidadEmpleado]
@empresa int,
@tercero int,
@noDias int,
@tipoIncapacidad varchar(50),
@fecha date,
@diaPagos int,
@diainicio int,
@valor money output,
@valorPago money output
as

declare @Salario money=0, @salirioDiario money=0,@porcentaje float=0, @porNuevo float=0, 
@adicional bit,@noDiasDespues int=0,@SMLV money,@SMLVDiario money

set @SMLV = (select vSalarioMinimo from nParametrosAno where empresa=@empresa and ano=YEAR(@fecha))


set @salario = isnull((select salario from nContratos where empresa=@empresa and tercero=@tercero 
and id in (select max(id) from nContratos where empresa=@empresa and tercero=@tercero )),0)
set @salirioDiario = @Salario/30
set @SMLVDiario = @SMLV /30



select @porcentaje= porcentaje, @porNuevo=porcentajeNuevo , @adicional = adicionarPorcentaje, @noDiasDespues = despues from nTipoIncapacidad
where codigo=@tipoIncapacidad and empresa=@empresa

if (@adicional = 1 and @noDias>1 )
begin
	set @valor = (@salirioDiario * @noDiasDespues) * @porcentaje /100
	
	if (@salirioDiario  * (@porNuevo /100))<@SMLVDiario
		set @valor =  @valor + (@SMLVDiario * (@noDias - @noDiasDespues)) 
	else
		set @valor =  @valor + (  (@salirioDiario * @porNuevo /100) * (@noDias - @noDiasDespues) )
end
else
begin
	set @valor = (@salirioDiario * @noDias) * @porcentaje /100
end

if (@adicional = 1 and @diaPagos>1)
begin
	set @valorPago = (@salirioDiario * @noDiasDespues) * @porcentaje /100
	if (@salirioDiario  * (@porNuevo /100))<@SMLVDiario
		set @valorPago =  @valorPago +  (@SMLVDiario * (  @diaPagos - @noDiasDespues)) 
	else
		set @valorPago =  @valorPago + (  (@salirioDiario * @porNuevo /100) * ( @diaPagos - @noDiasDespues) )
end
else
begin
	set @valorPago = (@salirioDiario * @diaPagos) * @porcentaje /100
end

set @valor = ROUND(@valor,0)
set @valorPago = ROUND(@valorPago,0)