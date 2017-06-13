CREATE proc [dbo].[spSeleccionaPreliquidacionNomina]
@empresa int
as

declare @temporal table 
(
identificacion varchar(50),
codTercero int,
nombreTercero varchar(300),
codCCosto varchar(50),
nombreCcosto varchar(250),
sueldo money,
nombreCargo varchar(300),
codConcepto varchar(50),
nombreConcepto varchar(300),
cantidad decimal(18,3),
valorConcepto money,
saldo money,
noPeriodo int,
fecha date,
fechaInical date,
fechaFinal date,
año int,
mes int,
periodoUnido varchar(300),
nombreMes varchar(300),
nombreDepartamento varchar(400),
codDepto varchar(50),
signo int,
empresa int,
entidadEps varchar(50),
entidadPension varchar(50),
nombreEPS varchar(300),
nombrePension varchar(300),
prioridad int,
mostrarFecha bit,
noMostrar bit,
labor varchar(50),
cantLabor decimal(18,3),
precioLabor money,
desLabor varchar(350),
lote varchar(50),
fechaLabor date,
jornales decimal(18,3),
TotalDevendado money,
TotalDeducido money,
umedida varchar(50),
diaSemana varchar(100),
TotalLabor money,
numero varchar(50),
tipo varchar(50),
fip date,
ffp date,
tipoConcepto varchar(3),
destipoConcepto varchar(200),
racimos int,
mDomingo bit
)
					
										

insert @temporal
select   a.identificacion, a.codTercero, a.nombreTercero, a.codCCosto, a.nombreCcosto, a.sueldo, a.nombreCargo, a.codConcepto,
 a.nombreConcepto, 
case when mostrarCantidad=1 then NULL else  a.cantidad end cantidad,a.valorConcepto valorConcepto, 
case when  a.saldo=0 then null else a.saldo end saldo, a.noPeriodo, 
case when a.mostrarFecha=1 then a.fecha else null end fecha, a.fechaInical, a.fechaFinal, a.año,
  a.mes, a.periodoUnido, a.nombreMes, a.nombreDepartamento, a.codDepto, a.signo, a.empresa, a.entidadEps, a.entidadPension, a.nombreEPS,
   a.nombrePension, a.prioridad, a.mostrarFecha, a.noMostrar, 
   isnull(b.labor, case when a.mostrarDetalle=1 then a.codConcepto else 'NA' end )labor,
   isnull(b.cantidad,a.cantidad) cantLabor,
	b.precioLabor precioLabor,isnull(b.desLabor,a.nombreConcepto) desLabor,b.lote,isnull(b.fechaLabor,a.fecha )fechaLabor  ,b.jornales , 
(select sum(valorConcepto) from  vSeleccionaPreliquidacion where codTercero=a.codTercero and empresa=a.empresa and signo=1
and año=a.año and mes=a.mes  and a.noPeriodo=noPeriodo) TotalDevendado,
(select sum(valorConcepto) from  vSeleccionaPreliquidacion where codTercero=a.codTercero and empresa=a.empresa and signo=2
and año=a.año and mes=a.mes  and a.noPeriodo=noPeriodo) TotalDeducido,
b.umedida,isnull(b.diaSemana, datename(WEEKDAY,a.fecha)) diaSemana, isnull((b.precioLabor * b.cantidad * (case when b.signo=2 then -1 else 1 end)),a.valorConcepto) TotalLabor,
convert (int,substring(b.numero,4,len(b.numero))) numero,b.tipo,
p.fechaInicial fip,p.fechaFinal ffp, isnull(a.tipoConcepto,'') tipoConcepto, isnull(a.desTipoConcepto,'') destipoConcepto,b.racimos,
case when a.codConcepto in (nn.ganaDomingo,nn.pagoFestivo,nn.PrimasExtralegales) and n.mDomingo=1 then 1 else 0 end mDomingo
from vSeleccionaPreliquidacion a
join nConceptosFijos n on n.empresa=a.empresa and n.año =a.año and n.noPeriodo=a.noPeriodo and n.centroCosto=a.codCCosto
left join nPeriodoDetalle p on p.noPeriodo=a.noPeriodo and p.año=a.año and p.empresa=a.empresa
left join vSeleccionaLaboresTerceroLiquida b on b.empresa=a.empresa and b.fecha between a.fechaInical 
and a.fechaFinal and b.concepto=a.codConcepto and a.codTercero=b.tercero --and a.signo=b.signo
join nParametrosGeneral nn on nn.empresa=a.empresa
where  a.empresa=@empresa
and a.codConcepto not in (select isnull(concepto,'') from aNovedad z where z.empresa=@empresa )


