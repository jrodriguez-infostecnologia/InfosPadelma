
CREATE proc [dbo].[spCalulaIncapacidadEmpleadoDetalle]
@empresa int,
@tercero int,
@numero int
as


declare @Salario money=0, @salirioDiario money=0,@porcentaje float=0, @porNuevo float=0, 
@adicional bit,@noDiasDespues int=0,@SMLV money,@SMLVDiario money,@fii date,
@noDias int,
@tipoIncapacidad varchar(50),
@fecha date,
@diaPagos int,
@diainicio int,
@fi date,
@ff date,
@valor money ,
@valorPago money





select @fi=fechaInicial,@ff=fechaFinal,@fii=fechaInicial,@nodias=noDias,@diaPagos=diasPagos,@tipoIncapacidad=tipoIncapacidad 
from nIncapacidad where tercero=@tercero and empresa=@empresa and numero=@numero

select @porcentaje= porcentaje, @porNuevo=porcentajeNuevo , @adicional = adicionarPorcentaje, @noDiasDespues = despues from nTipoIncapacidad
where codigo=@tipoIncapacidad and empresa=@empresa

set @SMLV = (select vSalarioMinimo from nParametrosAno where empresa=@empresa and ano=YEAR(@fi))
set @salario = isnull((select salario from nContratos where empresa=@empresa and tercero=@tercero 
and id in (select max(id) from nContratos where empresa=@empresa and tercero=@tercero )),0)
set @salirioDiario = @Salario/30
set @SMLVDiario = @SMLV /30

declare @conta int=1,@dPago int=0
while (@fi<=@ff)
begin
	if (@adicional = 1 and @conta>1 )
	begin
		if (@conta<=@noDiasDespues)
		begin
			set @valor = @salirioDiario  * @porcentaje /100
			if (@conta<=@diaPagos)
			begin
				set @valorPago=@valor
				set @dPago=1
			end
			else
			begin
				set @valorPago=0
				set @dPago=0
			end
			
			insert nIncapacidaddetalle
			select @empresa,@tercero,@numero,@fi,1,@valor,@dPago,@valorPago
		end
		else
		begin
			if (@salirioDiario  * (@porNuevo /100))<@SMLVDiario
			begin
				set @valor =   @SMLVDiario 
				if (@conta<=@diaPagos)
				begin
					set @valorPago=@valor
					set @dPago=1
				end
				else
				begin
					set @valorPago=0
					set @dPago=0
				end
			end
			else
			begin
				set @valor = @salirioDiario  * @porNuevo /100
				if (@conta<=@diaPagos)
				begin
					set @valorPago=@valor
					set @dPago=1
				end
				else
				begin
					set @valorPago=0
					set @dPago=0
				end
			end
			insert nIncapacidaddetalle
			select @empresa,@tercero,@numero,@fi,1,@valor,@dPago,@valorPago
		end
	end
	else
	begin
		set @valor = round(((@salirioDiario * @porcentaje )/100),0)
		if (@conta<=@diaPagos)
		begin
			set @valorPago=@valor
			set @dPago=1
		end
		else
		begin
			set @valorPago=0
			set @dPago=0
		end
		insert nIncapacidaddetalle
		select @empresa,@tercero,@numero,@fi,1,@valor,@dPago,@valorPago
	end
	set @fi=DATEADD(day,1,@fi)
	set @conta=@conta+1
end