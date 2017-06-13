
CREATE proc [dbo].[spLiquidaSoloVacaciones]
--liquida conceptos base vacaciones
-- parametros
@empresa int,
@tercero int,
@fecha date,
@noDias int,
@fechaInicial date,
@fechaFinal date,
@valorbase money
as
-- variables
delete tmpliquidacionNominaVacaciones
where empresa=@empresa and tercero=@tercero

declare @centroCosto varchar(50), @departamento varchar(50),@signo int, @baseSeguridadSocial bit,
@baseEmbargosNomina bit, @entidadEps varchar(50), @entidadPension varchar(50),
@conceptoVacaciones varchar(50), @conceptoSalud varchar(50), @conceptoPension varchar(50),
@NSI int ,@JD int, @conceptoGanaDomingo varchar(50), @salario money, @tipoLiquidacionNomina varchar(6),
@cantidad decimal(18,2), @valorUnitario money,@año int, @mes int, @periodo int, @porcentajeConcepto decimal(18,2), @baseEmbargo bit, @manejaPorcentaje bit,@valorbaseseguridadsocial money=0,
@valorCuota decimal(18,2),@valorSaldo decimal(18,2), @conceptoPrestamo varchar(50), @concepto varchar(50), @valorBaseEmbargo money, @pagoMinimo money, @mSindicato bit=0,@mFondoEmpleado bit=0, @porSindicato decimal(18,2),@valorDiaSueltoTercero money,
@entidadSindicato varchar(50), @porFondoEmpleado decimal(18,2), @entidadFE varchar(50)

select @centroCosto=ccosto, @departamento=departamento,  @entidadEps=entidadEps, @entidadPension=entidadPension, @salario=salario, @mSindicato=msindicato, @mFondoEmpleado=mfondoEmpleado
,@entidadSindicato=entidadSindicato, @entidadFe=entidadFondoEmpleado,
@porSindicato=pSindicato, @porFondoEmpleado=pFondoEmpleado from ncontratos 
where tercero=@tercero and empresa=@empresa

set @año= datepart(year,@fecha)
set @mes = datepart(MONTH, @fecha)
set @valorDiaSueltoTercero=@salario/30

select @conceptoVacaciones = vacaciones, @conceptoSalud=salud, @conceptoPension=pension from nParametrosGeneral
where empresa=@empresa 


select @pagoMinimo=vMinimoPeriodo from nParametrosAno 
where empresa=@empresa and ano=@año

select @NSI = noSalarioIntegral,@JD= jornadaDiaria, @conceptoGanaDomingo =jornales from nParametrosGeneral where empresa=@empresa
	
	set @baseEmbargosNomina=0
	if @conceptoVacaciones is not null
	begin

	select @tipoLiquidacionNomina=tipoLiquidacion, @signo=signo, @baseSeguridadSocial=baseSeguridadSocial, @baseEmbargosNomina=baseEmbargo, @porcentajeConcepto=porcentaje, @manejaPorcentaje=validaPorcentaje from nconcepto
		where empresa=@empresa and codigo=@conceptoVacaciones	
	
		exec spCalculaTipoLiquidacion @JD , @salario , @tipoLiquidacionNomina ,@noDias,  @fechaInicial , @fechaFinal ,@fechaInicial , @fechaFinal , @cantidad  output, @valorUnitario  output
		insert  tmpliquidacionNominaVacaciones 
		select @empresa, @tercero, @centroCosto, @fecha, @departamento, @conceptoVacaciones, @año, @mes, @periodo, @cantidad,@porcentajeConcepto, @valorUnitario,@valorUnitario*@cantidad,@signo, 0, @noDias, @fechaInicial, @fechaFinal, @baseSeguridadSocial, @baseEmbargosNomina,null,0
	end

	select b.codigo codConcepto, b.descripcion desconcepto,isnull(a.cantidad,0) cantidad,isnull(a.valorUnitario,0) valorUnitario, isnull(valorTotal,0) valorTotal, 
			case when a.signo= 1 then '+' else case when a.signo=2 then '-' else '' end end signo,
			convert(bit,case when b.codigo in (c.salud,c.pension) then 1 else 0 end) bss , noPrestamo from tmpliquidacionNominaVacaciones a 
			join nConcepto b on a.concepto=b.codigo and a.empresa=b.empresa
			join nParametrosGeneral c on c.empresa=a.empresa
			where tercero=@tercero and a.empresa=@empresa