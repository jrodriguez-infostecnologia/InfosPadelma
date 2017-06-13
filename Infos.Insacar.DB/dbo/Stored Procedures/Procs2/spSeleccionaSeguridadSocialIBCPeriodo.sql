CREATE proc [dbo].[spSeleccionaSeguridadSocialIBCPeriodo]
@empresa int,
@mes int,
@año int
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
@exoneraSalud varchar(1),@aprendiz bit,@pAprendiz float,@conceptoVacaciones varchar(50),@conceptoIncapacidad varchar(50)


create table #IBC
(
empresa int,
año int,
mes int,
tercero int,
ibc int,
concepto varchar(50)
)

select @FIPN =fechaInicial, @FFPN= fechaFinal 
from cPeriodo where año=@año and mes=@mes and empresa=@empresa

select @conceptoVacaciones=vacaciones,@conceptoIncapacidad= incapacidades from nParametrosGeneral where empresa=@empresa

declare cursorTercero insensitive cursor for	
		select distinct codtercero,salario,tipoContizante,subTipoCotizante,salud,pension,arp,
		fondoSolidaridad,caja,sena,icbf,electivaProduccion,porcentajeSS from vSeleccionaLiquidacionDefinitiva
		where empresa=@empresa and año=@año and mes=@mes and anulado=0 
		--and tercero =237
		order by codtercero
		open cursorTercero			
		fetch cursorTercero into 	@tercero,@basico,@tipoCotizante,@subTipoCotizante,@isalud,@ipension,@iarp,@ifondoS,@icaja,@isena,@iicbf,@aprendiz,@pAprendiz
		while( @@fetch_status = 0 )
		begin	


			SELECT  @IBC=0,@diasIBC=0,@diasIncapacidad=0,@valorIncapacidad=0,@IGE=' ',@SLN=' ',@IRP=0,@LMA=' ',@diasSLN=0,@valorSLN=0,
			@diasVacaiones=0,@valorVacaciones=0,@VAC=' ',@ING='',@RET=' ',@TDE='',@TAE='',@TDP='', @exoneraSalud='S', @TAP='',@VSP='',@VTE='',@AVP='',
			@valorARP=0,@valorCaja=0,@valorFondoSolidaridad=0,@valorICBF=0,@valorPension=0,@valorSalud=0,@valorSLN=0,@valorSena=0
			--Recorre total de ibac pagados
			declare @conceptoAnterior varchar(50)=''
			declare cursorCaonceptos insensitive cursor for	
			select  codconcepto, 0,valorTotal,baseSeguridadSocial,tipoliquidacion from vSeleccionaLiquidacionDefinitiva
			where empresa=@empresa and año=@año and mes=@mes and codtercero=@tercero and anulado=0 
			--group by concepto,baseSeguridadSocial,tipoliquidacion 
			open cursorCaonceptos			
			fetch cursorCaonceptos into @concepto,@cantidad,@valorTotal,@baseSeguridadSocial,@tipoLiquidacion
			while( @@fetch_status = 0 )
			begin	

				if  @baseSeguridadSocial=1 and @concepto<>@conceptoVacaciones and @concepto <>@conceptoIncapacidad
				begin
			
					set @IBC = @IBC + @valorTotal
					insert #ibc
					select @empresa, @año,@mes, @tercero,@valorTotal, @concepto
				end
				if  @baseSeguridadSocial=1 and @tipoLiquidacion=2
				begin
				
					set @diasIBC = @diasIBC + @cantidad
				end


				
				
				
			fetch cursorCaonceptos into @concepto,@cantidad,@valorTotal,@baseSeguridadSocial,@tipoLiquidacion
			end
			close cursorCaonceptos
			deallocate cursorCaonceptos
		
			

			 declare cursorVacaciones insensitive cursor for	
				SELECT a.fechaSalida,dateadd(day,-1,a.fechaRetorno), a.diasPagados, a.valorTotal,a.pagaNomina
			 FROM  vSeleccionaVacaciones a
			 WHERE  (a.anulado = 0) and (a.fechaSalida between @FIPN and @FFPN or a.fechaRetorno between @FIPN and @FFPN or (fechaSalida<@FIPN and fechaRetorno>@FFPN )) 
			 and a.tipo <> 2 and a.empresa=@empresa	and a.empleado=@tercero and concepto=@conceptoVacaciones
			open cursorVacaciones			
			fetch cursorVacaciones into @fiau, @ffau,@noDias,@valorTotal,@pagaNomina
			while( @@fetch_status = 0 )
			begin	
			--select  @fiau, @ffau,@noDias,@valorTotal
					IF @FIAU < @FIPN AND @FFAU BETWEEN @FIPN AND @FFPN
					begin
						SET @diasVacaiones = @diasVacaiones + (@noDias - datediff(day, @FIAU, @FIPN))
						set @valorVacaciones=@valorVacaciones + ((@valorTotal/@noDias)*(@noDias - datediff(day, @FIAU, @FIPN)))
					end

					IF @FFAU > @FFPN AND @FIAU BETWEEN @FIPN AND @FFPN
					begin
					
						SET @diasVacaiones = @diasVacaiones + (@noDias - datediff(day, @FFPN, @FFAU))
						set @valorVacaciones=@valorVacaciones + ((@valorTotal/@noDias)*(@noDias - datediff(day, @FFPN, @FFAU)))
						--select @diasVacaiones,@noDias,@valorTotal
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
					

			fetch cursorVacaciones into @fiau, @ffau,@noDias,@valorTotal,@pagaNomina
			end
			close cursorVacaciones
			deallocate cursorVacaciones
					
					insert #ibc
					select @empresa, @año,@mes, @tercero,@valorVacaciones, @conceptoVacaciones

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
						set @valorIncapacidad=@valorIncapacidad + ((@valorTotal/@noDias)* (@noDias - datediff(day, @FIAU, @FIPN)))
					end

					IF @FFAU > @FFPN AND @FIAU BETWEEN @FIPN AND @FFPN and @afectaARP=1
					begin
						SET @diasIncapacidad = @diasIncapacidad + (@noDias - datediff(day, @FFPN, @FFAU))
						set @valorIncapacidad=@valorIncapacidad + ((@valorTotal/@noDias)*(@noDias - datediff(day, @FFPN, @FFAU)))
						--select @noDias , datediff(day, @FFPN, @FFAU)
					end

					IF (@FFAU BETWEEN @FIPN AND @FFPN) AND (@FIAU BETWEEN @FIPN AND @FFPN) and @afectaARP=1
					begin
						--select 'entro'
						SET @diasIncapacidad = @diasIncapacidad + @noDias
						set @valorIncapacidad=@valorIncapacidad + ((@valorTotal/@noDias)*@noDias)
					end

					IF (@FFAU > @FFPN) AND (@FIAU < @FIPN ) and @afectaARP=1
					begin
						SET @diasIncapacidad = 30
						set @valorIncapacidad=@valorIncapacidad + ((@valorTotal/@noDias)*@diasIncapacidad)
					end

					

			fetch cursorIncapacidad into @fiau, @ffau,@noDias,@valorTotal,@afectaTipoNovedad,@afectaARP,@afectaSLN
			end
			close cursorIncapacidad
			deallocate cursorIncapacidad

			insert #ibc
			select @empresa, @año,@mes, @tercero,@valorIncapacidad, @conceptoIncapacidad

		fetch cursorTercero into @tercero,@basico,@tipoCotizante,@subTipoCotizante,@isalud,@ipension,@iarp,@ifondoS,@icaja,@isena,@iicbf,@aprendiz,@pAprendiz
		end
		close cursorTercero
		deallocate cursorTercero


		select	a.tercero id,b.codigo codigoTercero, b.razonSocial ,a.concepto,c.descripcion , sum(a.ibc) valor from #IBC a
		join cTercero b on a.tercero=b.id and a.empresa=b.empresa
		join nConcepto c on c.codigo=a.concepto and c.empresa=b.empresa
		and a.ibc>0  
		group by a.tercero ,b.codigo , b.razonSocial ,a.concepto,c.descripcion 
		order by b.codigo 
		


		drop table  #ibc