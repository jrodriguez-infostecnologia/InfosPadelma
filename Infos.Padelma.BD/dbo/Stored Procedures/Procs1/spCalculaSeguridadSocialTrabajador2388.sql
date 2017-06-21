-- Batch submitted through debugger: SQLQuery6.sql|7|0|C:\Users\DESARR~1\AppData\Local\Temp\~vs1CA0.sql
CREATE proc [dbo].[spCalculaSeguridadSocialTrabajador2388]
@empresa int,
@mes int,
@año int,
@empleado varchar(50)
as
declare @tercero int,@salario int, @SMLV int,@SMLVD int, 
@FIPN date, @FFPN date, @fechaInicialLiquidacion date, 
@fechaFinalLiquidacion date, @valorTotal int, @baseSeguridadSocial bit, @noDias int, 
@cantidad float,@concepto varchar(50),@IBC int =0,@diasIBC int,@diasVacaiones int,
@diasIncapacidad int,@diasSLN int,@valorSLN int,@valorIncapacidad int,
@valorVacaciones int,@FIAU date,@FFAU date,@FIMES date,@FFMES date,@tipoLiquidacion int,@afectaAU varchar(50),
@IGE varchar(50),@IRP varchar(50),@VAC varchar(50),@ING varchar(50),@RET varchar(50),@TDE varchar(50),@TAE varchar(50)
,@TDP varchar(50),@TAP varchar(50),@VST varchar(50),@VTE varchar(50),@VSP varchar(50),@SLN varchar(50),@LMA varchar(50),@AVP varchar(50),
@diasARP int,@afectaARP bit,@afectaSLN bit, @afectaTipoNovedad varchar(50),@basico int,@pagaNomina bit,
@tarifaSalud float,@tarifaPension float,@tarifaCaja float=0, @tarifaSena float=0,@tarifaARP float=0,@tarifaICBF float=0, @tarifaFondoSolidaridad float=0,
@valorFondoSolidaridad int =0,@valorSalud int=0, @valorPension int=0, @valorCaja int=0, @valorARP int=0,@valorSena int=0,@valorICBF int=0,
@diasSalud int=0, @diasPension int=0, @diasCaja int=0,@IBCsalud int=0, @IBCcaja int=0, @IBCpension int=0,@IBCarp int=0,@noSPF int=0,@fila int=1,
@tipoCotizante varchar(50),@subTipoCotizante varchar(50),@isalud bit,@iPension bit,@iFondoS bit, @iCaja bit,@iArp bit,@iIcbf bit,@iSena bit,
@exoneraSalud varchar(1),@aprendiz bit,@pAprendiz float,@conceptoVacaciones varchar(50),@conceptoIncapacidad varchar(50),@centroTrabajo varchar(50),
@valorFondoSub int,@IBCsln int,@terceroSalud int,@terceroCaja int,@terceroPension int,@terceroSena int,@terceroIcbf int,@terceroArp int,
@pierdeDomingo varchar(50), @valorVacacionesCompensada float=0,@contrato int,
@fechaIngreso date,@fechaRetiro date,@fiSLN date,@ffSLN date,@fiVAC date,@ffVAC date,@fiIGE date,@ffIGE date,@fechaVSP date,@fiLMA date,@ffLMA date,
@fiVCT date,@ffVCT date,@fiIRL date,@ffIRL date,@salarioIntegral bit,@diasVAC int =0, @IBCvacaciones int,@diasTotalAusentismo int =0,
@jonadaLaboral int,@sumaPrestacionSocial bit,@conceptoPermiso varchar(50)

delete  from nSeguridadSocialPila
where empresa=@empresa and año=@año and mes=@mes

select @SMLV=vSalarioMinimo from nParametrosAno where empresa=@empresa and ano=@año
select @noSPF=noSMLVSenaICBF,@jonadaLaboral= jornadaDiaria from nParametrosGeneral where empresa=@empresa
set @SMLVD=round(@SMLV/30,0)

select @FIPN =fechaInicial, @FFPN= fechaFinal 
from cPeriodo where año=@año and mes=@mes and empresa=@empresa

set @FIMES= DATEADD(mm,DATEDIFF(mm,0,@FFPN),0)
set @FFMES= DATEADD(ms,-3,DATEADD(mm,0,DATEADD(mm,DATEDIFF(mm,0,@FFPN)+1,0))) 
set @FFMES = case when datepart(day,@FFMES)=31 then DATEADD(day,-1,@FFMES) else @FFMES end

select @conceptoVacaciones=vacaciones,@conceptoIncapacidad= incapacidades,@pierdeDomingo=PrimasExtralegales,@conceptoPermiso= licRemunerado from nParametrosGeneral where empresa=@empresa

