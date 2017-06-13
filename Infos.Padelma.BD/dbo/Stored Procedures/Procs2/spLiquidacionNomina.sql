
CREATE proc [dbo].[spLiquidacionNomina]
@año int, 
@noPeriodo int,
@empresa int,
@ccosto varchar(50), 
@empleado varchar(50), 
@retorno int  output
as

declare @mes int,
@SMLV money,
@NSST int,
@ST money,
@tercero int,
@fechaIngreso date,
@fechaTC date,
@FIPN date, 
@FFPN date, 
@NSI int,
@JD int,
@tipoLiquidacion int, 
@signo int,
@base varchar(50),
@porcentaje decimal(18,3),
@valor money,
@basePrimas bit,
@baseCajaCompensacion bit,
@baseCesantias bit,
@baseIntereses bit,
@baseSeguridadSocial bit,
@baseVacaciones bit,
@controlConcepto int,
@controlaSaldo bit,
@manejaRango bit,
@ingresoGravado bit,
@salario money,
@noDias int,
@noHoras int,
@concepto varchar(50),
@ValidaPor bit, 
@fijo bit, 
@manejaPorcentaje bit,
@cantidad decimal(18,3),
@parteContrato bit, 
@prioridad int, 
@baseBSS money, 
@formaPago int,
@vSalarioMinimo money, 
@vAuxilioTransporte money, 
@nDiasLiquidacion int, 
@baseEmbargo bit,
 @pagoMinimo money=0

 set @retorno =0

 create table #conceptosLiquidacion
	(
	empleado int,
	fechaIngreso date,
	fechaTC date,
	concepto varchar(50),
	tipoLiquidacion int,
	cantidad decimal(18,2),
	fijo bit,
	valor money,
	porcentaje decimal(18,3),
	manejaPorcentaje bit,
	controlConcepto int,
	baseCesantias bit,
	baseIntereses bit,
	baseSeguridadSocial bit,
	baseVacaciones bit,
	basePrimas bit,
	baseCajaCompensacion bit,
	controlaSaldo bit,
	manejaRango bit,
	ingresoGravado bit,
	salario money,
	base varchar(50),
	signo int,
	prioridad int,
	formapago int,
	baseEmbargo bit	
	)			
	
	create table #liquidacion(
	tercero varchar(50),
	concepto varchar(50),
	cantidad decimal(8,3),
	valor money	,
	signo int,
	baseSeguridadSocial bit	,
	saldo money,
	baseEmbargo bit)
		
	
	-- borra tabla temporal de la liquidacion
	delete tmpliquidacionNomina 
	 
	 -- mes del la liquidacion 

	set @mes=
	(select distinct mes from nPeriodoDetalle	
		where cerrado=0 and empresa=@empresa and año=@año and noPeriodo=@noPeriodo)
	 
	 --  pago minimo en la nomina
	set @pagoMinimo =
	(select distinct vminimoperiodo from nParametrosAno 
		where empresa=@empresa and @año=@año)
		
	if exists(select * from nParametrosAno where empresa=@empresa and @año=@año)	
	begin
		set @vsalarioMinimo = isnull((select vSalarioMinimo from nParametrosAno where ano=@año and empresa=@empresa),0)
		set @vAuxilioTransporte = isnull((select vAuxilioTransporte from nParametrosAno where ano=@año and empresa=@empresa),0)
		set @NSST = isnull((select noSueldoST from nParametrosAno where ano=@año and empresa=@empresa),0)
	end 
	else
	begin
		set @retorno=1
		--return
	end
		if exists(select * from nPeriodoDetalle	where cerrado=0 and empresa=@empresa and año=@año and mes=@mes and noPeriodo=@noPeriodo)	
		begin
			select @FIPN= fechaInicial,@FFPN = fechaFinal, @nDiasLiquidacion=diasnomina from nPeriodoDetalle
			where cerrado=0 and empresa=@empresa
			and año=@año and mes=@mes and noPeriodo=@noPeriodo

		end
		else
	begin
		set @retorno=2
		--return
	end
		if not exists(select * from nConceptosFijosDetalle where empresa=@empresa and año=@año and mes=@mes and noPeriodo=@noPeriodo)
			begin
				set @retorno=3
		--return
	end
		if not exists(select * from nParametrosGeneral where empresa=@empresa )
		begin
		set @retorno=4
		--return
		end
		else
		begin
		select @NSI = noSalarioIntegral,@JD= jornadaDiaria from nParametrosGeneral where empresa=@empresa
	end
	

	insert #conceptosLiquidacion
	select distinct a.tercero,b.fechaingreso,b.fechaContratoHasta, c.concepto, d.tipoLiquidacion,
	0 cantidad,
	d.fijo, d.valor , d.porcentaje, d.validaPorcentaje, d.controlConcepto, 
	d.baseCesantias, d.baseIntereses, d.baseSeguridadSocial, d.baseVacaciones, d.basePrimas,
	d.baseCajaCompensacion, d.controlaSaldo,d.manejaRango, d.ingresoGravado, b.salario, d.base, d.signo,  d.prioridad,
	e.formapago,
	d.baseembargo from
	 nFuncionario  a
	join ncontratos b on b.tercero=a.tercero and b.empresa=a.empresa
	join nConceptosFijosDetalle c  on c.centrocosto = b.ccosto
	join nConcepto d on d.codigo=c.concepto and d.empresa=c.empresa and d.activo=1
	join nConceptosFijos e on e.empresa=c.empresa and e.año=c.año and e.mes=c.mes 
	where b.activo=1
	and a.empresa=@empresa and c.año=@año and c.mes=@mes and c.noPeriodo=@noPeriodo
	and b.fechaIngreso<= @FFPN 
	and b.ccosto like '%'+@ccosto+'%'
	


	insert #conceptosLiquidacion
	select distinct a.tercero,b.fechaingreso,b.fechaContratoHasta, c.concepto, d.tipoLiquidacion,
	c.cantidad,
	d.fijo, case when d.valor=0 then c.valor end valor , d.porcentaje, d.validaPorcentaje, d.controlConcepto, 
	d.baseCesantias, d.baseIntereses, d.baseSeguridadSocial, d.baseVacaciones, d.basePrimas,
	d.baseCajaCompensacion, d.controlaSaldo,d.manejaRango, d.ingresoGravado, b.salario, d.base, d.signo, d.prioridad,
	100,
	d.baseembargo from nFuncionario  a
	join ncontratos b on b.tercero=a.tercero and b.empresa=a.empresa
	join nNovedadesDetalle c on c.empleado=a.tercero and c.empresa=b.empresa
	join nConcepto d on d.codigo=c.concepto and d.empresa=c.empresa and d.activo=1
	join nNovedades e on e.numero=c.numero and e.tipo = c.tipo and e.empresa=d.empresa
	where  a.empresa=@empresa and c.año=@año  and  @noPeriodo between c.periodoInicial and c.periodoFinal
	and b.ccosto like '%'+@ccosto+'%'	
	and e.anulado<>1


	declare curMov insensitive cursor for

	select distinct empleado,fechaIngreso,fechaTC,concepto,tipoLiquidacion, signo,base,porcentaje,valor,basePrimas,baseCajaCompensacion,
	baseCesantias,baseIntereses,basePrimas,baseSeguridadSocial,baseVacaciones,controlConcepto,controlaSaldo,manejaRango,ingresoGravado,
	controlConcepto,salario,manejaPorcentaje,fijo, manejaPorcentaje,porcentaje/100, cantidad, prioridad, formapago,baseEmbargo  from #conceptosLiquidacion
	order by empleado,prioridad
	
	--cursor
	open curMov			
	fetch curMov into @tercero,@fechaIngreso,@fechaTC,@concepto,@tipoLiquidacion, @signo,@base,@porcentaje,@valor,@basePrimas,@baseCajaCompensacion,
	@baseCesantias,@baseIntereses,@basePrimas,@baseSeguridadSocial,@baseVacaciones,@controlConcepto,@controlaSaldo,@manejaRango,@ingresoGravado,
	@controlConcepto,@salario,@ValidaPor ,@fijo,@manejaPorcentaje,@porcentaje,@cantidad, @prioridad,@formapago,@baseEmbargo
		

	
	declare @VU money, @FI date,@FF date,@ND int,@VT money,@TotalDebengado money
	while( @@fetch_status = 0 )
	begin	
	
		if @fechaIngreso<=@FIPN
		set @FI =@FIPN
		else
			if @fechaIngreso<=@FFPN	
			begin
			set @FI=@fechaIngreso				
			end

		if @FFPN > @fechaTC
		begin
			set @FF=@fechaTC
		end
		else
			set @FF=@FFPN

	if @formapago = 0
	begin	
		-- liquida sueldo 
		if exists (select * from nparametrosgeneral where sueldo=@concepto and empresa=@empresa )
		begin
		exec 	spCalculaTipoLiquidacion @JD , @salario , @tipoLiquidacion ,@nDiasLiquidacion,  @FI , @FF ,@FIPN , @FFPN , @ND  output, @VU  output
		
					insert #liquidacion
					select @tercero, @concepto, @ND, @VU,@signo,@baseSeguridadSocial,null,@baseEmbargo
		end
		else

			-- Liquidacion de salud y pension
		if exists (select * from nparametrosgeneral where (@concepto = pension or @concepto = salud ) and empresa=@empresa )
		begin

		if @manejaPorcentaje = 1
					begin
					insert #liquidacion 
					select @tercero,@concepto,1, SUM(cantidad*valor)* @porcentaje, @signo, @baseSeguridadSocial,null,@baseEmbargo from #liquidacion a
					 where a.baseSeguridadSocial=1 and tercero=@tercero
					 group by baseSeguridadSocial	
					end
					else
					begin
					insert #liquidacion 
					select @tercero,@concepto,1, @valor, @signo, @baseSeguridadSocial,null,@baseEmbargo from #liquidacion a
					 where a.baseSeguridadSocial=1 and tercero=@tercero
					 group by baseSeguridadSocial	
					end
					
		end

		-- liquida embargos
		if exists (select * from nparametrosgeneral where embargos=@concepto and empresa=@empresa )
		begin
				declare @vbaseEmbargo money	=0, @vEmbargo money=0
								
				exec 	spCalculaTipoLiquidacion @JD , @salario , @tipoLiquidacion ,@nDiasLiquidacion,  @FI , @FF ,@FIPN , @FFPN , @ND  output, @VU  output
		
				set @vbaseEmbargo = (select  sum (case when a.signo = 2 then -1* a.valor*cantidad 
					else a.valor*a.cantidad end)  from #liquidacion a
					 where a.baseembargo=1 and tercero=@tercero
					 )	
					 
				exec [liquidaEmbargos] @empresa , @tercero,@vbaseEmbargo ,@pagominimo,@ND,@vEmbargo output 						
			 	
				insert #liquidacion 
				select @tercero,@concepto,1, @vEmbargo, @signo, @baseSeguridadSocial,null,@baseEmbargo 
						
				
		end


		
		-- liquida fondo solidaridad

		if exists (select * from nparametrosgeneral where fondoSolidaridad=@concepto and empresa=@empresa )
		begin

		declare @porFS decimal(18,3)=0
		declare @valFS decimal (18,3)=0
	
		set @baseBSS= (select SUM(cantidad*valor) from #liquidacion a
		where a.baseSeguridadSocial=1 and tercero =@tercero
		group by baseSeguridadSocial)

		set  @porFS =(select porcentaje/100
			 from nConceptoRango
			where concepto=@concepto and empresa=@empresa
			and (@baseBSS>= minimo and @baseBSS < maximo ))

		set @valFS = (select valor
			 from nConceptoRango
			where concepto=@concepto and empresa=@empresa
			and (@baseBSS>= minimo and @baseBSS < maximo ))		
	
		if @porFs >0 
		begin
		insert #liquidacion
		select @tercero,@concepto,1,@baseBSS* @porFs, @signo, @baseSeguridadSocial,null,@baseEmbargo
		end
		else
		if @valFs>0
		begin
		insert #liquidacion
		select @tercero,@concepto,1,@baseBSS* @valFS, @signo, @baseSeguridadSocial,null,@baseEmbargo 
		end						
		end
		-- Auxilio transporte 
		if exists (select * from nparametrosgeneral where subsidioTransporte=@concepto and empresa=@empresa )
		begin
				if @salario < (@vSalarioMinimo*(@NSST+1))
					begin
					exec spCalculaTipoLiquidacion @JD , @vAuxilioTransporte , @tipoLiquidacion ,@nDiasLiquidacion,  @FI , @FF ,@FIPN , @FFPN , @ND  output, @VU  output
							
						insert #liquidacion
						select @tercero, @concepto, @ND, @VU,@signo,@baseSeguridadSocial,null,@baseEmbargo		
					end
		end
			
		end
		else
			if @formapago=1
			begin
			return -1
			end
			else
				if @formaPago = 2
				begin
					return -2
				end
				else
					if @formaPago = 3
					begin
						return -3
					end
					else
					begin

					exec 	spCalculaTipoLiquidacion @JD , @salario , @tipoLiquidacion ,@nDiasLiquidacion,  @FI , @FF ,@FIPN , @FFPN , @ND  output, @VU  output
					
					if @manejaPorcentaje = 0
					begin
						insert #liquidacion
						select @tercero, @concepto, @cantidad, @valor,@signo,@baseSeguridadSocial,null,@baseEmbargo
					end
					else
					begin
						insert #liquidacion
						select @tercero, @concepto, @cantidad, @VU*@porcentaje,@signo,@baseSeguridadSocial,null,@baseEmbargo
					end
					end

							  	
	fetch curMov into @tercero,@fechaIngreso,@fechaTC,@concepto,@tipoLiquidacion, @signo,@base,@porcentaje,@valor,@basePrimas,@baseCajaCompensacion,
	@baseCesantias,@baseIntereses,@basePrimas,@baseSeguridadSocial,@baseVacaciones,@controlConcepto,@controlaSaldo,@manejaRango,@ingresoGravado,
	@controlConcepto,@salario,@ValidaPor,@fijo,@manejaPorcentaje,@porcentaje,@cantidad,@prioridad,@formaPago,@baseEmbargo
	end

	close curMov
	deallocate curMov

		-- liquida prestamos


						insert #liquidacion
						select distinct empleado, concepto, 1, case when  valorcuotas> valorSaldo then valorSaldo else valorCuotas end cuotas,b.signo,0,
						valorSaldo - valorCuotas saldo,0
						from nprestamo a join nconcepto b on a.concepto=b.codigo and a.empresa=b.empresa
						where a.empresa=@empresa and valorSaldo<>0 

	
	if @empleado <> ''
	begin
	insert tmpliquidacionNomina
	select distinct tercero,
	concepto,
	cantidad,
	valor 	,
	signo,
	@mes ,
	@año ,
	@noPeriodo,
	@empresa,
	saldo
	from #liquidacion
	where tercero=@empleado
	end
	else
	begin
	insert tmpliquidacionNomina
	select distinct tercero,
	concepto,
	cantidad,
	valor 	,
	signo,
	@mes ,
	@año ,
	@noPeriodo,
	@empresa,
	saldo
	from #liquidacion
	where valor>0
	end

	select * from #liquidacion
	select * from tmpliquidacionNomina

	
	
	drop table #conceptosLiquidacion
	drop table #liquidacion