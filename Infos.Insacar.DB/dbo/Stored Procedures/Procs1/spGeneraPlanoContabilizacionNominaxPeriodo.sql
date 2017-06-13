
CREATE proc [dbo].[spGeneraPlanoContabilizacionNominaxPeriodo]
 @año int,
 @periodo int,
 @tipo varchar(4),
 @empresa int,
 @noComprobante int,
 @numeroCruce int

 as

declare  @causacionNomina table (
año int,
mes int , 
noPeriodo int,
fecha date,
tercero	 int,
identificacion varchar(50),
empleado varchar(200),
concepto varchar(50),
nombreConcepto varchar(200),
valorTotal money,
ccosto varchar(50),
empresa int,
entidadEPS varchar(50),
entidadPension varchar(50),
naturaleza int,
desarrollo bit
)

declare  @plano table (
tipo varchar(max),
comprobante varchar(max),
Nocomprobante int,
registro varchar(max),
Identificacion varchar(max),
CuentaContable varchar(max),
fecha varchar(max),
mayorCcostoSigo varchar(max),
ccostoSig varchar(max),
nota varchar(max),
Naturaleza varchar(max),
valorTotal money,
comprobanteFinal int,
registroFInal int)

declare @numeroComprobante int=0, @cruce int=260, @nota varchar(50)='PRUEBA'


if @tipo= 'CA'
begin

insert @causacionNomina
select a.año, a.mes, a.noPeriodo,a.fecha, a.tercero, c.codigo identificacion, c.descripcion empleado,   a.concepto, b.descripcion nombreConcepto,
sum(valorTotal) valorTotal, ccosto , a.empresa,a.entidadEps, a.entidadPension, a.signo,0
from vSeleccionaLiquidacionDefinitiva a join
nConcepto b on a.concepto=b.codigo and a.empresa=b.empresa
join cTercero c on c.id = a.tercero and c.empresa = b.empresa
where a.año=@año and a.noPeriodo=@periodo and a.empresa=@empresa
group by a.año, a.mes, a.noPeriodo,a.fecha, a.tercero, c.codigo, c.descripcion ,   a.concepto, b.descripcion,ccosto,a.empresa, a.entidad,a.signo,a.entidadEps, a.entidadPension


declare @fi date, @ff date
select @fi=fechaInicial, @ff=fechaFinal from nPeriodoDetalle where año=@año and noPeriodo=@periodo 
and empresa=@empresa

insert  @causacionNomina
select   a.año, a.mes,0, a.fecha,c.tercero, e.codigo identificacion,e.descripcion empleado,  'L'+d.codigo concepto, d.descripcion nombreConcepto,
sum(convert(decimal(18,2),c.precioLabor* c.cantidad)) valorTotal, g.ccosto,a.empresa,'', '', d.naturaleza,h.desarrollo  from aTransaccion a 
join aTransaccionNovedad b on a.numero=b.numero and a.tipo=b.tipo and a.empresa=b.empresa 
join aTransaccionTercero c on b.numero=c.numero and b.tipo=c.tipo and b.registro=c.registroNovedad and b.empresa=c.empresa 
join aNovedad d on b.novedad = d.codigo and b.empresa=d.empresa
join cTercero e on c.tercero=e.id and e.empresa=c.empresa
join nContratos g on g.tercero=c.tercero and g.empresa=c.empresa --and g.activo=1
 join aLotes h on h.codigo=c.lote and h.empresa=c.empresa
where convert(date, a.fecha) between @fi and @ff and a.empresa=@empresa
and g.ccosto in (select ccosto from @causacionNomina)
and a.anulado=0  and c.ejecutado=1
group by a.año, a.mes,a.fecha,e.codigo, e.descripcion,d.codigo, d.descripcion,e.descripcion, g.ccosto, c.tercero,b.novedad, d.descripcion,d.uMedida, a.mes,a.empresa, d.naturaleza,h.desarrollo
order by b.novedad




insert @plano 
select  distinct
tipo,
comprobante,
nocomprobante,
registro,
RIGHT(replicate('0',13) +cast (((identificacion)) as varchar),13)  Identificacion,
cuentaContable  + REPLICATE('0', 23 -len((cuentaContable)))  CuentaContable,
CONVERT(VARCHAR(10), convert(datetime,fecha), 112) fecha,
RIGHT(replicate('0',4) + cast((isnull(ccostoSigo,'')) as varchar),4) mayorCcostoSigo,
RIGHT(replicate('0',3) + cast((isnull(SubCCostoSigo,'')) as varchar),3) ccostoSig,
convert(char(50),'NOTA') nota,
Naturaleza,
case when Naturaleza ='D' then Debito else Credito end  valorTotal,
0,
0
from cContabilizacion
where   nocomprobante=@noComprobante

declare @noComp int , @registro int

select * from @plano
--DECLARE curPlano CURSOR FOR 
--SELECT Nocomprobante, registro
--FROM @plano 

--OPEN curPlano

--FETCH NEXT FROM curPlano 
--INTO @noComp, @registro

--WHILE @@FETCH_STATUS = 0
--BEGIN
-- select @noComp, @registro
--FETCH NEXT FROM curPlano 
--end

--close  curPlano 
--DEALLOCATE curPlano;

end