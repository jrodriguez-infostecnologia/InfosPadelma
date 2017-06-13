
CREATE proc [dbo].[spLiquidaConceptosBasicosVacaciones]
@empresa int,
@tercero int,
@fecha date,
@noDias int,
@fechaInicial date,
@fechaFinal date,
@valorbase money,
@periodo int,
@año int
as
-- variables
delete tmpliquidacionNominaVacaciones
where empresa=@empresa and tercero=@tercero

declare  @conceptosLiquidar table 
(acumulada bit,
concepto varchar(50),
tipoLiquidacion varchar(6),
signo int,
baseSeguridadSocial bit,
validaPorcentaje bit,
porcentaje float,
valor money,
baseEmbargo bit,
tipoNovedadLiquida  bit,
cantidadNovedad decimal(18,2),
fecha date,
prioridad int
)

declare @centroCosto varchar(50), @departamento varchar(50),@signo int, @baseSeguridadSocial bit,
@baseEmbargosNomina bit, @entidadEps varchar(50), @entidadPension varchar(50),
@conceptoVacaciones varchar(50), @conceptoSalud varchar(50), @conceptoPension varchar(50),
@NSI int ,@JD int, @conceptoGanaDomingo varchar(50), @salario money, @tipoLiquidacionNomina varchar(6),
@cantidad decimal(18,2), @valorUnitario money, @mes int, @porcentajeConcepto decimal(18,2), @baseEmbargo bit, @manejaPorcentaje bit,@valorbaseseguridadsocial money=0,
@valorCuota decimal(18,2),@valorSaldo decimal(18,2), @conceptoPrestamo varchar(50), @concepto varchar(50), @valorBaseEmbargo money, @pagoMinimo money, @mSindicato bit=0,@mFondoEmpleado bit=0, @porSindicato decimal(18,2),@valorDiaSueltoTercero money,
@entidadSindicato varchar(50), @porFondoEmpleado decimal(18,2), @entidadFE varchar(50)

declare 
@codigo varchar(50), -- identificacion del empleado
@validaTurno bit , -- valida turno el empleado
@tipoNomina varchar(10), --  tipo de nomina del contrato
@tiempoBasico int, -- tiempo basico laborado
@fechaIngreso date, -- fecha ingreso empleado
@cantidadHoras int, -- cantidad de horas laboradas
@salarioIntegral bit, -- si es salario integral
@terminoContrato varchar(50), -- termino de contrato
@diasContrato int, -- dias de duracion del contrato
@Contratofijo bit, -- si es fijo o indefinido
@noContrato int, -- numero de contrato del empleado
@tipoNovedadLiquida bit,
@cantidadNovedad decimal(18,2),
@porc decimal(18,3),
@formaPago int ,  -- forma de pago si por destajo, fijo, ocacional destajo
@acumulada bit , -- si ya se encuetra acumulado esa nomina
@SMLV money, --salario minimo legal vigente
@NSST int, -- numero de sueldo subcidio de transporte
@ST money, -- 	subcidio de transporte
@FIPN date, -- fecha inicial periodo de nomina
@FFPN date,  -- fecha final periodo de nomina
@fechaInicialLiquidacion date,  -- fecha inicial para liquidar el empleado
@fechaFinalLiquidacion date, -- fecha final para liquidar el empleado
@fechaNovedadNomina date,
@tipoLiquidacion int,  -- tipo liquidacion del centro de costo a liquidar
@base varchar(50), -- base de liquidacion
@valor money, -- valor del concepto
@basePrimas bit, -- si es base para prima
@baseCajaCompensacion bit, -- si es base para caja de compensacion
@baseCesantias bit, -- si es base para cesantias
@baseIntereses bit, -- si es base para interes de cesantias
@baseVacaciones bit, -- base de vacaciones 
@controlConcepto int, -- suma  a sueldo o resta a sueldo
@controlaSaldo bit, -- si maneja saldo
@manejaRango bit, -- si maneja rango
@ingresoGravado bit, -- si es ingreso gravado
@valorConcepto money,
@valorDiaSalarioMinimo money,
@valorSTdiario money ,
@ganaTransporte int,
@prioridadConcepto int,
@conceptoPagaFestivo varchar(50),
@conceptoTransporte varchar(50),
@tieneIncapacidad bit,
@aprendizSena varchar(50),
@electivaProduccion bit,
@pEEP decimal(18,3),
@conceptoSueldo varchar(50),
@validaVacaciones int,
@FIVacaciones date,
@FFVacaciones date,
@NoDiasVacaciones int,
@swfd bit,
@fechaRetiro date,
@Contratodefinitivo bit,
@terceroEntidad varchar(50)


