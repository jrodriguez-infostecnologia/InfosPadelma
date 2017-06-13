-- Batch submitted through debugger: SQLQuery6.sql|7|0|C:\Users\DESARR~1\AppData\Local\Temp\~vs1CA0.sql
CREATE proc [dbo].[spSeleccionaIBCTrabajadorSSNO]
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
@exoneraSalud varchar(1),@aprendiz bit,@pAprendiz float,@conceptoVacaciones varchar(50),@conceptoIncapacidad varchar(50),
@valorVacacionesCompensada int=0


create table #IBC
(
empresa int,
año int,
mes int,
tercero int,
ibc int,
incapacidad int,
vacaciones int,
vacacionesComp int

)

select @FIPN =fechaInicial, @FFPN= fechaFinal 
from cPeriodo where año=@año and mes=@mes and empresa=@empresa

select @conceptoVacaciones=vacaciones,@conceptoIncapacidad= incapacidades from nParametrosGeneral where empresa=@empresa

declare cursorTercero insensitive cursor for	
		select distinct  isnull(codTercero,a.idtercero), isnull((select max(salario) from nContratos where empresa=@empresa and tercero=  isnull(codTercero,a.idtercero)) , '') , tipoContizante, subTipoCotizante,salud,pension,arp,fondoSolidaridad,caja,sena,icbf,electivaProduccion,porcentajeSS from nSeguridadSocial a left join
		vSeleccionaLiquidacionDefinitiva b on a.idTercero=b.codTercero and a.empresa=b.empresa
		where a.empresa=@empresa and a.año=@año and a.mes=@mes and anulado=0
		--and tercero =237
		--order by codTercero
		open cursorTercero			
		fetch cursorTercero into 	@tercero,@basico,@tipoCotizante,@subTipoCotizante,@isalud,@ipension,@iarp,@ifondoS,@icaja,@isena,@iicbf,@aprendiz,@pAprendiz
		while( @@fetch_status = 0 )
		begin	
			SELECT  @IBC=0,@diasIBC=0,@diasIncapacidad=0,@valorIncapacidad=0,@IGE=' ',@SLN=' ',@IRP=0,@LMA=' ',@diasSLN=0,@valorSLN=0,
			@diasVacaiones=0,@valorVacaciones=0,@VAC=' ',@ING='',@RET=' ',@TDE='',@TAE='',@TDP='', @exoneraSalud='S', @TAP='',@VSP='',@VTE='',@AVP='',
			@valorARP=0,@valorCaja=0,@valorFondoSolidaridad=0,@valorICBF=0,@valorPension=0,@valorSalud=0,@valorSLN=0,@valorSena=0
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

			  set @valorVacacionesCompensada = isnull((select sum(valorTotal)
		 from vSeleccionaLiquidacionDefinitiva
		where empresa=@empresa and año=@año and mes=@mes  and codconcepto=@conceptoVacaciones
		and codTercero=@tercero and anulado=0 and tipoConcepto=2),0)

 
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
			select @empresa, @año,@mes, @tercero,@IBC ,@valorIncapacidad ,@valorVacaciones,@valorVacacionesCompensada
	

		fetch cursorTercero into @tercero,@basico,@tipoCotizante,@subTipoCotizante,@isalud,@ipension,@iarp,@ifondoS,@icaja,@isena,@iicbf,@aprendiz,@pAprendiz
		end
		close cursorTercero
		deallocate cursorTercero

		
create table #tmpSeguridadSocialNomina
(
idTercero varchar(50),
identificacion varchar(50),
nombreTercero varchar(350),
concepto varchar(50),
nombreConcepto varchar(250),
ibc float,
valorSeguridadSocialNomina float,
valorSeguridadSocial float,
empleadoSena bit,
valorSeguridadSocialxEmpleador float,
sln float,
idFondo varchar(50),
descripcionFondo varchar(350),
codCentroCosto varchar(50),
CentroCosto varchar(350),
valorContabilizado float
)


