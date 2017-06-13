CREATE proc [dbo].[spSeleccionaLiquidacionNominaDefinitiva]
@empresa int,
@año int,
@periodo int,
@numero varchar(50)
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
declare @fechaInicial date, @fechaFinal date
select @fechaInicial = fechaInicial, @fechaFinal=fechaFinal from nPeriodoDetalle
where año=@año and noPeriodo=@periodo and empresa=@empresa
																	

insert @temporal
select   a.identificacion, a.codTercero, a.nombreTercero, a.codCCosto, a.nombreCcosto, a.sueldo, a.nombreCargo, a.codConcepto,
 a.nombreConcepto, case when mostrarCantidad=1 then NULL else  a.cantidad end cantidad,a.valorTotal valorConcepto, 
case when  a.saldo=0 then null else a.saldo end saldo, a.noPeriodo, 
case when a.mostrarFecha=1 then a.fechaConcepto else null end fecha, a.fechaInicial fechaInical, a.fechaFinal, a.año,
  a.mes, a.periodoUnido, a.nombreMes, a.nombreDepartamento, a.codDepto, a.signo, a.empresa, a.entidadEps, a.entidadPension, a.nombreEPS,
   a.nombrePension, a.prioridad, a.mostrarFecha, a.noMostrar, 
   'NA' labor,
   0 cantLabor,
	0 precioLabor,isnull(NULL,a.nombreConcepto) desLabor,NULL,isnull(NULL,a.fecha )fechaLabor  ,0 , 
(select sum(valorTotal) from  vSeleccionaLiquidacionDefinitiva where codTercero=a.codTercero and empresa=a.empresa and signo=1
and año=a.año and mes=a.mes and a.numero = numero and a.tipo=tipo and a.noPeriodo=noPeriodo
) TotalDevendado,
(select sum(valorTotal) from  vSeleccionaLiquidacionDefinitiva where codTercero=a.codTercero and empresa=a.empresa and signo=2
and año=a.año and mes=a.mes and a.numero = numero and a.tipo=tipo and a.noPeriodo=noPeriodo ) TotalDeducido,
NULL,isnull(NULL, datename(WEEKDAY,a.fecha)) diaSemana, 0 TotalLabor,
'' numero,'',
a.fechaInicial fip,a.fechaFinal ffp, isnull(a.tipoConcepto,'') tipoConcepto, isnull(a.desTipoConcepto,'') destipoConcepto,0, mDomingo
from vSeleccionaLiquidacionDefinitiva a
where  a.empresa=@empresa
and a.codConcepto not in (select isnull(concepto,'') from aNovedad z where z.empresa=@empresa )
and   a.noPeriodo=@periodo and a.año=@año and a.anulado=0 and a.numero like '%'+ @numero+ '%'


insert @temporal
select   a.identificacion, a.codTercero, a.nombreTercero, a.codCCosto, a.nombreCcosto, a.sueldo, a.nombreCargo, a.codConcepto,
 a.nombreConcepto, case when mostrarCantidad=1 then NULL else  a.cantidad end cantidad,a.valorTotal valorConcepto, 
case when  a.saldo=0 then null else a.saldo end saldo, a.noPeriodo, 
case when a.mostrarFecha=1 then a.fechaConcepto else null end fecha, a.fechaInicial fechaInical, a.fechaFinal, a.año,
  a.mes, a.periodoUnido, a.nombreMes, a.nombreDepartamento, a.codDepto, a.signo, a.empresa, a.entidadEps, a.entidadPension, a.nombreEPS,
   a.nombrePension, a.prioridad, a.mostrarFecha, a.noMostrar, 
   isnull(b.labor, case when a.mostrarDetalle=1 then a.codConcepto else 'NA' end )labor,
   isnull(b.cantidad,a.cantidad) cantLabor,
	b.precioLabor precioLabor,isnull(b.desLabor,a.nombreConcepto) desLabor,b.lote,isnull(b.fechaLabor,a.fecha )fechaLabor  ,b.jornales , 
0 TotalDevendado,
0 TotalDeducido,
b.umedida,isnull(b.diaSemana, datename(WEEKDAY,a.fecha)) diaSemana, isnull((b.precioLabor * b.cantidad * (case when b.signo=2 then -1 else 1 end)),a.valorTotal) TotalLabor,
convert (int,substring(b.numero,4,len(b.numero))) numero,b.tipo,
a.fechaInicial fip,a.fechaFinal ffp, isnull(a.tipoConcepto,'') tipoConcepto, isnull(a.desTipoConcepto,'') destipoConcepto,b.racimos, mDomingo
from vSeleccionaLiquidacionDefinitiva a
left join vSeleccionaLaboresTerceroLiquida b on
 a.codConcepto = b.concepto and a.empresa=b.empresa and a.codTercero=b.tercero and a.contrato=b.contrato
where a.empresa=@empresa
and a.codConcepto  in (select distinct isnull(concepto,'') from aNovedad  where empresa=@empresa )
and valorTotal>0  
and a.noPeriodo=@periodo and a.año=@año and a.anulado=0 
and convert(date,b.fecha) between @fechaInicial and @fechaFinal and a.numero like '%'+ @numero+ '%'

select * from @temporal
where mDomingo=0