select @centroCosto=ccosto, @departamento=departamento,  @entidadEps=entidadEps, @entidadPension=entidadPension, @salario=salario, @mSindicato=msindicato, @mFondoEmpleado=mfondoEmpleado
,@entidadSindicato=entidadSindicato, @entidadFe=entidadFondoEmpleado,
@porSindicato=pSindicato, @porFondoEmpleado=pFondoEmpleado from ncontratos 
where tercero=@tercero and empresa=@empresa

set @año= datepart(year,@fecha)
		
set @mes = isnull( (select mes from nPeriodoDetalle where noPeriodo=@periodo and año=@año and empresa=@empresa),0)
set @valorDiaSueltoTercero=@salario/30

select @conceptoVacaciones = vacaciones, @conceptoSalud=salud, @conceptoPension=pension from nParametrosGeneral
where empresa=@empresa 


select @pagoMinimo=vMinimoPeriodo from nParametrosAno 
where empresa=@empresa and ano=@año


	-- Liquida novedades de nomina
	insert @conceptosLiquidar
		select 0, b.concepto, d.tipoLiquidacion, d.signo, d.baseSeguridadSocial, d.validaPorcentaje, d.porcentaje, b.valor, d.baseEmbargo,1,b.cantidad,a.fecha,d.prioridad
			from nnovedades a 
			join  nNovedadesDetalle b on a.tipo = b.tipo and a.numero = b.numero and a.empresa=b.empresa 
			join nConcepto d on d.codigo=b.concepto and d.empresa=b.empresa 
			where  a.empresa=@empresa and @año  between b.añoInicial and b.añoFinal
			and b.empleado=@tercero AND a.anulado=0 and b.anulado=0
			and d.signo=2 and
			(@periodo between   (case when b.añoInicial =@año then b.periodoInicial else 0 end) and 
			(case when b.añoFinal=@año then b.periodoFinal else 99999999 end))