insert @temporal
select   a.identificacion, a.codTercero, a.nombreTercero, a.codCCosto, a.nombreCcosto, a.sueldo, a.nombreCargo, a.codConcepto,
 a.nombreConcepto, case when mostrarCantidad=1 then NULL else  a.cantidad end cantidad,
 a.valorConcepto valorConcepto, case when  a.saldo=0 then null else a.saldo end saldo, a.noPeriodo, 
 case when a.mostrarFecha=1 then a.fecha else null end fecha, a.fechaInical, a.fechaFinal, a.año,
  a.mes, a.periodoUnido, a.nombreMes, a.nombreDepartamento, a.codDepto, a.signo, a.empresa, a.entidadEps, a.entidadPension, a.nombreEPS,
   a.nombrePension, a.prioridad, a.mostrarFecha, a.noMostrar, 
   isnull(b.labor, case when a.mostrarDetalle=1 then a.codConcepto else 'NA' end )labor,
   isnull(b.cantidad,a.cantidad) cantLabor,
	b.precioLabor precioLabor,isnull(b.desLabor,a.nombreConcepto) desLabor,b.lote,isnull(b.fechaLabor,a.fecha )fechaLabor  ,b.jornales , 
(select sum(valorConcepto) from  vSeleccionaPreliquidacion where codTercero=a.codTercero and empresa=a.empresa and signo=1) TotalDevendado,
(select sum(valorConcepto) from  vSeleccionaPreliquidacion where codTercero=a.codTercero and empresa=a.empresa and signo=2) TotalDeducido,
b.umedida,isnull(b.diaSemana, datename(WEEKDAY,a.fecha)) diaSemana, 
isnull((b.precioLabor * b.cantidad * (case when b.signo=2 then -1 else 1 end)), a.valorConcepto) TotalLabor,
convert (int,substring(b.numero,4,len(b.numero))) numero,b.tipo,
p.fechaInicial fip,p.fechaFinal ffp, isnull(a.tipoConcepto,'') tipoConcepto, isnull(a.desTipoConcepto,'') destipoConcepto,b.racimos,
case when a.codConcepto in (nn.ganaDomingo,nn.pagoFestivo,nn.PrimasExtralegales) and n.mDomingo=1 then 1 else 0 end mDomingo
from vSeleccionaPreliquidacion a
join nConceptosFijos n on n.empresa=a.empresa and n.año =a.año and n.noPeriodo=a.noPeriodo and n.centroCosto=a.codCCosto
left join nPeriodoDetalle p on p.noPeriodo=a.noPeriodo and p.año=a.año and p.empresa=a.empresa
left join vSeleccionaLaboresTerceroLiquida b on b.empresa=a.empresa and b.fecha between a.fechaInical 
and a.fechaFinal and b.concepto=a.codConcepto and a.codTercero=b.tercero --and a.signo=b.signo
join nParametrosGeneral nn on nn.empresa=a.empresa
where  a.empresa=@empresa
and a.codConcepto  in (select isnull(concepto,'') from aNovedad z where z.empresa=@empresa )
and valorConcepto>0  



select * from @temporal
where mDomingo=0