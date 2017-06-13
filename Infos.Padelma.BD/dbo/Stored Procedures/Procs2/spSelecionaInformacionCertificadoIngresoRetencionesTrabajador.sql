CREATE proc [dbo].[spSelecionaInformacionCertificadoIngresoRetencionesTrabajador]
 @empresa int, @año  int,@trabajador int
 as
 declare @fechaInicial date,@fechaFinal date 

set @fechaInicial= '01-01-'+convert(varchar,@año)
set @fechaFinal= '31-12-'+convert(varchar,@año)


select  d.codigo idTipoDocumento,c.codigo identificacion,c.apellido1 primerApellido,c.apellido2 segundoApellido,c.nombre1 primerNombre,c.nombre2 otrosNombres,
 convert(date, case when fechaIngreso >@fechaInicial then fechaIngreso else @fechaInicial end) fechaInicial  ,
convert(date, case when fechaContratoHasta <@fechaFinal then fechaContratoHasta else @fechaFinal end) fechaFinal,
f.codigo Municipio,sum(isnull(b.valorTotal,0)) valorTotal,h.codigo tipoConcepto,h.descripcion nombreTipoConcepto
from  nTipoConcepto h 
 join nTipoConceptoDetalle g on h.codigo=g.tipoConcepto and h.empresa=g.empresa
 left join nLiquidacionNominaDetalle b  on b.concepto =g.concepto and b.empresa=g.empresa and b.tercero=@trabajador
 left join nLiquidacionNomina a on  b.numero=a.numero and b.tipo=a.tipo and b.empresa=a.empresa and a.año=@año and a.anulado=0
 left join cTercero c on c.id=b.tercero and c.empresa=b.empresa 
 left join gTipoDocumento d on d.codigo=c.tipoDocumento and d.empresa=c.empresa
 left join nContratos e on e.id=b.contrato and e.tercero=b.tercero and e.empresa=b.empresa
 left join gCiudad  f on f.codigo=c.ciudad and f.empresa=c.empresa
where   h.empresa=@empresa 
group by d.codigo,c.codigo,c.apellido1,c.apellido2,c.nombre1,c.nombre2,  fechaIngreso ,
 fechaContratoHasta,f.codigo,h.codigo,h.descripcion
 union 
 select null,null,null,null,null,null,null,null,null,0,'059','AA'
 union
 select  null,null,null,null,null,null,null,null,null,sum(isnull(b.valorTotal,0)) valorTotal,'058','Total'
from  nTipoConcepto h 
 join nTipoConceptoDetalle g on h.codigo=g.tipoConcepto and h.empresa=g.empresa
 left join nLiquidacionNominaDetalle b  on b.concepto =g.concepto and b.empresa=g.empresa and b.tercero=@trabajador
 left join nLiquidacionNomina a on  b.numero=a.numero and b.tipo=a.tipo and b.empresa=a.empresa and a.año=@año and a.anulado=0
 left join cTercero c on c.id=b.tercero and c.empresa=b.empresa 
 left join gTipoDocumento d on d.codigo=c.tipoDocumento and d.empresa=c.empresa
 left join nContratos e on e.id=b.contrato and e.tercero=b.tercero and e.empresa=b.empresa
 left join gCiudad  f on f.codigo=c.ciudad and f.empresa=c.empresa
where   h.empresa=@empresa and h.codigo in ('01','02','05')
 order by tipoConcepto

 --select h.codigo,h.descripcion, sum()
 --from  nTipoConcepto h 
 --join nTipoConceptoDetalle g on h.codigo=g.tipoConcepto and h.empresa=g.empresa
 --left join nLiquidacionNominaDetalle b  on b.concepto =g.concepto and b.empresa=g.empresa
 --where a.empresa=@empresa and a.año=@año and a.anulado=0 and b.tercero=@trabajador

 --create table #IngresoRete(nit varchar(50),dv int,nombreEmpresa varchar(550),
 --nombre1 varchar(550), nombre2 varchar(550), apellido1 varchar(550), apellido2 varchar(550),
 --identificacion varchar(50),fechainicial date, fechaFinal date,fechaGenera date,
 --departamento varchar(50),municipio varchar(50),pagos float,cesanciatas float,
 --otrosIngresos float,totalIngresos float, salud float, pension float
 --)