select @NSI = noSalarioIntegral,@JD= jornadaDiaria, @conceptoGanaDomingo =jornales from nParametrosGeneral where empresa=@empresa

	
	--select * from @conceptosLiquidar
			--if (@tipoNovedadLiquida=1)
			--begin
			--	exec spLiquidaConceptoTercero  @empresa,@año, @concepto,@tercero,@cantidadNovedad,@valorConcepto,@noDias,@fechaNovedadNomina,@formaPago,@Valorunitario output,@cantidad output,@porcentajeConcepto output
			--	insert  tmpliquidacionNomina 
			--	select @empresa, @tercero, @centroCosto, @fechaNovedadNomina, @departamento, @concepto, @año, @mes, @periodo, @cantidad,@porcentajeConcepto, @valorUnitario,@valorUnitario,@signo, 0, @noDias, @fechaInicialLiquidacion, @fechaFinalLiquidacion, @baseSeguridadSocial, @baseEmbargo,null,@cantidad,@valorUnitario,@noContrato
			--end
		
	set @baseEmbargosNomina=0
	if @conceptoVacaciones is not null
	begin

	select @tipoLiquidacionNomina=tipoLiquidacion, @signo=signo, @baseSeguridadSocial=baseSeguridadSocial, @baseEmbargosNomina=baseEmbargo, @porcentajeConcepto=porcentaje, @manejaPorcentaje=validaPorcentaje from nconcepto
		where empresa=@empresa and codigo=@conceptoVacaciones	
	
		exec spCalculaTipoLiquidacion @JD , @salario , @tipoLiquidacionNomina ,@noDias,  @fechaInicial , @fechaFinal ,@fechaInicial , @fechaFinal , @cantidad  output, @valorUnitario  output
		insert  tmpliquidacionNominaVacaciones 
		select @empresa, @tercero, @centroCosto, @fecha, @departamento, @conceptoVacaciones, @año, @mes, @periodo, @cantidad,@porcentajeConcepto, @valorUnitario,@valorUnitario*@cantidad,@signo, 0, @noDias, @fechaInicial, @fechaFinal, @baseSeguridadSocial, @baseEmbargosNomina,null,0
	end

		-- Liquida Seguridad Social Pension
			if @conceptoPension is not null
			begin
			
			select @tipoLiquidacionNomina=tipoLiquidacion, @signo=signo, @baseSeguridadSocial=baseSeguridadSocial, @baseEmbargosNomina=baseEmbargo, @porcentajeConcepto=porcentaje, @manejaPorcentaje=validaPorcentaje from nconcepto
			where empresa=@empresa and codigo=@conceptoPension

			set @terceroEntidad = null	
			select @terceroEntidad = tercero from nEntidadFondoPension
			where empresa = @empresa and codigo=@entidadPension

				if @manejaPorcentaje = 1
				begin
					if exists(select *  from tmpliquidacionNominaVacaciones	where baseSeguridadSocial=1 and tercero=@tercero)
					begin
						insert  tmpliquidacionNominaVacaciones 
						select @empresa, @tercero, @centroCosto, @fecha, @departamento, @conceptoPension, @año, @mes, @periodo,1, @porcentajeConcepto, @valorBaseSeguridadSocial, SUM(valorTotal)*@porcentajeConcepto/100, @signo, 0, @noDias, @fechaInicial, @fechaFinal, @baseSeguridadSocial, @baseEmbargosNomina,@terceroEntidad,0
						from tmpliquidacionNominaVacaciones where baseSeguridadSocial=1 and tercero=@tercero and empresa=@empresa
					end
				end
				else
				begin					
					if exists(select *  from tmpliquidacionNominaVacaciones	where baseSeguridadSocial=1 and tercero=@tercero)
					begin
						insert  tmpliquidacionNominaVacaciones 
						select @empresa, @tercero, @centroCosto, @fecha, @departamento, @conceptoPension, @año, @mes, @periodo,1, @porcentajeConcepto, @valorBaseSeguridadSocial, SUM(valorTotal)*@porcentajeConcepto/100, @signo, 0, @noDias, @fechaInicial, @fechaFinal, @baseSeguridadSocial, @baseEmbargosNomina,@terceroEntidad,0
						from tmpliquidacionNominaVacaciones where baseSeguridadSocial=1 and tercero=@tercero and empresa=@empresa
					end
				end
			end

			-- Liquida Seguridad Social EPS
			if @conceptoSalud is not null
			begin
			select @tipoLiquidacionNomina=tipoLiquidacion, @signo=signo, @baseSeguridadSocial=baseSeguridadSocial, @baseEmbargosNomina=baseEmbargo, @porcentajeConcepto=porcentaje, @manejaPorcentaje=validaPorcentaje from nconcepto
			where empresa=@empresa and codigo=@conceptoSalud

			select @terceroEntidad = tercero from nEntidadEps
			where empresa = @empresa and codigo=@entidadEps

				if @manejaPorcentaje = 1
				begin
					if exists(select *  from tmpliquidacionNominaVacaciones	where baseSeguridadSocial=1 and tercero=@tercero and empresa=@empresa)
					begin
						insert  tmpliquidacionNominaVacaciones 
						select @empresa, @tercero, @centroCosto, @fecha, @departamento, @conceptoSalud, @año, @mes, @periodo,1, @porcentajeConcepto, @valorBaseSeguridadSocial, SUM(valorTotal)*@porcentajeConcepto/100, @signo, 0, @noDias, @fechaInicial, @fechaFinal, @baseSeguridadSocial, @baseEmbargosNomina,@terceroEntidad,0
						from tmpliquidacionNominaVacaciones where baseSeguridadSocial=1 and tercero=@tercero and empresa=@empresa
					end
				end
				else
				begin					
					if exists(select *  from tmpliquidacionNominaVacaciones	where baseSeguridadSocial=1 and tercero=@tercero and empresa=@empresa)
					begin
						insert  tmpliquidacionNominaVacaciones 
						select @empresa, @tercero, @centroCosto, @fecha, @departamento, @conceptoSalud, @año, @mes, @periodo,1, @porcentajeConcepto, @valorBaseSeguridadSocial, SUM(valorTotal)*@porcentajeConcepto/100, @signo, 0, @noDias, @fechaInicial, @fechaFinal, @baseSeguridadSocial, @baseEmbargosNomina,@terceroEntidad,0
						from tmpliquidacionNominaVacaciones where baseSeguridadSocial=1 and tercero=@tercero and empresa=@empresa
					end
				end
			end

			-- prestamos para vacaciones

				declare curPrestamo insensitive cursor for
					select valorCuotas,	a.valorSaldo, a.concepto,signo, a.codigo from nPrestamo a join
						nConcepto b on a.concepto=b.codigo and a.empresa=b.empresa
						where a.empleado=@tercero and a.empresa=@empresa and valorSaldo>0 and año<=@año and mes<=@mes
					open curPrestamo			
					fetch curPrestamo into @valorCuota, @valorSaldo, @concepto,@signo,@codigo
					while( @@fetch_status = 0 )
					begin	
										if @valorCuota> @valorSaldo
						set @valorUnitario = @valorSaldo
						else
						set @valorUnitario = @valorCuota

						insert  tmpliquidacionNominaVacaciones 
						select @empresa, @tercero, @centroCosto, @fecha, @departamento, @concepto, @año, @mes, @periodo, 1,0, @valorUnitario,@valorUnitario,signo, @valorSaldo - @valorUnitario, @noDias, @fechaInicial, @fechaFinal,baseSeguridadSocial, baseEmbargo,null,@codigo
						from nConcepto where codigo=@concepto and empresa=@empresa

					fetch curPrestamo into @valorCuota, @valorSaldo, @concepto,@signo,@codigo
					end
					close curPrestamo
					deallocate curPrestamo

					-- embargos

					--  Liquida embargos vacaciones 
		
				if exists (select * from nEmbargos where empleado=@tercero and empresa=@empresa and activo=1 )
				begin
					if (select embargos from nParametrosGeneral where empresa=@empresa) is not null
					begin
					declare @tipoEmbargo varchar(50),  @destipoEmbargo varchar(200)
					set @valorBaseEmbargo = (select sum(case when signo = 1  then valorTotal else (-1)*valorTotal end) 
					from tmpliquidacionNominaVacaciones where baseEmbargos = 1 and tercero=@tercero and empresa=@empresa) 
				
						declare @conceptoEmbargo varchar(50) = (select embargos from nParametrosGeneral where empresa=@empresa)
						exec spliquidaEmbargosNomina  @empresa , @tercero,@valorBaseEmbargo ,@pagominimo,@noDias, @periodo,@año,@valorUnitario output 	,@tipoEmbargo output, @destipoEmbargo output											
						
						insert  tmpliquidacionNominaVacaciones 
						select @empresa, @tercero, @centroCosto, @fecha, @departamento, @conceptoEmbargo, @año, @mes, @periodo, 1,0, @valorUnitario,@valorUnitario,signo, 0, @noDias, @fechaInicial, @fechaFinal,baseSeguridadSocial, @baseEmbargosNomina,null,0
						from nConcepto where empresa=@empresa and codigo=@conceptoEmbargo
					end
				end

					if @mSindicato=1
			begin
					if exists(select sindicato from nParametrosGeneral where empresa=@empresa)
					begin
					declare @conceptoSindicato varchar(50)=(select sindicato from nParametrosGeneral where empresa=@empresa)
					select @signo=signo from nConcepto where codigo=@conceptoSindicato and empresa=@empresa
					set @terceroEntidad = null		
					select @terceroEntidad=tercero from nEntidadFondo
					where codigo=@entidadSindicato and empresa=@empresa
					 
						insert  tmpliquidacionNominaVacaciones 
						select @empresa, @tercero, @centroCosto, @fecha, @departamento, @conceptoSindicato, @año, @mes, @periodo,1, @porSindicato, @valorBaseSeguridadSocial, SUM(valorTotal)*@porSindicato/100, @signo, 0, @noDias, @fechaInicial, @fechaFinal, 0 , 0,@terceroEntidad,0
						from tmpliquidacionNominaVacaciones where signo=1 and tercero=@tercero

						end

			end
				--Liquida Fondo Empleado
			if @mFondoEmpleado=1
			begin
					if  exists(select fondoEmpleado from nParametrosGeneral where empresa=@empresa)
					begin
					declare @conceptoFondo varchar(50)=(select fondoEmpleado from nParametrosGeneral where empresa=@empresa)
					
					set @terceroEntidad = null	
					select @terceroEntidad=tercero from nEntidadFondo
					where codigo=@entidadSindicato and empresa=@empresa

					insert  tmpliquidacionNominaVacaciones 
					select @empresa, @tercero, @centroCosto, @fecha, @departamento, @conceptoFondo, @año, @mes, @periodo,1, @porSindicato, @valorDiaSueltoTercero, (@valorDiaSueltoTercero* @noDias)*@porFondoEmpleado/100, signo, 0, @noDias, @fechaInicial, @fechaFinal, 0 , 0,@entidadFE,0
					from nConcepto where codigo=@conceptoFondo and empresa=@empresa
					end

			end 



			declare cursorConceptos insensitive cursor for
			select  acumulada,concepto, tipoLiquidacion,  signo, baseSeguridadSocial, validaPorcentaje, porcentaje, valor, baseEmbargo, tipoNovedadLiquida, cantidadNovedad,fecha,prioridad
			from @conceptosLiquidar 
			order by signo,prioridad,concepto asc
			open cursorConceptos	
			fetch cursorConceptos into  @acumulada, @concepto, @tipoLiquidacion, @signo,@baseSeguridadSocial,@manejaPorcentaje, @porcentajeConcepto,@valorConcepto, @baseEmbargo, @tipoNovedadLiquida,@cantidadNovedad,@fechaNovedadNomina,@prioridadConcepto
			while( @@fetch_status = 0 )
			begin			
				exec spLiquidaConceptoTercero  @empresa,@año, @concepto,@tercero,@cantidadNovedad,@valorConcepto,@noDias,@fechaNovedadNomina,@formaPago,@Valorunitario output,@cantidad output,@porcentajeConcepto output
				--select 'entro'
				insert  tmpliquidacionNominaVacaciones 
				select @empresa, @tercero, @centroCosto, @fecha, @departamento, @concepto, @año, @mes, @periodo,@cantidadNovedad, @porSindicato, @valorUnitario, @valorUnitario, @signo, 0, @noDias, @fechaInicial, @fechaFinal, 0 , 0,@entidadFE,0
										
			fetch cursorConceptos into  @acumulada, @concepto, @tipoLiquidacion, @signo,@baseSeguridadSocial,@manejaPorcentaje, @porcentajeConcepto,@valorConcepto, @baseEmbargo, @tipoNovedadLiquida,@cantidadNovedad,@fechaNovedadNomina,@prioridadConcepto
			end
			close cursorConceptos
		deallocate cursorConceptos

			select b.codigo codConcepto, b.descripcion desconcepto,sum(isnull(a.cantidad,0)) cantidad,sum(isnull(a.valorUnitario,0)) valorUnitario, sum(isnull(valorTotal,0)) valorTotal, 
			case when a.signo= 1 then '+' else case when a.signo=2 then '-' else '' end end signo,
			convert(bit,case when b.codigo in (c.salud,c.pension) then 1 else 0 end) bss, noPrestamo  from tmpliquidacionNominaVacaciones a 
			join nConcepto b on a.concepto=b.codigo and a.empresa=b.empresa
			join nParametrosGeneral c on c.empresa=a.empresa
			where tercero=@tercero and a.empresa=@empresa
			group by  b.codigo , b.descripcion ,a.signo,c.pension,c.salud, noPrestamo