declare @conceptoSalud varchar(50) = (select salud from nParametrosGeneral where empresa=@empresa)
declare @conceptoPension varchar(50) = (select pension from nParametrosGeneral where empresa=@empresa)
declare @conceptoICBF varchar(50) = (select ICBF from nParametrosGeneral where empresa=@empresa)
declare @conceptoARL varchar(50) = (select ARP from nParametrosGeneral where empresa=@empresa)
declare @conceptoCaja varchar(50) = (select cajaCompensacion from nParametrosGeneral where empresa=@empresa)
declare @conceptoSena varchar(50) = (select sena from nParametrosGeneral where empresa=@empresa)
declare @conceptoFondoSolidaridad varchar(50) = (select fondoSolidaridad from nParametrosGeneral where empresa=@empresa)
declare @SlnSalud float 



 -- seguridad social
insert #tmpSeguridadSocialNomina
select distinct
a.idTercero ,	   --idTercero varchar(50),
c.codigo,   --identificacion varchar(50),
c.razonSocial,     --nombreTercero varchar(50),
@conceptoSalud,		   --concepto varchar(50),
(select top 1 descripcion from nConcepto z where z.codigo=@conceptoSalud and z.empresa=@empresa),	   --nombreConcepto varchar(250),
a.IBCsalud IBCsalud ,
0,				   --valorNominaTrabajador float, 
a.valorSalud  valorSeguridadSocial,		   --valorSeguridadSocial float,
0,		   --valorSeguridadSocialSena float,
0 ,  --valorSeguridadSocialxEmpleador float
0,
e.codigo , 
e.razonSocial,
'',
'',
(select  sum(credito)  from cContabilizacion aa join cContabilizacionDetalle bb
on aa.numero=bb.numero and aa.tipo=bb.tipo and aa.empresa=bb.empresa
where codigoConcepto=@conceptoSalud and aa.año=@año and aa.mes=@mes  and aa.empresa=@empresa and bb.codigoEmpleado=a.idTercero and aa.anulado=0
and e.nit=bb.terceroContable
)
-- from
from nSeguridadSocial a
 join cTercero c on c.id = a.idTercero and c.empresa = a.empresa
 join cperiodo d on d.año=a.año and d.mes=a.mes and d.empresa=a.empresa
 join cTercero e on a.terceroSalud=e.id and e.empresa=a.empresa
where a.año=@año and a.mes=@mes  and a.empresa=@empresa and SLN<>'X'and a.valorSalud>0


update #tmpSeguridadSocialNomina
set sln = a.IBCsalud
from  #tmpSeguridadSocialNomina aa join   nSeguridadSocial a on a.idTercero = aa.idTercero
and aa.concepto=@conceptoSalud 
join vEntidadEps b on a.terceroSalud = b.tercero and a.empresa=b.empresa
join nConcepto c on c.codigo=@conceptoSalud and c.empresa=a.empresa
join cTercero d on a.idTercero=d.id and a.empresa=d.empresa
join nContratos g on g.tercero=a.idTercero and g.empresa=c.empresa and g.id= (select max(id) from nContratos zz where g.tercero=zz.tercero and c.empresa=zz.empresa and zz.activo=1)
join nClaseContrato h on g.claseContrato=h.codigo and g.empresa=h.empresa
where año=@año and mes=@mes  and a.empresa=@empresa and a.SLN='X'

 -- seguridad social
insert #tmpSeguridadSocialNomina
select distinct
a.idTercero ,	   --idTercero varchar(50),
c.codigo,   --identificacion varchar(50),
c.razonSocial,     --nombreTercero varchar(50),
@conceptoPension,		   --concepto varchar(50),
(select top 1 descripcion from nConcepto z where z.codigo=@conceptoPension and z.empresa=@empresa),	   --nombreConcepto varchar(250),
a.IBCpension IBCsalud ,
0,				   --valorNominaTrabajador float, 
a.valorPension + a.valorFondo + a.valorFondoSub  valorSeguridadSocial,		   --valorSeguridadSocial float,
0,		   --valorSeguridadSocialSena float,
0 ,  --valorSeguridadSocialxEmpleador float
0,
e.codigo , 
e.razonSocial,
'',
'',
(select   sum(credito)  from cContabilizacion aa join cContabilizacionDetalle bb
on aa.numero=bb.numero and aa.tipo=bb.tipo and aa.empresa=bb.empresa
where codigoConcepto in(@conceptoPension,@conceptoFondoSolidaridad) and aa.año=@año and aa.mes=@mes  and aa.empresa=@empresa and bb.codigoEmpleado=a.idTercero and aa.anulado=0
and bb.terceroContable=e.codigo and bb.empresa=e.empresa)
-- from
from nSeguridadSocial a
 join cTercero c on c.id = a.idTercero and c.empresa = a.empresa
 join cperiodo d on d.año=a.año and d.mes=a.mes and d.empresa=a.empresa
 join cTercero e on a.terceroPension=e.id and e.empresa=a.empresa
