-- Batch submitted through debugger: SQLQuery6.sql|7|0|C:\Users\DESARR~1\AppData\Local\Temp\~vs1CA0.sql
CREATE proc [dbo].[spCalculaSeguridadSocialTrabajador]
@empresa int,
@mes int,
@año int,
@empleado varchar(50)
as
declare @tercero int,@salario int, @SMLV int,@SMLVD int, 
@FIPN date, @FFPN date, @fechaInicialLiquidacion date, 
@fechaFinalLiquidacion date, @valorTotal int, 
@baseSeguridadSocial bit, @noDias int, 
@cantidad float,@concepto varchar(50),
@IBC int =0,@diasIBC int,@diasVacaiones int,
@diasIncapacidad int,@diasSLN int,
@valorSLN int,@valorIncapacidad int,
@valorVacaciones int,@FIAU date,
@FFAU date,@FIMES date,@FFMES date,
@tipoLiquidacion int,@afectaAU varchar(50),
@IGE varchar(50),@IRP varchar(50),@VAC varchar(50),@ING varchar(50),@RET varchar(50),@TDE varchar(50),@TAE varchar(50)
,@TDP varchar(50),@TAP varchar(50),@VST varchar(50),@VTE varchar(50),@VSP varchar(50),@SLN varchar(50),@LMA varchar(50),@AVP varchar(50),
@diasARP int,@afectaARP bit,@afectaSLN bit, @afectaTipoNovedad varchar(50),@basico int,@pagaNomina bit,
@fechaIngreso date,@tarifaSalud float,@tarifaPension float,@tarifaCaja float=0, @tarifaSena float=0,@tarifaARP float=0,@tarifaICBF float=0, @tarifaFondoSolidaridad float=0,
@valorFondoSolidaridad int =0,@valorSalud int=0, @valorPension int=0, @valorCaja int=0, @valorARP int=0,@valorSena int=0,@valorICBF int=0,
@diasSalud int=0, @diasPension int=0, @diasCaja int=0,@IBCsalud int=0, @IBCcaja int=0, @IBCpension int=0,@IBCarp int=0,@noSPF int=0,@fila int=1,
@tipoCotizante varchar(50),@subTipoCotizante varchar(50),@isalud bit,@iPension bit,@iFondoS bit, @iCaja bit,@iArp bit,@iIcbf bit,@iSena bit,
@exoneraSalud varchar(1),@aprendiz bit,@pAprendiz float,@conceptoVacaciones varchar(50),@conceptoIncapacidad varchar(50),@centroTrabajo varchar(50),
@valorFondoSub int,@IBCsln int,@terceroSalud int,@terceroCaja int,@terceroPension int,@terceroSena int,@terceroIcbf int,@terceroArp int,
@pierdeDomingo varchar(50), @valorVacacionesCompensada float=0,@contrato int



delete  from nSeguridadSocial
where empresa=@empresa and año=@año and mes=@mes

select @SMLV=vSalarioMinimo from nParametrosAno where empresa=@empresa and ano=@año
select @noSPF=noSMLVSenaICBF from nParametrosGeneral where empresa=@empresa
set @SMLVD=round(@SMLV/30,0)
select @FIPN =fechaInicial, @FFPN= fechaFinal 
from cPeriodo where año=@año and mes=@mes and empresa=@empresa

set @FIMES= DATEADD(mm,DATEDIFF(mm,0,@FFPN),0)
set @FFMES= DATEADD(ms,-3,DATEADD(mm,0,DATEADD(mm,DATEDIFF(mm,0,@FFPN)+1,0))) 
set @FFMES = case when datepart(day,@FFMES)=31 then DATEADD(day,-1,@FFMES) else @FFMES end
--select @FIMES,@FFMES
select @conceptoVacaciones=vacaciones,@conceptoIncapacidad= incapacidades,@pierdeDomingo=PrimasExtralegales from nParametrosGeneral where empresa=@empresa



