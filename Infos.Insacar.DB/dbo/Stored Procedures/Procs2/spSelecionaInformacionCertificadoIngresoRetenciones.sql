CREATE proc spSelecionaInformacionCertificadoIngresoRetenciones
 @empresa int, @año  int
 as
 declare @fechaInicial date,@fechaFinal date 

set @fechaInicial= '01-01-'+convert(varchar,@año)
set @fechaFinal= '31-12-'+convert(varchar,@año)


select  d.codigo idTipoDocumento,c.codigo identificacion,c.apellido1 primerApellido,c.apellido2 segundoApellido,c.nombre1 primerNombre,c.nombre2 otrosNombres,
 convert(date, case when fechaIngreso >@fechaInicial then fechaIngreso else @fechaInicial end) fechaInicial  ,
convert(date, case when fechaContratoHasta <@fechaFinal then fechaContratoHasta else @fechaFinal end) fechaFinal,f.nombre Municipio,
sum(b.valorTotal) valorTotal,isnull(h.codigo,'999') tipoConcepto,isnull(h.descripcion,'Otros') nombreTipoConcepto
from nLiquidacionNomina a
join nLiquidacionNominaDetalle b on b.numero=a.numero and b.tipo=a.tipo and b.empresa=a.empresa
join cTercero c on c.id=b.tercero and c.empresa=b.empresa 
 join nTipoConceptoDetalle g on g.concepto=b.concepto and g.empresa=b.empresa
 join nTipoConcepto h on h.codigo=g.tipoConcepto and h.empresa=g.empresa
join gTipoDocumento d on d.codigo=c.tipoDocumento and d.empresa=c.empresa
join nContratos e on e.id=b.contrato and e.tercero=b.tercero and e.empresa=b.empresa
left join gCiudad  f on f.codigo=c.ciudad and f.empresa=c.empresa
where a.empresa=@empresa and a.año=@año and a.anulado=0
group by d.codigo,c.codigo,c.apellido1,c.apellido2,c.nombre1,c.nombre2,  fechaIngreso ,
 fechaContratoHasta,f.nombre,h.codigo,h.descripcion