where a.año=@año and a.mes=@mes  and a.empresa=@empresa and SLN<>'X'and a.valorPension>0


update #tmpSeguridadSocialNomina
set sln = a.IBCpension
from  #tmpSeguridadSocialNomina aa join   nSeguridadSocial a on a.idTercero = aa.idTercero
and aa.concepto=@conceptoPension 
join vEntidadEps b on a.terceroSalud = b.tercero and a.empresa=b.empresa
join nConcepto c on c.codigo=@conceptoSalud and c.empresa=a.empresa
join cTercero d on a.idTercero=d.id and a.empresa=d.empresa
join nContratos g on g.tercero=a.idTercero and g.empresa=c.empresa and g.id= (select max(id) from nContratos zz where g.tercero=zz.tercero and c.empresa=zz.empresa)
join nClaseContrato h on g.claseContrato=h.codigo and g.empresa=h.empresa
where año=@año and mes=@mes  and a.empresa=@empresa and a.SLN='X'


declare @tipoTraNomina varchar(50) = 'LQN'
-- nomina
 update #tmpSeguridadSocialNomina
 set valorSeguridadSocialNomina=valor
 from #tmpSeguridadSocialNomina join 
 (
select distinct a.codTercero,a.codigo , sum(a.valorTotal) valor, a.empresa, a.codconcepto
from vLiquidacionDefinitivaReal  a
join nContratos g on g.tercero=a.codTercero and g.empresa=a.empresa and g.id= (select max(id) from nContratos zz where g.tercero=zz.tercero and a.empresa=zz.empresa)
join nClaseContrato h on g.claseContrato=h.codigo and g.empresa=h.empresa
join #tmpSeguridadSocialNomina i on a.codConcepto=i.concepto and a.codTercero=i.idTercero and a.codigo=i.identificacion
where año=@año and mes=@mes and a.empresa=@empresa  and a.anulado=0 and a.tipo=@tipoTraNomina
group by a.codtercero,a.codigo ,a.empresa, a.codConcepto) b on #tmpSeguridadSocialNomina.concepto=b.codconcepto and #tmpSeguridadSocialNomina.idTercero=b.codTercero
and #tmpSeguridadSocialNomina.identificacion=b.codigo

--select * from #IBC
--where tercero='222'

select idTercero codTercero	,
identificacion 	,
nombreTercero	,
concepto	,
nombreConcepto	,
a.ibc ibcSS,
b.ibc ibc,
b.vacaciones,
b.vacacionesComp,
b.incapacidad,
sum(valorSeguridadSocialNomina) dNomina	,
sum(valorSeguridadSocial) pSeguridadSocial	,
empleadoSena	pSena,
sum(valorSeguridadSocialxEmpleador) pEmpleador,
sum(a.valorContabilizado) vContabilizado,
sln,
idFondo,
descripcionFondo,
codCentroCosto,
CentroCosto
from #tmpSeguridadSocialNomina  a join (select distinct * from #IBC)  b on a.idTercero=b.tercero 
and valorSeguridadSocial>0
group by
identificacion	,
nombreTercero	,
concepto	,
nombreConcepto	,
a.ibc,
b.ibc ,
b.vacaciones,
b.vacacionesComp,
b.incapacidad,
valorSeguridadSocialNomina	,
a.idTercero,
sln,
idFondo,
descripcionFondo,
codCentroCosto,
CentroCosto,
empleadoSena
order by nombreTercero, nombreConcepto


		--select * from #IBC

		drop table  #ibc
		drop table #tmpSeguridadSocialNomina