declare cursorTercero insensitive cursor for	
		select distinct codTercero,salario,tipoContizante,subTipoCotizante,salud,pension,arp,fondoSolidaridad,caja,sena,icbf,electivaProduccion,porcentajeSS,centroTrabajo, contrato
		 from vSeleccionaLiquidacionDefinitiva
		where empresa=@empresa and 
		año=@año and mes=@mes 
		and cast(codTercero as varchar) like '%' + @empleado+ '%' and anulado=0
		order by codTercero
		open cursorTercero			
		fetch cursorTercero into 	@tercero,@basico,@tipoCotizante,@subTipoCotizante,@isalud,@ipension,@iarp,@ifondoS,@icaja,@isena,@iicbf,@aprendiz,@pAprendiz,@centroTrabajo,@contrato
		while( @@fetch_status = 0 )
		begin	
			SELECT  @IBC=0,@diasIBC=0,@diasIncapacidad=0,@valorIncapacidad=0,@IGE=' ',@SLN=' ',@IRP=0,@LMA=' ',@diasSLN=0,@valorSLN=0,
			@diasVacaiones=0,@valorVacaciones=0,@VAC=' ',@ING='',@RET=' ',@TDE='',@TAE='',@TDP='', @exoneraSalud='S', @TAP='',@VSP='',@VTE='',@AVP='',
			@valorARP=0,@valorCaja=0,@valorFondoSolidaridad=0,@valorICBF=0,@valorPension=0,@valorSalud=0,@valorSLN=0,@valorSena=0,@valorFondoSub=0,@IBCsln=0
			-- Verifica si el trabajador tiene ingreso
			if exists(select * from nContratos where tercero=@tercero and fechaIngreso between @FIPN and @FFPN and empresa=@empresa)
				set @ING ='X'
			--Verifica si el trabajador tiene retiro
			if exists(select * from nContratos where tercero=@tercero and fechaRetiro between @FIPN and @FFPN and empresa=@empresa)
				set @RET ='X'
    		--Recorre total de ibac pagados
			declare cursorCaonceptos insensitive cursor for	
			select codConcepto, cantidad,valorTotal,baseSeguridadSocial,tipoliquidacion from vSeleccionaLiquidacionDefinitiva
			where empresa=@empresa and año=@año and mes=@mes and codTercero=@tercero and anulado=0
			order by codTercero
			open cursorCaonceptos			
			fetch cursorCaonceptos into @concepto,@cantidad,@valorTotal,@baseSeguridadSocial,@tipoLiquidacion
			while( @@fetch_status = 0 )
			begin	
				if  @baseSeguridadSocial=1 and @concepto<>@conceptoVacaciones and @concepto <>@conceptoIncapacidad
					set @IBC = @IBC + @valorTotal
				if  @baseSeguridadSocial=1 and @tipoLiquidacion=2
					set @diasIBC = @diasIBC + @cantidad

					--select descripcion,@cantidad,baseSeguridadSocial from nConcepto
					--where empresa=@empresa and codigo=@concepto and baseSeguridadSocial=1

			fetch cursorCaonceptos into @concepto,@cantidad,@valorTotal,@baseSeguridadSocial,@tipoLiquidacion
			end
			close cursorCaonceptos
			deallocate cursorCaonceptos
		
				select @tarifaSalud= isnull(b.pEmpleado,0)+isnull(b.pEmpleador,0),
				@tarifaPension=isnull(c.pEmpleado,0)+ isnull(c.pEmpleador,0),
				@tarifaCaja=isnull(d.pAporte,0),
				@tarifaARP=isnull(h.porcentaje,0),
				@tarifaSena=isnull(f.pAporte,0),
				@tarifaICBF=isnull(g.pAporte,0),
				@tarifaFondoSolidaridad =isnull(c.pSolidaridad,0),
				@terceroArp=e.tercero,
				@terceroSalud=b.tercero,
				@terceroCaja=d.tercero,
				@terceroSena=f.tercero,
				@terceroPension=c.tercero,
				@terceroIcbf=g.tercero
				from nContratos a
				join nCentroTrabajo h on h.codigo=a.centroTrabajo and h.empresa=a.empresa
				left join vEntidadEps b on b.codigo=a.entidadEps and b.empresa=a.empresa
				left join vEntidadPension c on c.codigo=a.entidadPension and c.empresa=a.empresa
				left join vEntidadCaja d on d.codigo=a.entidadCaja and d.empresa=a.empresa
				left join vEntidadArp e on e.codigo=a.entidadArp and e.empresa=a.empresa
				left join vEntidadSena f on f.codigo=a.entidadSena and f.empresa=a.empresa
				left join vEntidadIcbf g on g.codigo=a.entidadIcbf and g.empresa=a.empresa
				where a.tercero=@tercero and a.empresa=@empresa
				and a.id = @contrato
			 --Recorre Vacaciones del tercero
		   set @valorVacacionesCompensada = isnull((select sum(valorTotal)
		 from vSeleccionaLiquidacionDefinitiva
		where empresa=@empresa and año=@año and mes=@mes  and codconcepto=@conceptoVacaciones
		and codtercero=@tercero and anulado=0 and tipoConcepto=2),0)

			 declare cursorVacaciones insensitive cursor for	
				SELECT a.fechaSalida,dateadd(day,-1,a.fechaRetorno), a.diasPagados, a.valorTotal,a.pagaNomina
				FROM  vSeleccionaVacaciones a
				WHERE  (a.anulado = 0) and (a.fechaSalida between @FIPN and @FFPN or a.fechaRetorno between @FIPN and @FFPN or (fechaSalida<@FIPN and fechaRetorno>@FFPN )) 
				and a.tipo <> 2 and a.empresa=@empresa	and a.empleado=@tercero and concepto=@conceptoVacaciones
			open cursorVacaciones			
			fetch cursorVacaciones into @fiau, @ffau,@noDias,@valorTotal,@pagaNomina
			while( @@fetch_status = 0 )
			begin	
					IF @FIAU < @FIPN AND @FFAU BETWEEN @FIPN AND @FFPN
					begin
						SET @diasVacaiones = @diasVacaiones + (@noDias - datediff(day, @FIAU, @FIPN))
						set @valorVacaciones=@valorVacaciones + ((@valorTotal/@noDias)*(@noDias - datediff(day, @FIAU, @FIPN)))
					end

					IF @FFAU > @FFPN AND @FIAU BETWEEN @FIPN AND @FFPN
					begin
						SET @diasVacaiones = @diasVacaiones + (@noDias - datediff(day, @FFPN, @FFAU))
						set @valorVacaciones=@valorVacaciones + ((@valorTotal/@noDias)*(@noDias - datediff(day, @FFPN, @FFAU)))
					end

					IF (@FFAU BETWEEN @FIPN AND @FFPN) AND (@FIAU BETWEEN @FIPN AND @FFPN)
					begin
						SET @diasVacaiones = @diasVacaiones + @noDias
						set @valorVacaciones=@valorVacaciones + ((@valorTotal/@noDias)*@noDias)
					end

					IF (@FFAU > @FFPN) AND (@FIAU < @FIPN )
					begin
						SET @diasVacaiones = 30
						set @valorVacaciones=@valorVacaciones + ((@valorTotal/@noDias)*30)
					end

					set @VAC='X'
					set @diasIBC = @diasIBC +@noDias

			fetch cursorVacaciones into @fiau, @ffau,@noDias,@valorTotal,@pagaNomina
			end
			close cursorVacaciones
			deallocate cursorVacaciones


			--Determina que el numero de dias no sea mayo que 30
			if (@diasIBC >30)
			 set @diasIBC=30
			 

		 --Recorre todas las incapacidades que tiene el tercero
		 
			declare cursorIncapacidad insensitive cursor for	
			SELECT a.fechaInicial,a.fechaFinal, a.noDias, a.valor, b.afectaNovedadSS,b.afectaARL,b.afectaSeguridadSocial
			FROM  dbo.nIncapacidad AS a INNER JOIN
             dbo.nTipoIncapacidad AS b ON b.codigo = a.tipoIncapacidad AND b.empresa = a.empresa
			WHERE  (a.anulado = 0) and (a.fechaInicial between @FIPN and @FFPN or a.fechaFinal between @FIPN and @FFPN or (fechaInicial<@FIPN and fechaFinal>@FFPN )) 
			and a.empresa=@empresa	and a.tercero=@tercero
			open cursorIncapacidad			
			fetch cursorIncapacidad into @fiau, @ffau,@noDias,@valorTotal,@afectaTipoNovedad,@afectaARP,@afectaSLN
			while( @@fetch_status = 0 )
			begin	
					IF @FIAU < @FIPN AND @FFAU BETWEEN @FIPN AND @FFPN and @afectaARP=1
					begin
						SET @diasIncapacidad = @diasIncapacidad + (@noDias - datediff(day, @FIAU, @FIPN))
						set @valorIncapacidad=@valorIncapacidad + ((@valorTotal/@noDias)*(@noDias - datediff(day, @FIAU, @FIPN)))
					end

					IF @FFAU > @FFPN AND @FIAU BETWEEN @FIPN AND @FFPN and @afectaARP=1
					begin
						SET @diasIncapacidad = @diasIncapacidad + (@noDias - datediff(day, @FFPN, @FFAU))
						set @valorIncapacidad=@valorIncapacidad + ((@valorTotal/@noDias)* (@noDias - datediff(day, @FFPN, @FFAU)))
					end

					IF (@FFAU BETWEEN @FIPN AND @FFPN) AND (@FIAU BETWEEN @FIPN AND @FFPN) and @afectaARP=1
					begin
						SET @diasIncapacidad = @diasIncapacidad + @noDias
						set @valorIncapacidad=@valorIncapacidad + ((@valorTotal/@noDias)*@noDias)
					end

					IF (@FFAU > @FFPN) AND (@FIAU < @FIPN ) and @afectaARP=1
					begin
						SET @diasIncapacidad = 30
						set @valorIncapacidad=@valorIncapacidad + ((@valorTotal/@noDias)*30)
					end

					if @afectaTipoNovedad ='IGE'
						set @IGE='X'
					if @afectaTipoNovedad ='SLN'
					begin
						set @SLN='X'
						set @diasSLN=@diasSLN+@noDias
					end
					if @afectaTipoNovedad ='LMA'
						set @LMA='X'
						
					if @afectaTipoNovedad ='IRP' and @afectaARP=1
					BEGIN
						IF @FIAU < @FIPN AND @FFAU BETWEEN @FIPN AND @FFPN and @afectaARP=1
							SET @IRP = @IRP + (@noDias - datediff(day, @FIAU, @FIPN))

						IF @FFAU > @FFPN AND @FIAU BETWEEN @FIPN AND @FFPN and @afectaARP=1
							SET @IRP = @IRP + (@noDias - datediff(day, @FFPN, @FFAU))

						IF (@FFAU BETWEEN @FIPN AND @FFPN) AND (@FIAU BETWEEN @FIPN AND @FFPN) and @afectaARP=1
							SET @IRP = @IRP + @noDias

						IF (@FFAU > @FFPN) AND (@FIAU < @FIPN ) and @afectaARP=1
							SET @IRP = 30
					END

			fetch cursorIncapacidad into @fiau, @ffau,@noDias,@valorTotal,@afectaTipoNovedad,@afectaARP,@afectaSLN
			end
			close cursorIncapacidad
			deallocate cursorIncapacidad
			
			set @IBC = @IBC + @valorVacaciones + @valorIncapacidad
			
			if (@diasIncapacidad >30)
				set @diasIncapacidad=30
			if @diasSLN+@diasIBC>30
				set @diasIBC = @diasIBC + (30 - (@diasSLN+@diasIBC))
			if @diasSLN+@IRP>30
				set @IRP = @IRP + (30 - (@diasSLN+@IRP))
			set @diasARP = @diasIBC - (CASE WHEN (@diasIncapacidad+@diasSLN)>30 THEN @diasIncapacidad + (30-(@diasIncapacidad+@diasSLN)) ELSE @diasIncapacidad END ) -@diasVacaiones
			set @IBCarp = @IBC -@valorIncapacidad -@valorVacaciones
			select @diasSalud=@diasIBC,@diasPension=@diasIBC,@IBCpension=@IBC,@IBCsalud=@IBC
		
		
			if @aprendiz = 1
			begin
				set @exoneraSalud='N'
				set @tarifaSalud = @pAprendiz
			end
				select  @diasCaja=@diasIBC, @IBCcaja=@IBC,@valorCaja=@valorSalud

			if @IBCSalud/case when @diasSalud= 0 then 1 else @diasSalud end  <= @SMLVD
				select @IBCSalud=IBC, @valorSalud= case when @aprendiz=1 then saludSena else salud end  from nTablaSmlvRedondeo where año=@año and dia=@diasSalud
			else
			begin
				set @IBCsalud =round(@IBCsalud,-3)
				set @valorSalud= round(@IBCsalud*(@tarifaSalud/100),-2)
			end

			if @IBCpension/case when @diasPension=0 then 1 else @diasPension end <= @SMLVD
				select @IBCpension=IBC, @valorPension=pension from nTablaSmlvRedondeo where año=@año and dia=@diasPension
			else
			begin
				set @IBCpension=ROUND(@ibcpension,-3)
				set @valorPension= round(@IBCpension*(@tarifaPension/100),-2)
			end

			if @IBCarp/case when @diasARP=0 then 1 else @diasARP end <= @SMLVD
				select @IBCarp=IBC,@valorARP=valor from nTablaSmlvRedondeoARP where año=@año and dia=@diasARP and riesgo=@centroTrabajo
			else
			begin
				set @IBCarp=ROUND(@IBCarp,-3)
				set @valorARP= round(@IBCarp*(@tarifaARP/100),-2)
			end

			if @IBCcaja/case when @diasCaja=0 then 1 else @diasCaja end < @SMLVD
				select @IBCcaja=ibc, @valorCaja=CCF from nTablaSmlvRedondeo where año=@año and dia=@diasCaja
			else
			begin
				set @IBCcaja=ROUND(@IBCcaja + @valorVacacionesCompensada,-3)
				set @valorCaja= round(@IBCcaja*(@tarifaCaja/100),-2)
			end

			if @basico >= (@SMLV*4)
			begin
				set @valorFondoSolidaridad= round(((@IBCpension*(@tarifaFondoSolidaridad/100))/2),-2)
				set @valorFondoSub= round(((@IBCpension*(@tarifaFondoSolidaridad/100))/2),-2)
			end

			if @basico >= (@SMLV*@noSPF) or @IBC>= (@SMLV*@noSPF) 
			begin
				set @valorICBF= round(@IBC*(@tarifaICBF/100),-2)
				set @valorSena= round(@IBC*(@tarifaSena/100),-2)
				set @exoneraSalud='N'
			end

			
			if @isalud=0
				select @IBCsalud=0,@diasSalud=0,@valorSalud=0
			if @iPension=0
				select @IBCpension=0,@diasPension=0,@valorPension=0
			if @iArp=0
				select @IBCarp=0,@diasARP=0,@valorARP=0
			if @iCaja=0
				select @IBCcaja=0,@diasCaja=0,@valorCaja=0
			if @iSena=0
				select @valorSena=0
			if @iIcbf=0
				select @valorICBF=0

			if @diasArp=0
				set @tarifaARP=0
			if @diasPension=0
				set @tarifaPension=0
			if @diasCaja=0
				set @tarifaCaja=0

			if @diasSLN>0 or isnull((select sum(cantidad) from vSeleccionaLiquidacionDefinitiva where empresa=@empresa and año=@año and mes=@mes and codtercero=@tercero and codconcepto=@pierdeDomingo),0)>0
			begin
				set @diasSLN = @diasSLN + isnull((select sum(cantidad) from vSeleccionaLiquidacionDefinitiva where empresa=@empresa and año=@año and mes=@mes and codtercero=@tercero and codconcepto=@pierdeDomingo),0)
				if @basico=@SMLV
					select @IBCsln=IBC from nTablaSmlvRedondeo where año=@año and dia=@diasSLN
				else
					set @ibcSLN = round((@basico/30) * @diasSLN,-3)
					
					
				insert nSeguridadSocial
				select @empresa,@año,@mes,@fila, a.id,a.codigo,@basico,
				case when @isalud=0 then 0 else @IBCsln end ,
				case when @iPension=0 then 0 else @IBCsln end, 
				case when @iArp=0 then 0 else @IBCsln end ,
				case when @iCaja=0 then 0 else @IBCsln end,
				@diasSLN,@diasSLN,@diasSLN,@diasSLN,0,0,0,0,0,0,
				0,0,0,0,0,0,0,	' ',' ' ,' ' ,' ',' ', ' ' , ' ' , ' ' ,' ' , @SLN ,' ' ,' ' ,' ', ' ' ,' ' , 0 ,@exoneraSalud,@terceroSalud,@terceroPension,@terceroCaja,@terceroArp,@terceroSena,@terceroIcbf
				from cTercero a
				where a.id=@tercero and a.empresa=@empresa and @diasSLN>0
				set @fila=@fila+1
			end
			insert nSeguridadSocial
			select  @empresa,@año,@mes,@fila, a.id,a.codigo,@basico,@IBCsalud,@IBCpension,
			@IBCarp,@IBCcaja,@diasSalud,@diasPension,@diasARP, @diasCaja,
			@tarifaSalud,@tarifaPension,@tarifaARP,@tarifaCaja,@tarifaFondoSolidaridad,
			@valorSalud,@valorPension,@valorFondoSolidaridad,@valorFondoSub,
			@valorARP,@valorCaja,@valorSena,@valorICBF,
			@ING ,@RET,@TDE,@TAE,@TDP,@TAP,@VSP,@VTE,'X',' ', @IGE,@LMA,@VAC,@AVP,' ',@IRP,@exoneraSalud,@terceroSalud,
			@terceroPension,@terceroCaja,@terceroArp,@terceroSena,@terceroIcbf
			from cTercero a
			where a.id=@tercero and a.empresa=@empresa
			set @fila=@fila+1

		fetch cursorTercero into @tercero,@basico,@tipoCotizante,@subTipoCotizante,@isalud,@ipension,@iarp,@ifondoS,@icaja,@isena,@iicbf,@aprendiz,@pAprendiz,@centroTrabajo,@contrato
		end
		close cursorTercero
		deallocate cursorTercero