declare cursorTercero insensitive cursor for	
		select distinct codTercero,salario,tipoContizante,subTipoCotizante,salud,pension,arp,fondoSolidaridad,caja,sena,icbf,electivaProduccion,porcentajeSS,centroTrabajo, contrato
		 from vSeleccionaLiquidacionDefinitiva
		where empresa=@empresa and 
		año=@año and mes=@mes 
		and cast(codTercero as varchar) like '%' + @empleado+ '%' and anulado=0 --AND tipo='LQN'
		order by codTercero
		open cursorTercero			
		fetch cursorTercero into 	@tercero,@basico,@tipoCotizante,@subTipoCotizante,@isalud,@ipension,@iarp,@ifondoS,@icaja,@isena,@iicbf,@aprendiz,@pAprendiz,@centroTrabajo,@contrato
		while( @@fetch_status = 0 )
		begin	
			SELECT  @IBC=0,@diasIBC=0,@diasIncapacidad=0,@valorIncapacidad=0,@IGE=' ',@SLN=' ',@IRP=0,@LMA=' ',@diasSLN=0,@valorSLN=0,
			@diasVacaiones=0,@valorVacaciones=0,@VAC=' ',@ING='',@RET=' ',@TDE='',@TAE='',@TDP='', @exoneraSalud='S', @TAP='',@VSP='',@VTE='',@AVP='',@VST='X',
			@valorARP=0,@valorCaja=0,@valorFondoSolidaridad=0,@valorICBF=0,@valorPension=0,@valorSalud=0,@valorSLN=0,@valorSena=0,@valorFondoSub=0,@IBCsln=0,@diasTotalAusentismo=0
			-- Verifica si el trabajador tiene ingreso
			if exists(select * from nContratos where tercero=@tercero and fechaIngreso between @FIPN and @FFPN and empresa=@empresa)
			begin
				set @ING ='X'
				set @fechaIngreso =  (select fechaIngreso from nContratos where tercero=@tercero and fechaIngreso between @FIPN and @FFPN and empresa=@empresa and id=@contrato)
			end
			else
			begin
				set @ING =''
				set @fechaIngreso = null
			end

			--Verifica si el trabajador tiene retiro
			if exists(select * from nContratos where tercero=@tercero and fechaRetiro between @FIPN and @FFPN and empresa=@empresa)
			begin
				set @RET ='X'
				set @fechaRetiro = (select fechaRetiro from nContratos where tercero=@tercero and fechaRetiro between @FIPN and @FFPN and empresa=@empresa and id=@contrato)
			end
			else
			begin
				set @RET =''
				set @fechaRetiro =  null
			end
				
    		--Recorre total de ibc pagados
			
			declare cursorCaonceptos insensitive cursor for	
			select codConcepto, cantidad,valorTotal,baseSeguridadSocial,sumaPrestacionSocial from vSeleccionaLiquidacionDefinitiva
			where empresa=@empresa and año=@año and mes=@mes and codTercero=@tercero and anulado=0
			order by codTercero
			open cursorCaonceptos			
			fetch cursorCaonceptos into @concepto,@cantidad,@valorTotal,@baseSeguridadSocial,@sumaPrestacionSocial
			while( @@fetch_status = 0 )
			begin	
				if  @baseSeguridadSocial=1 and @concepto not in ( @conceptoIncapacidad,@conceptoPermiso,@conceptoVacaciones)
					set @IBC = @IBC + @valorTotal

				if @sumaPrestacionSocial = 1 and @concepto not in ( @conceptoIncapacidad,@conceptoPermiso,@conceptoVacaciones)
					set @diasIBC = @diasIBC + @cantidad

			fetch cursorCaonceptos into @concepto,@cantidad,@valorTotal,@baseSeguridadSocial,@sumaPrestacionSocial
			end
			close cursorCaonceptos
			deallocate cursorCaonceptos
		
				select @tarifaSalud= isnull(b.pEmpleado,0)+isnull(b.pEmpleador,0),
				@tarifaPension=isnull(c.pEmpleado,0)+ isnull(c.pEmpleador,0),
				@tarifaCaja=isnull(d.pAporte,0),
				@tarifaARP=isnull(h.porcentaje,0),
				@tarifaSena=isnull( f.pAporte,0),
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
				where a.tercero=@tercero and a.empresa=@empresa	and a.id = @contrato
				if @IBC < @SMLV*@noSPF
				select @tarifaSena=0,@tarifaICBF=0
			 --Recorre Vacaciones del tercero
		   set @valorVacacionesCompensada = isnull((select sum(valorTotal) from vSeleccionaLiquidacionDefinitiva
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

			declare @ffVaca date =@ffau, @fiVaca date = @fiau

					IF @FIAU < @FIPN AND @FFAU BETWEEN @FIPN AND @FFPN
					begin
						SET @diasVacaiones = @diasVacaiones + (@noDias - datediff(day, @FIAU, @FIPN))
						set @valorVacaciones=@valorVacaciones + ((@valorTotal/@noDias)*(@noDias - datediff(day, @FIAU, @FIPN)))
						set @fiVaca = @FIPN
					end

					IF @FFAU > @FFPN AND @FIAU BETWEEN @FIPN AND @FFPN
					begin
						SET @diasVacaiones = @diasVacaiones + (@noDias - datediff(day, @FFPN, @FFAU))
						set @valorVacaciones=@valorVacaciones + ((@valorTotal/@noDias)*(@noDias - datediff(day, @FFPN, @FFAU)))
						set @ffVaca = @FFPN
					end

					IF (@FFAU BETWEEN @FIPN AND @FFPN) AND (@FIAU BETWEEN @FIPN AND @FFPN)
					begin
						SET @diasVacaiones = @diasVacaiones + @noDias
						set @valorVacaciones=@valorVacaciones + ((@valorTotal/@noDias)*@noDias)
					end

					IF (@FFAU > @FFPN) AND (@FIAU < @FIPN )
					begin
						SET @diasVacaiones = 30
						set @valorVacaciones = @valorVacaciones + ((@valorTotal/@noDias)*30)
					end
					
					set @VAC='X'
					set @diasVAC =  @diasVacaiones
					set @IBCvacaciones = @valorVacaciones
					set @diasIBC =@diasIBC + @diasVAC

					select @diasSalud=@diasVAC,@diasPension=@diasVAC,@IBCpension=@IBCvacaciones,@IBCsalud=@IBCvacaciones
					select  @diasCaja=@diasVAC, @IBCcaja=@IBCvacaciones,@valorCaja=@valorSalud
					
					if @IBCSalud/case when @diasVacaiones= 0 then 1 else @diasVacaiones end  <= @SMLVD
						select @IBCSalud=@IBCvacaciones, @valorSalud = case when @aprendiz=1 then saludSena else salud end  from nTablaSmlvRedondeo where año=@año and dia=@diasVAC
					else
					begin
						set @IBCsalud =round(@IBCvacaciones,-3)
						set @valorSalud= CEILING((@IBCvacaciones*(@tarifaSalud/100))/100.0) * 100
					end
					if @IBCpension/case when @diasVacaiones=0 then 1 else @diasVacaiones end <= @SMLVD
						select @IBCpension=IBC, @valorPension=pension from nTablaSmlvRedondeo where año=@año and dia=@diasVAC
					else
					begin
						set @IBCpension=ROUND(@ibcpension,-3)
						set @valorPension= CEILING((@IBCpension*(@tarifaPension/100))/100.0) * 100
					end
					if @IBCcaja/case when @diasCaja=0 then 1 else @diasCaja end < @SMLVD
						select @IBCcaja=ibc, @valorCaja=CCF from nTablaSmlvRedondeo where año=@año and dia=@diasVAC
					else
					begin
						set @IBCcaja=ROUND(@IBCcaja + @valorVacacionesCompensada,-3)
						set @valorCaja= CEILING((@IBCcaja*(@tarifaCaja/100))/100.0) * 100
					end
					if @basico >= (@SMLV*4)
					begin
						set @valorFondoSolidaridad= CEILING((((@IBCpension*(@tarifaFondoSolidaridad/100))/2))/100.0) * 100
						set @valorFondoSub= CEILING((((@IBCpension*(@tarifaFondoSolidaridad/100))/2))/100.0) * 100
					end
					if @basico >= (@SMLV*@noSPF) or @IBC>= (@SMLV*@noSPF) 
						begin
						set @valorICBF= CEILING((@IBC*(@tarifaICBF/100))/100.0) * 100
						set @valorSena= CEILING((@IBC*(@tarifaSena/100))/100.0) * 100
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
					
					set @IBCvacaciones = round(@valorVacaciones,-3)

					set @diasVacaiones = @diasVAC

					insert nSeguridadSocialPila
					select a.empresa ,@año ,@mes ,@fila registro,a.tercero ,b.codigo ,upper(b.apellido1) ,UPPER(b.apellido2),UPPER(b.nombre1),UPPER(b.nombre2),b.departamento,b.ciudad,a.tipoContizante,a.subTipoCotizante,
					@diasVAC * @jonadaLaboral horasLaboradas,'' extranjero,'' RecidenteExterior,NULL fechaRadExterior,'' ING,NULL fechaIngreso,'' RET,NULL fechaRetiro,'' TDE,'' TAE,''TDP,''TAP,''VSP,NULL fechaVSP,@VST,'' SLN,null fiSLN ,null ffSLN,
					'' IGE, null fiIGE,null ffIGE,'' LMA,null fiLMA,null ffLMA,'X' VAC, @fivaca fiVAC, @ffvaca ffVAC,'' AVP,'' VCT,NULL fiVCT,NULL ffVCT,0 IRL,NULL fiIRL,NULL ffIRL,'' correciones ,a.salario, 
					case when a.salarioIntegral=1 then 'X' else '' end salarioIntegral ,c.tercero terceroPension ,@diasVAC dPension,@IBCvacaciones IBCpension ,@tarifaPension pPension,@valorPension valorPension,'0' indicadorAltoRiesgo,
					0 cotizacionVoluntariaAfiliado,0 cotizacionVoluntariaEmpleador, @valorFondoSolidaridad valorFondo, @valorFondoSub valorFondoSub,@tarifaFondoSolidaridad pFondo,0 valorRetenido,@valorPension+@valorFondoSolidaridad+@valorFondoSub totalPension,
					'' AFPdestino,i.tercero terceroSalud ,@diasVAC dSalud,@IBCvacaciones IBCsalud,@tarifaSalud pSalud,@valorSalud valorSalud,0 valorUPC,'' noAutorizacionEG ,0 valorIncapacidad,'' noAutorizacionLMA,0 valorLMA,
					'' saludDestino,@terceroArp,@diasVAC dArl,@IBCvacaciones IBCarl,0 pArl,'0' claseARL,'' centroTrabajo,0 valorArl,@diasVAC dCaja,d.tercero terceroCaja ,@IBCvacaciones IBCcaja,@tarifaCaja pCaja,@valorCaja valorCaja,0 IBCCajaOtros,
					@tarifaSena pSena,@valorSena valorSena,f.tercero terceroSena,@tarifaICBF pICBF, @valorICBF valorICBF,@terceroIcbf terceroIcbf,0 pESAP,0 valorESAP,0 pMEN,0 valorMEN,@exoneraSalud,'' tipoIDcotizanteUPC,''noIDcotizanteUPC,@contrato,b.tipoDocumento
					 from nContratos a
					join cTercero b on b.id=a.tercero and b.empresa=a.empresa
					join nCentroTrabajo h on h.codigo=a.centroTrabajo and h.empresa=a.empresa
					left join vEntidadEps i on i.codigo=a.entidadEps and i.empresa=a.empresa
					left join vEntidadPension c on c.codigo=a.entidadPension and c.empresa=a.empresa
					left join vEntidadCaja d on d.codigo=a.entidadCaja and d.empresa=a.empresa
					left join vEntidadArp e on e.codigo=a.entidadArp and e.empresa=a.empresa
					left join vEntidadSena f on f.codigo=a.entidadSena and f.empresa=a.empresa
					left join vEntidadIcbf g on g.codigo=a.entidadIcbf and g.empresa=a.empresa
					where a.tercero=@tercero and a.id=@contrato and a.empresa=@empresa
					set @fila=@fila+1
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
					declare @finicialInca date=@fiau, @ffinalInca date=@ffau 
					select  @diasSLN=0,@diasVAC=0,@diasIncapacidad=0,@valorARP=0,@valorCaja=0,@valorFondoSub=0, @valorFondoSolidaridad=0,
					@valorICBF=0,@valorPension=0,@valorSalud=0,@valorSena=0,@IBCvacaciones=0,@valorIncapacidad=0

					select @tarifaSalud= isnull(b.pEmpleado,0)+isnull(b.pEmpleador,0),
					@tarifaPension=isnull(c.pEmpleado,0)+ isnull(c.pEmpleador,0),
					@tarifaCaja=isnull(d.pAporte,0),
					@tarifaARP=isnull(h.porcentaje,0),
					@tarifaSena=isnull( f.pAporte,0),
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
					where a.tercero=@tercero and a.empresa=@empresa	and a.id = @contrato
					if @IBC < @SMLV*@noSPF
					select @tarifaSena=0,@tarifaICBF=0

					if @aprendiz = 1
					begin
						set @exoneraSalud='N'
						set @tarifaSalud = @pAprendiz
						set @VST=''
					end

					IF @FIAU < @FIPN AND @FFAU BETWEEN @FIPN AND @FFPN and @afectaARP=1
					begin
						SET @diasIncapacidad = @diasIncapacidad + (@noDias - datediff(day, @FIAU, @FIPN))
						set @valorIncapacidad=@valorIncapacidad + ((@valorTotal/@noDias)*(@noDias - datediff(day, @FIAU, @FIPN)))
						set @finicialInca=@FIPN
					end

					IF @FFAU > @FFPN AND @FIAU BETWEEN @FIPN AND @FFPN and @afectaARP=1
					begin
						SET @diasIncapacidad = @diasIncapacidad + (@noDias - datediff(day, @FFPN, @FFAU))
						set @valorIncapacidad=@valorIncapacidad + ((@valorTotal/@noDias)* (@noDias - datediff(day, @FFPN, @FFAU)))
						set @ffinalInca=@FFPN
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

					set @diasVAC =  @diasIncapacidad
					set @IBCvacaciones = @valorIncapacidad

					select @diasSalud=@diasVAC,@diasPension=@diasVAC,@IBCpension=@IBCvacaciones,@IBCsalud=@IBCvacaciones
					select  @diasCaja=@diasVAC, @IBCcaja=@IBCvacaciones,@valorCaja=@valorSalud

					if @IBCSalud/case when @diasVacaiones= 0 then 1 else @diasVacaiones end  <= @SMLVD
						select @IBCSalud=@IBCvacaciones, @valorSalud = case when @aprendiz=1 then saludSena else salud end  from nTablaSmlvRedondeo where año=@año and dia=@diasVAC
					else
					begin
						set @IBCsalud =round(@IBCvacaciones,-3)
						set @valorSalud= CEILING((@IBCvacaciones*(@tarifaSalud/100))/100.0) * 100
					end
					if @IBCpension/case when @diasVacaiones=0 then 1 else @diasVacaiones end <= @SMLVD
						select @IBCpension=IBC, @valorPension=pension from nTablaSmlvRedondeo where año=@año and dia=@diasVAC
					else
					begin
						set @IBCpension=ROUND(@ibcpension,-3)
						set @valorPension= CEILING((@IBCpension*(@tarifaPension/100))/100.0) * 100
					end
					if @IBCcaja/case when @diasVAC=0 then 1 else @diasVAC end < @SMLVD
						select @IBCcaja=ibc, @valorCaja=CCF from nTablaSmlvRedondeo where año=@año and dia=@diasVAC
					else
					begin
						set @IBCcaja=ROUND(@IBCcaja + @valorVacacionesCompensada,-3)
						set @valorCaja= CEILING((@IBCcaja*(@tarifaCaja/100))/100.0) * 100
					end
					if @basico >= (@SMLV*4)
					begin
						set @valorFondoSolidaridad= CEILING((((@IBCpension*(@tarifaFondoSolidaridad/100))/2))/100.0) * 100
						set @valorFondoSub= CEILING((((@IBCpension*(@tarifaFondoSolidaridad/100))/2))/100.0) * 100
					end
					if @basico >= (@SMLV*@noSPF) or @IBC>= (@SMLV*@noSPF) 
						begin
						set @valorICBF= CEILING((@IBC*(@tarifaICBF/100))/100.0) * 100
						set @valorSena= CEILING((@IBC*(@tarifaSena/100))/100.0) * 100
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
					
					set @diasTotalAusentismo = @diasTotalAusentismo + @diasIncapacidad
					
					if @afectaTipoNovedad ='IGE'
					begin
						set @IGE='X'

						if  @valorIncapacidad=0
						begin
							if @basico=@SMLV 
								select @IBCvacaciones=IBC from nTablaSmlvRedondeo where año=@año and dia=@diasVAC
							else
								set @IBCvacaciones = round((@basico/30) * @diasVAC,-3)
						end
							set @IBCvacaciones = round(@IBCvacaciones,-3)
						insert nSeguridadSocialPila
						select a.empresa ,@año ,@mes ,@fila registro,a.tercero ,b.codigo ,upper(b.apellido1) ,UPPER(b.apellido2),UPPER(b.nombre1),UPPER(b.nombre2),b.departamento,b.ciudad,a.tipoContizante,a.subTipoCotizante,
						@diasVAC * @jonadaLaboral horasLaboradas,'' extranjero,'' RecidenteExterior,NULL fechaRadExterior,'' ING,NULL fechaIngreso,'' RET,NULL fechaRetiro,'' TDE,'' TAE,''TDP,''TAP,''VSP,NULL fechaVSP,'X' VST,'' SLN,null fiSLN ,null ffSLN,
						@IGE, @finicialInca  fiIGE,@ffinalInca ffIGE,'' LMA,null fiLMA,null ffLMA,'' VAC, null fiVAC, null ffVAC,'' AVP,'' VCT,NULL fiVCT,NULL ffVCT,0 IRL,NULL fiIRL,NULL ffIRL,'' correciones ,a.salario, 
						case when a.salarioIntegral=1 then 'X' else '' end salarioIntegral ,c.tercero terceroPension ,@diasVAC dPension,@IBCvacaciones IBCpension ,@tarifaPension pPension,@valorPension valorPension,'0' indicadorAltoRiesgo,
						0 cotizacionVoluntariaAfiliado,0 cotizacionVoluntariaEmpleador, @valorFondoSolidaridad valorFondo, @valorFondoSub valorFondoSub,@tarifaFondoSolidaridad pFondo,0 valorRetenido,@valorPension+@valorFondoSolidaridad+@valorFondoSub totalPension,
						'' AFPdestino,i.tercero terceroSalud ,@diasVAC dSalud,@IBCvacaciones IBCsalud,@tarifaSalud pSalud,@valorSalud valorSalud,0 valorUPC,'' noAutorizacionEG ,0 valorIncapacidad,'' noAutorizacionLMA,0 valorLMA,
						'' saludDestino,@terceroArp,@diasVAC dArl,@IBCvacaciones IBCarl,0 pArl,'0' claseARL,'' centroTrabajo,0 valorArl,@diasVAC dCaja,d.tercero terceroCaja ,@IBCvacaciones IBCcaja,@tarifaCaja pCaja,@valorCaja valorCaja,0 IBCCajaOtros,
						@tarifaSena pSena,@valorSena valorSena,f.tercero terceroSena,@tarifaICBF pICBF, @valorICBF valorICBF,@terceroIcbf terceroIcbf,0 pESAP,0 valorESAP,0 pMEN,0 valorMEN,@exoneraSalud,'' tipoIDcotizanteUPC,''noIDcotizanteUPC,@contrato,b.tipoDocumento
						from nContratos a
						join cTercero b on b.id=a.tercero and b.empresa=a.empresa
						join nCentroTrabajo h on h.codigo=a.centroTrabajo and h.empresa=a.empresa
						left join vEntidadEps i on i.codigo=a.entidadEps and i.empresa=a.empresa
						left join vEntidadPension c on c.codigo=a.entidadPension and c.empresa=a.empresa
						left join vEntidadCaja d on d.codigo=a.entidadCaja and d.empresa=a.empresa
						left join vEntidadArp e on e.codigo=a.entidadArp and e.empresa=a.empresa
						left join vEntidadSena f on f.codigo=a.entidadSena and f.empresa=a.empresa
						left join vEntidadIcbf g on g.codigo=a.entidadIcbf and g.empresa=a.empresa
						where a.tercero=@tercero and a.id=@contrato and a.empresa=@empresa
						set @fila=@fila+1
					end
					if @afectaTipoNovedad ='VAC'
					begin
						if  @valorIncapacidad=0
						begin
							if @basico=@SMLV 
								select @IBCvacaciones=IBC from nTablaSmlvRedondeo where año=@año and dia=@diasVAC
							else
								set @IBCvacaciones = round((@basico/30) * @diasSLN,-3)
						end
							set @IBCvacaciones = round(@IBCvacaciones,-3)

						insert nSeguridadSocialPila
						select a.empresa ,@año ,@mes ,@fila registro,a.tercero ,b.codigo ,upper(b.apellido1) ,UPPER(b.apellido2),UPPER(b.nombre1),UPPER(b.nombre2),b.departamento,b.ciudad,a.tipoContizante,a.subTipoCotizante,
						@diasVAC * @jonadaLaboral horasLaboradas,'' extranjero,'' RecidenteExterior,NULL fechaRadExterior,'' ING,NULL fechaIngreso,'' RET,NULL fechaRetiro,'' TDE,'' TAE,''TDP,''TAP,''VSP,NULL fechaVSP,'X' VST,'' SLN,null fiSLN ,null ffSLN,
						'', null  fiIGE,null ffIGE,'' LMA,null fiLMA,null ffLMA,'L' VAC, @finicialInca fiVAC, @ffinalInca ffVAC,'' AVP,'' VCT,NULL fiVCT,NULL ffVCT,0 IRL,NULL fiIRL,NULL ffIRL,'' correciones ,a.salario, 
						case when a.salarioIntegral=1 then 'X' else '' end salarioIntegral ,c.tercero terceroPension ,@diasVAC dPension,@IBCvacaciones IBCpension ,@tarifaPension pPension,@valorPension valorPension,'0' indicadorAltoRiesgo,
						0 cotizacionVoluntariaAfiliado,0 cotizacionVoluntariaEmpleador, @valorFondoSolidaridad valorFondo, @valorFondoSub valorFondoSub,@tarifaFondoSolidaridad pFondo,0 valorRetenido,@valorPension+@valorFondoSolidaridad+@valorFondoSub totalPension,
						'' AFPdestino,i.tercero terceroSalud ,@diasVAC dSalud,@IBCvacaciones IBCsalud,@tarifaSalud pSalud,@valorSalud valorSalud,0 valorUPC,'' noAutorizacionEG ,0 valorIncapacidad,'' noAutorizacionLMA,0 valorLMA,
						'' saludDestino,@terceroArp,@diasVAC dArl,@IBCvacaciones IBCarl,0 pArl,'0' claseARL,'' centroTrabajo,0 valorArl,@diasVAC dCaja,d.tercero terceroCaja ,@IBCvacaciones IBCcaja,@tarifaCaja pCaja,@valorCaja valorCaja,0 IBCCajaOtros,
						@tarifaSena pSena,@valorSena valorSena,f.tercero terceroSena,@tarifaICBF pICBF, @valorICBF valorICBF,@terceroIcbf terceroIcbf,0 pESAP,0 valorESAP,0 pMEN,0 valorMEN,@exoneraSalud,'' tipoIDcotizanteUPC,''noIDcotizanteUPC,@contrato,b.tipoDocumento
						from nContratos a
						join cTercero b on b.id=a.tercero and b.empresa=a.empresa
						join nCentroTrabajo h on h.codigo=a.centroTrabajo and h.empresa=a.empresa
						left join vEntidadEps i on i.codigo=a.entidadEps and i.empresa=a.empresa
						left join vEntidadPension c on c.codigo=a.entidadPension and c.empresa=a.empresa
						left join vEntidadCaja d on d.codigo=a.entidadCaja and d.empresa=a.empresa
						left join vEntidadArp e on e.codigo=a.entidadArp and e.empresa=a.empresa
						left join vEntidadSena f on f.codigo=a.entidadSena and f.empresa=a.empresa
						left join vEntidadIcbf g on g.codigo=a.entidadIcbf and g.empresa=a.empresa
						where a.tercero=@tercero and a.id=@contrato and a.empresa=@empresa
						set @fila=@fila+1
					end
					if @afectaTipoNovedad ='SLN' AND @aprendiz=0
					begin
						set @diasTotalAusentismo = @diasTotalAusentismo + @noDias
						set @SLN='X'
						set @diasSLN =  @noDias
						set @diasVAC = @diasSLN 
						
						if @basico = @SMLV
							select @IBCvacaciones=IBC from nTablaSmlvRedondeo where año=@año and dia=@diasVAC
						else
							set @IBCvacaciones = round((@basico/30) * @diasVAC,-3)

						set @IBCvacaciones = round(@IBCvacaciones,-3)

						insert nSeguridadSocialPila
						select a.empresa ,@año ,@mes ,@fila registro,a.tercero ,b.codigo ,upper(b.apellido1) ,UPPER(b.apellido2),UPPER(b.nombre1),UPPER(b.nombre2),b.departamento,b.ciudad,a.tipoContizante,a.subTipoCotizante,
						@diasVAC * @jonadaLaboral horasLaboradas,'' extranjero,'' RecidenteExterior,NULL fechaRadExterior,'' ING,NULL fechaIngreso,'' RET,NULL fechaRetiro,'' TDE,'' TAE,''TDP,''TAP,''VSP,NULL fechaVSP,'' VST,
						@SLN,@finicialInca  fiSLN,@ffinalInca ffSLN,'' IGE, null  fiIGE,null ffIGE,'' LMA,null fiLMA,null ffLMA,'' VAC, null fiVAC, null ffVAC,'' AVP,'' VCT,NULL fiVCT,NULL ffVCT,0 IRL,NULL fiIRL,NULL ffIRL,'' correciones ,a.salario, 
						case when a.salarioIntegral=1 then 'X' else '' end salarioIntegral ,c.tercero terceroPension ,@diasVAC dPension,@IBCvacaciones IBCpension ,0 pPension,0 valorPension,'0' indicadorAltoRiesgo,
						0 cotizacionVoluntariaAfiliado,0 cotizacionVoluntariaEmpleador, @valorFondoSolidaridad valorFondo, @valorFondoSub valorFondoSub,@tarifaFondoSolidaridad pFondo,0 valorRetenido,0 totalPension,
						'' AFPdestino,i.tercero terceroSalud ,@diasVAC dSalud,@IBCvacaciones IBCsalud,0 pSalud,0 valorSalud,0 valorUPC,'' noAutorizacionEG ,0 valorIncapacidad,'' noAutorizacionLMA,0 valorLMA,
						'' saludDestino,@terceroArp,@diasVAC dArl,@IBCvacaciones IBCarl,0 pArl,'0' claseARL,'' centroTrabajo,0 valorArl,@diasVAC dCaja,d.tercero terceroCaja ,@IBCvacaciones IBCcaja,@tarifaCaja pCaja,@valorCaja valorCaja,0 IBCCajaOtros,
						@tarifaSena pSena,@valorSena valorSena,f.tercero terceroSena,@tarifaICBF pICBF, @valorICBF valorICBF,@terceroIcbf terceroIcbf,0 pESAP,0 valorESAP,0 pMEN,0 valorMEN,@exoneraSalud,'' tipoIDcotizanteUPC,''noIDcotizanteUPC,@contrato,b.tipoDocumento
						from nContratos a
						join cTercero b on b.id=a.tercero and b.empresa=a.empresa
						join nCentroTrabajo h on h.codigo=a.centroTrabajo and h.empresa=a.empresa
						left join vEntidadEps i on i.codigo=a.entidadEps and i.empresa=a.empresa
						left join vEntidadPension c on c.codigo=a.entidadPension and c.empresa=a.empresa
						left join vEntidadCaja d on d.codigo=a.entidadCaja and d.empresa=a.empresa
						left join vEntidadArp e on e.codigo=a.entidadArp and e.empresa=a.empresa
						left join vEntidadSena f on f.codigo=a.entidadSena and f.empresa=a.empresa
						left join vEntidadIcbf g on g.codigo=a.entidadIcbf and g.empresa=a.empresa
						where a.tercero=@tercero and a.id=@contrato and a.empresa=@empresa
						set @fila=@fila+1
					end
					if @afectaTipoNovedad ='LMA'
					begin
						set @LMA='X'
						if  @valorIncapacidad=0
						begin
							if @basico=@SMLV 
								select @IBCvacaciones=IBC from nTablaSmlvRedondeo where año=@año and dia=@diasVAC
							else
								set @IBCvacaciones = round((@basico/30) * @diasSLN,-3)
						end
							set @IBCvacaciones = round(@IBCvacaciones,-3)
						insert nSeguridadSocialPila
						select a.empresa ,@año ,@mes ,@fila registro,a.tercero ,b.codigo ,upper(b.apellido1) ,UPPER(b.apellido2),UPPER(b.nombre1),UPPER(b.nombre2),b.departamento,b.ciudad,a.tipoContizante,a.subTipoCotizante,
						@diasVAC * @jonadaLaboral horasLaboradas,'' extranjero,'' RecidenteExterior,NULL fechaRadExterior,'' ING,NULL fechaIngreso,'' RET,NULL fechaRetiro,'' TDE,'' TAE,''TDP,''TAP,''VSP,NULL fechaVSP,'X' VST,'' SLN,null fiSLN ,null ffSLN,
						'' IGE, null  fiIGE,null ffIGE,@LMA,@finicialInca fiLMA,@ffinalInca ffLMA,'' VAC, null fiVAC, null ffVAC,'' AVP,'' VCT,NULL fiVCT,NULL ffVCT,0 IRL,NULL fiIRL,NULL ffIRL,'' correciones ,a.salario, 
						case when a.salarioIntegral=1 then 'X' else '' end salarioIntegral ,c.tercero terceroPension ,@diasVAC dPension,@IBCvacaciones IBCpension ,@tarifaPension pPension,@valorPension valorPension,'0' indicadorAltoRiesgo,
						0 cotizacionVoluntariaAfiliado,0 cotizacionVoluntariaEmpleador, @valorFondoSolidaridad valorFondo, @valorFondoSub valorFondoSub,@tarifaFondoSolidaridad pFondo,0 valorRetenido,@valorPension+@valorFondoSolidaridad+@valorFondoSub totalPension,
						'' AFPdestino,i.tercero terceroSalud ,@diasVAC dSalud,@IBCvacaciones IBCsalud,@tarifaSalud pSalud,@valorSalud valorSalud,0 valorUPC,'' noAutorizacionEG ,0 valorIncapacidad,'' noAutorizacionLMA,0 valorLMA,
						'' saludDestino,@terceroArp,@diasVAC dArl,@IBCvacaciones IBCarl,0 pArl,'0' claseARL,'' centroTrabajo,0 valorArl,@diasVAC dCaja,d.tercero terceroCaja ,@IBCvacaciones IBCcaja,@tarifaCaja pCaja,@valorCaja valorCaja,0 IBCCajaOtros,
						@tarifaSena pSena,@valorSena valorSena,f.tercero terceroSena,@tarifaICBF pICBF, @valorICBF valorICBF,@terceroIcbf terceroIcbf,0 pESAP,0 valorESAP,0 pMEN,0 valorMEN,@exoneraSalud,'' tipoIDcotizanteUPC,''noIDcotizanteUPC,@contrato,b.tipoDocumento
						from nContratos a
						join cTercero b on b.id=a.tercero and b.empresa=a.empresa
						join nCentroTrabajo h on h.codigo=a.centroTrabajo and h.empresa=a.empresa
						left join vEntidadEps i on i.codigo=a.entidadEps and i.empresa=a.empresa
						left join vEntidadPension c on c.codigo=a.entidadPension and c.empresa=a.empresa
						left join vEntidadCaja d on d.codigo=a.entidadCaja and d.empresa=a.empresa
						left join vEntidadArp e on e.codigo=a.entidadArp and e.empresa=a.empresa
						left join vEntidadSena f on f.codigo=a.entidadSena and f.empresa=a.empresa
						left join vEntidadIcbf g on g.codigo=a.entidadIcbf and g.empresa=a.empresa
						where a.tercero=@tercero and a.id=@contrato and a.empresa=@empresa
						set @fila=@fila+1
					end
					if @afectaTipoNovedad ='IRP' and @afectaARP=1
					BEGIN
						IF @FIAU < @FIPN AND @FFAU BETWEEN @FIPN AND @FFPN and @afectaARP=1
						begin
							SET @IRP = @IRP + (@noDias - datediff(day, @FIAU, @FIPN))
							set @finicialInca=@FIPN
						end

						IF @FFAU > @FFPN AND @FIAU BETWEEN @FIPN AND @FFPN and @afectaARP=1
						begin
							SET @IRP = @IRP + (@noDias - datediff(day, @FFPN, @FFAU))
							set @ffinalInca=@FIPN
						end

						IF (@FFAU BETWEEN @FIPN AND @FFPN) AND (@FIAU BETWEEN @FIPN AND @FFPN) and @afectaARP=1
							SET @IRP = @IRP + @noDias

						IF (@FFAU > @FFPN) AND (@FIAU < @FIPN ) and @afectaARP=1
							SET @IRP = 30

							set @IBCvacaciones = round(@IBCvacaciones,-3)
						insert nSeguridadSocialPila
						select a.empresa ,@año ,@mes ,@fila registro,a.tercero ,b.codigo ,upper(b.apellido1) ,UPPER(b.apellido2),UPPER(b.nombre1),UPPER(b.nombre2),b.departamento,b.ciudad,a.tipoContizante,a.subTipoCotizante,
						@diasVAC * @jonadaLaboral horasLaboradas,'' extranjero,'' RecidenteExterior,NULL fechaRadExterior,'' ING,NULL fechaIngreso,'' RET,NULL fechaRetiro,'' TDE,'' TAE,''TDP,''TAP,''VSP,NULL fechaVSP,'X' VST,'' SLN,null fiSLN ,null ffSLN,
						'' IGE, null  fiIGE,null ffIGE,'' LMA,null fiLMA,null ffLMA,'' VAC, null fiVAC, null ffVAC,'' AVP,'' VCT,NULL fiVCT,NULL ffVCT,@IRP IRL,@finicialInca fiIRL,@ffinalInca ffIRL,'' correciones ,a.salario, 
						case when a.salarioIntegral=1 then 'X' else '' end salarioIntegral ,c.tercero terceroPension ,@diasVAC dPension,@IBCvacaciones IBCpension ,@tarifaPension pPension,@valorPension valorPension,'0' indicadorAltoRiesgo,
						0 cotizacionVoluntariaAfiliado,0 cotizacionVoluntariaEmpleador, @valorFondoSolidaridad valorFondo, @valorFondoSub valorFondoSub,@tarifaFondoSolidaridad pFondo,0 valorRetenido,@valorPension+@valorFondoSolidaridad+@valorFondoSub totalPension,
						'' AFPdestino,i.tercero terceroSalud ,@diasVAC dSalud,@IBCvacaciones IBCsalud,@tarifaSalud pSalud,@valorSalud valorSalud,0 valorUPC,'' noAutorizacionEG ,0 valorIncapacidad,'' noAutorizacionLMA,0 valorLMA,
						'' saludDestino,@terceroArp,@diasVAC dArl,@IBCvacaciones IBCarl,0 pArl,'0' claseARL,'' centroTrabajo,0 valorArl,@diasVAC dCaja,d.tercero terceroCaja ,@IBCvacaciones IBCcaja,@tarifaCaja pCaja,@valorCaja valorCaja,0 IBCCajaOtros,
						@tarifaSena pSena,@valorSena valorSena,f.tercero terceroSena,@tarifaICBF pICBF, @valorICBF valorICBF,@terceroIcbf terceroIcbf,0 pESAP,0 valorESAP,0 pMEN,0 valorMEN,@exoneraSalud,'' tipoIDcotizanteUPC,''noIDcotizanteUPC,@contrato,b.tipoDocumento
						from nContratos a
						join cTercero b on b.id=a.tercero and b.empresa=a.empresa
						join nCentroTrabajo h on h.codigo=a.centroTrabajo and h.empresa=a.empresa
						left join vEntidadEps i on i.codigo=a.entidadEps and i.empresa=a.empresa
						left join vEntidadPension c on c.codigo=a.entidadPension and c.empresa=a.empresa
						left join vEntidadCaja d on d.codigo=a.entidadCaja and d.empresa=a.empresa
						left join vEntidadArp e on e.codigo=a.entidadArp and e.empresa=a.empresa
						left join vEntidadSena f on f.codigo=a.entidadSena and f.empresa=a.empresa
						left join vEntidadIcbf g on g.codigo=a.entidadIcbf and g.empresa=a.empresa
						where a.tercero=@tercero and a.id=@contrato and a.empresa=@empresa
						set @fila=@fila+1
					END

			fetch cursorIncapacidad into @fiau, @ffau,@noDias,@valorTotal,@afectaTipoNovedad,@afectaARP,@afectaSLN
			end
			close cursorIncapacidad
			deallocate cursorIncapacidad

				select @tarifaSalud= isnull(b.pEmpleado,0)+isnull(b.pEmpleador,0),
					@tarifaPension=isnull(c.pEmpleado,0)+ isnull(c.pEmpleador,0),
					@tarifaCaja=isnull(d.pAporte,0),
					@tarifaARP=isnull(h.porcentaje,0),
					@tarifaSena=isnull( f.pAporte,0),
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
					where a.tercero=@tercero and a.empresa=@empresa	and a.id = @contrato
					if @IBC < @SMLV*@noSPF
					select @tarifaSena=0,@tarifaICBF=0

			set @IBC = @IBC --+ isnull(@valorVacaciones,0) + isnull(@valorIncapacidad,0)
			set @diasSLN = @diasSLN +  isnull((select sum(cantidad) from vSeleccionaLiquidacionDefinitiva where empresa=@empresa and año=@año and mes=@mes and codtercero=@tercero and codconcepto=@pierdeDomingo and anulado=0),0)
			set @diasTotalAusentismo = @diasTotalAusentismo +  isnull((select sum(cantidad) from vSeleccionaLiquidacionDefinitiva where empresa=@empresa and año=@año and mes=@mes and codtercero=@tercero and codconcepto=@pierdeDomingo and anulado=0),0)
			
			if (@diasIncapacidad >30)
				set @diasIncapacidad=30
			if @diasTotalAusentismo+@diasIBC+ @diasVacaiones>30
				set @diasIBC = @diasIBC + (30 - (@diasTotalAusentismo+@diasIBC+@diasVacaiones))
			if @diasSLN + @IRP > 30
				set @IRP = @IRP + (30 - (@diasSLN + @IRP))
			set @diasARP = @diasIBC -- (CASE WHEN (@diasIncapacidad)>30 THEN @diasIncapacidad + (30-(@diasIncapacidad)) ELSE @diasIncapacidad END ) 
			set @IBCarp = @IBC --- @valorIncapacidad 
			select @diasSalud=@diasIBC,@diasPension=@diasIBC,@IBCpension=@IBC,@IBCsalud=@IBC
		
			if @aprendiz = 1
			begin
				set @exoneraSalud='N'
				set @tarifaSalud = @pAprendiz
				set @VST=''
			end
			select  @diasCaja=@diasIBC, @IBCcaja=@IBC,@valorCaja=@valorSalud

			if @IBCSalud/case when @diasSalud= 0 then 1 else @diasSalud end  <= @SMLVD
				select @IBCSalud=IBC, @valorSalud= case when @aprendiz=1 then saludSena else salud end  from nTablaSmlvRedondeo where año=@año and dia=@diasSalud
			else
			begin
				set @IBCsalud =round(@IBCsalud,-3)
				set @valorSalud= CEILING((@IBCsalud*(@tarifaSalud/100))/100.0) * 100
			end
			if @IBCpension/case when @diasPension=0 then 1 else @diasPension end <= @SMLVD
				select @IBCpension=IBC, @valorPension=pension from nTablaSmlvRedondeo where año=@año and dia=@diasPension
			else
			begin
				set @IBCpension=ROUND(@ibcpension,-3)
				set @valorPension= CEILING((@IBCpension*(@tarifaPension/100))/100.0) * 100
			end
			if @IBCarp/case when @diasARP=0 then 1 else @diasARP end <= @SMLVD
				select @IBCarp=IBC,@valorARP=valor from nTablaSmlvRedondeoARP where año=@año and dia=@diasARP and riesgo=convert(int,@centroTrabajo)
			else
			begin
				set @IBCarp=ROUND(@IBCarp,-3)
				set @valorARP= CEILING((@IBCarp*(@tarifaARP/100))/100.0) * 100
			end
			if @IBCcaja/case when @diasCaja=0 then 1 else @diasCaja end < @SMLVD
				select @IBCcaja=ibc, @valorCaja=CCF from nTablaSmlvRedondeo where año=@año and dia=@diasCaja
			else
			begin
				set @IBCcaja=ROUND(@IBCcaja + @valorVacacionesCompensada,-3)
				set @valorCaja= CEILING((@IBCcaja*(@tarifaCaja/100))/100.0) * 100
			end
			if @basico >= (@SMLV*4)
			begin
				set @valorFondoSolidaridad= CEILING((((@IBCpension*(@tarifaFondoSolidaridad/100))/2))/100.0) * 100
				set @valorFondoSub= CEILING((((@IBCpension*(@tarifaFondoSolidaridad/100))/2))/100.0) * 100
			end
			if @basico >= (@SMLV*@noSPF) or @IBC>= (@SMLV*@noSPF) 
			begin
				set @valorICBF= CEILING((@IBC*(@tarifaICBF/100))/100.0) * 100
				set @valorSena= CEILING((@IBC*(@tarifaSena/100))/100.0) * 100
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

			if isnull((select sum(cantidad) from vSeleccionaLiquidacionDefinitiva where empresa=@empresa and año=@año and mes=@mes and codtercero=@tercero and codconcepto=@pierdeDomingo and anulado=0),0)>0
			begin
				set @diasSLN = isnull((select sum(cantidad) from vSeleccionaLiquidacionDefinitiva where empresa=@empresa and año=@año and mes=@mes and codtercero=@tercero and codconcepto=@pierdeDomingo and anulado=0),0)
				
				if @basico=@SMLV
					select @IBCsln=IBC from nTablaSmlvRedondeo where año=@año and dia=1
				else
					set @ibcSLN = round((@basico/30),-3)
				
						insert nSeguridadSocialPila
						select a.empresa ,@año ,@mes ,@fila + ROW_NUMBER() OVER(ORDER BY a.empresa ASC) ,a.codTercero ,b.codigo ,UPPER(b.apellido1) ,UPPER(b.apellido2),UPPER(b.nombre1),UPPER(b.nombre2),b.departamento,b.ciudad,a.tipoContizante,a.subTipoCotizante,
						a.cantidad * @jonadaLaboral horasLaboradas,'' extranjero,'' RecidenteExterior,NULL fechaRadExterior,'' ING,NULL fechaIngreso,'' RET,NULL fechaRetiro,'' TDE,'' TAE,''TDP,''TAP,''VSP,NULL fechaVSP,'' VST,
						'X' SLN,a.fechaConcepto  fiSLN,a.fechaConcepto ffSLN,'' IGE, null  fiIGE,null ffIGE,'' LMA,null fiLMA,null ffLMA,'' VAC, null fiVAC, null ffVAC,'' AVP,'' VCT,NULL fiVCT,NULL ffVCT,0 IRL,NULL fiIRL,NULL ffIRL,'' correciones ,a.salario, 
						'' salarioIntegral ,@terceroPension ,a.cantidad dPension,@IBCsln IBCpension ,0, 0 valorPension,'0' indicadorAltoRiesgo,
						0 cotizacionVoluntariaAfiliado,0 cotizacionVoluntariaEmpleador, 0 valorFondo, 0 valorFondoSub,0 pFondo,0 valorRetenido,0 totalPension,
						'' AFPdestino,@terceroSalud ,a.cantidad dSalud, @IBCsln  IBCsalud,0 pSalud,0 valorSalud,0 valorUPC,'' noAutorizacionEG ,0 valorIncapacidad,'' noAutorizacionLMA,0 valorLMA,
						''saludDestino,@terceroArp,a.cantidad dArl, @IBCsln,0 pArl,'0' claseARL,'' centroTrabajo,0 valorArl,a.cantidad dCaja,@terceroCaja ,@IBCsln IBCcaja,0 pCaja,0 valorCaja,0 IBCCajaOtros,
						0 pSena,0 valorSena, @terceroSena,0 pICBF, 0 valorICBF,@terceroIcbf,0 pESAP,0 valorESAP,0 pMEN,0 valorMEN,@exoneraSalud,'' tipoIDcotizanteUPC,''noIDcotizanteUPC,@contrato,b.tipoDocumento
						from vSeleccionaLiquidacionDefinitiva a
						join cTercero b on b.id=a.codTercero and b.empresa=a.empresa
						where a.empresa=@empresa and año=@año and mes=@mes and codtercero=@tercero and codconcepto=@pierdeDomingo
						and a.anulado=0
						set @fila=@fila+@diasSLN+1
			end
		if @diasSalud>0
		begin
			insert nSeguridadSocialPila
			select a.empresa ,@año ,@mes ,@fila registro,a.tercero ,b.codigo ,UPPER(b.apellido1) ,UPPER(b.apellido2),UPPER(b.nombre1),UPPER(b.nombre2),b.departamento,b.ciudad,a.tipoContizante,a.subTipoCotizante,
			@diasSalud * @jonadaLaboral horasLaboradas,'' extranjero,'' RecidenteExterior,NULL fechaRadExterior, @ING,@fechaIngreso,@RET,@fechaRetiro,'' TDE,'' TAE,''TDP,''TAP,''VSP,NULL fechaVSP,'X' VST,'' SLN,null fiSLN ,null ffSLN,
			'' IGE, null fiIGE,null ffIGE,'' LMA,null fiLMA,null ffLMA,'' VAC, null fiVAC, null ffVAC,'' AVP,'' VCT,NULL fiVCT,NULL ffVCT,0 IRL,NULL fiIRL,NULL ffIRL,'' correciones ,@basico, 
			case when a.salarioIntegral=1 then 'X' else '' end salarioIntegral ,c.tercero terceroPension ,@diasPension dPension,@IBCpension IBCpension ,@tarifaPension pPension,@valorPension valorPension,'0' indicadorAltoRiesgo,
			0 cotizacionVoluntariaAfiliado,0 cotizacionVoluntariaEmpleador, @valorFondoSolidaridad valorFondo, @valorFondoSub valorFondoSub,@tarifaFondoSolidaridad pFondo,0 valorRetenido,@valorPension+@valorFondoSolidaridad+@valorFondoSub totalPension,
			'' AFPdestino,i.tercero terceroSalud ,@diasSalud dSalud,@IBCsalud,@tarifaSalud pSalud,@valorSalud valorSalud,0 valorUPC,'' noAutorizacionEG ,0 valorIncapacidad,'' noAutorizacionLMA,0 valorLMA,
			'' saludDestino,@terceroArp,@diasARP,@IBCarp,@tarifaARP,'0' claseARL,'' centroTrabajo,@valorARP,@diasCaja dCaja,d.tercero terceroCaja ,@IBCcaja IBCcaja,@tarifaCaja pCaja,@valorCaja valorCaja,0 IBCCajaOtros,
			@tarifaSena pSena,@valorSena valorSena,f.tercero terceroSena,@tarifaICBF pICBF, @valorICBF valorICBF,@terceroIcbf terceroIcbf,0 pESAP,0 valorESAP,0 pMEN,0 valorMEN,@exoneraSalud,'' tipoIDcotizanteUPC,''noIDcotizanteUPC,@contrato,b.tipoDocumento
			from nContratos a
			join cTercero b on b.id=a.tercero and b.empresa=a.empresa
					join nCentroTrabajo h on h.codigo=a.centroTrabajo and h.empresa=a.empresa
					left join vEntidadEps i on i.codigo=a.entidadEps and i.empresa=a.empresa
					left join vEntidadPension c on c.codigo=a.entidadPension and c.empresa=a.empresa
					left join vEntidadCaja d on d.codigo=a.entidadCaja and d.empresa=a.empresa
					left join vEntidadArp e on e.codigo=a.entidadArp and e.empresa=a.empresa
					left join vEntidadSena f on f.codigo=a.entidadSena and f.empresa=a.empresa
					left join vEntidadIcbf g on g.codigo=a.entidadIcbf and g.empresa=a.empresa
			where a.tercero=@tercero and a.id=@contrato and a.empresa=@empresa
			set @fila=@fila+1
		end

	
	
		fetch cursorTercero into @tercero,@basico,@tipoCotizante,@subTipoCotizante,@isalud,@ipension,@iarp,@ifondoS,@icaja,@isena,@iicbf,@aprendiz,@pAprendiz,@centroTrabajo,@contrato
		end
		close cursorTercero
		deallocate cursorTercero

			update nSeguridadSocialPila set
		IBCsalud=@SMLVD,
		IBCpension=@SMLVD,
		IBCcaja=@SMLVD,
		IBCarl=@SMLVD
		from nSeguridadSocialPila a
		join nTablaSmlvRedondeo b on b.año=a.año and b.dia=a.dSalud
		join nContratos c on c.id=a.contrato and c.empresa=a.empresa
		where  a.empresa=@empresa
		and SLN='X' and dSalud=1 and c.salario=@SMLV