--		select aa.pSalud, aa.idTercero Codigo_Empleado, aa.codigoTercero Id_Identificacion,
--bb.descripcion nombreTercero,apellido1 , apellido2 , nombre1 , nombre2,
--c.razonSocial razonSocial_Pension, aa.dPension Dias_Cotizados_Pension,aa.IBCpension  IBC_Pension, 
--aa.valorPension  valor_Pension, aa.valorFondo + aa.valorFondoSub  valor_FondoSolidaridad,
--b.razonSocial razonSocial_EPS, aa.dSalud Dias_Cotizados_Salud,
--aa.IBCsalud IBC_Salud,aa.valorSalud valor_Salud, e.razonSocial  razonSocial_Arp, aa.IBCarp IBCarl,
--aa.valorArp valor_ARP, aa.dArp Dias_Arp, aa.dCaja Dias_Cotizados_Caja, aa.IBCcaja IBC_Caja,aa.valorCaja  valor_Caja,
--aa.valorSena valor_Sena, aa.valorIcbf  valor_icbf,ING,RET,TDE,TAE,TDP,TAP,VSP,VTE,VST,SLN,IGE,LMA,VAC,AVP,VCT,IRP
--from  nSeguridadSocial aa
--		join cTercero bb on bb.id=aa.idTercero and bb.empresa=@empresa
--		join nContratos a on a.tercero=aa.idTercero and a.empresa=@empresa
--		join nCentroTrabajo h on h.codigo=a.centroTrabajo and h.empresa=a.empresa
--		left join vEntidadEps b on b.codigo=a.entidadEps and b.empresa=a.empresa
--		left join vEntidadPension c on c.codigo=a.entidadPension and c.empresa=a.empresa
--		left join vEntidadCaja d on d.codigo=a.entidadCaja and d.empresa=a.empresa
--		left join vEntidadArp e on e.codigo=a.entidadArp and e.empresa=a.empresa
--		left join vEntidadSena f on f.codigo=a.entidadSena and f.empresa=a.empresa
--		left join vEntidadIcbf g on g.codigo=a.entidadIcbf and g.empresa=a.empresa
--		where aa.empresa=@empresa and aa.año=@año and aa.mes=@mes
--		order by cast(rtrim(ltrim(aa.codigoTercero)) as int)