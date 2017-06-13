CREATE proc [dbo].[spSeleccionaResumenLaboresTerceroFecha]
@fechaI date,
@fechaF date,
@empresa int
as

declare @mes table(id int, nombre varchar(100))

insert @mes 
select 1, 'Enero'
union
select 2, 'Febrero'
union
select 3, 'Marzo'
union
select 4, 'Abril'
union
select 5, 'Mayo'
union
select 6, 'Junio'
union
select 7, 'Julio'
union
select 8, 'Agosto'
union
select 9, 'Septiembre'
union
select 10, 'Octubre'
union
select 11, 'Noviembre'
union
select 12, 'Diciembre'

declare @tmpResumen table
(	codLabor varchar(50),
	nombreLabor varchar(200),
	idtercero int,
	nombreTercero varchar(200),
	umedida varchar(50),
	cantidad decimal(18,2),
	valorTotal decimal(18,2),
	mes int,
	desarrollo bit,
	contratista bit
)
insert @tmpResumen
select k.codigo idgrupo , k.descripcion  grupo,
c.tercero idtercero, e.descripcion destercero,d.uMedida , 
Sum(c.cantidad) cantidad, sum(c.valorTotal) valorTotal, DATEPART(month,b.fecha) mes, h.desarrollo
, j.contratista 
from
aTransaccion a 
join aTransaccionNovedad b on a.numero=b.numero and a.tipo=b.tipo and a.empresa=b.empresa 
join aTransaccionTercero c on b.numero=c.numero and b.tipo=c.tipo and b.registro=c.registroNovedad and b.empresa=c.empresa 
join aNovedad d on b.novedad = d.codigo and b.empresa=d.empresa
join cTercero e on c.tercero=e.id and e.empresa=c.empresa
join nContratos g on g.tercero=c.tercero and g.empresa=a.empresa and g.id in (select max(id) from nContratos where c.tercero=tercero and empresa=@empresa )
 left join aLotes h on h.codigo=c.lote and h.empresa=a.empresa
 join nConcepto i on i.codigo=d.concepto and i.empresa=d.empresa
 left join aloteCcostoSigo ii on ii.lote = c.lote and i.empresa=c.empresa
 join nFuncionario j on j.tercero=c.tercero and j.empresa=a.empresa
 join aGrupoNovedad k on d.grupo=k.codigo and k.empresa=a.empresa
where convert(date, b.fecha) between @fechaI and @fechaF 
and a.anulado=0  and c.ejecutado=1 
and j.contratista=0 
and a.empresa=@empresa
group by e.codigo, e.descripcion,i.codigo, i.descripcion,e.descripcion, g.ccosto, c.tercero,b.novedad, d.descripcion,d.uMedida, a.mes,a.empresa, d.naturaleza,h.desarrollo,
i.baseCesantias, i.basePrimas, i.baseIntereses, i.baseVacaciones ,ii.mCcostoSigo, ii.aCcostoSigo ,DATEPART(month,b.fecha),j.contratista,c.lote,k.codigo,k.descripcion
order by b.novedad

insert @tmpResumen
select k.codigo idgrupo , k.descripcion  grupo,
c.tercero idtercero, e.descripcion destercero,d.uMedida , 
Sum(c.cantidad) cantidad, sum(c.valorTotal) valorTotal, DATEPART(month,b.fecha) mes, h.desarrollo
, j.contratista 
from
aTransaccion a 
join aTransaccionNovedad b on a.numero=b.numero and a.tipo=b.tipo and a.empresa=b.empresa 
join aTransaccionTercero c on b.numero=c.numero and b.tipo=c.tipo and b.registro=c.registroNovedad and b.empresa=c.empresa 
join aNovedad d on b.novedad = d.codigo and b.empresa=d.empresa
join cTercero e on c.tercero=e.id and e.empresa=c.empresa
--join nContratos g on g.tercero=c.tercero and g.empresa=a.empresa --and g.activo=1
 left join aLotes h on h.codigo=c.lote and h.empresa=a.empresa
 join nConcepto i on i.codigo=d.concepto and i.empresa=d.empresa
 left join aloteCcostoSigo ii on ii.lote = c.lote and i.empresa=c.empresa
 join nFuncionario j on j.tercero=c.tercero and j.empresa=a.empresa
 join aGrupoNovedad k on d.grupo=k.codigo and k.empresa=a.empresa
where convert(date, a.fecha) between @fechaI and @fechaF 
and a.anulado=0  
and j.contratista=1
and a.empresa=@empresa
group by e.codigo, e.descripcion,i.codigo, i.descripcion,e.descripcion,  c.tercero,b.novedad, d.descripcion,d.uMedida, a.mes,a.empresa, d.naturaleza,h.desarrollo,
i.baseCesantias, i.basePrimas, i.baseIntereses, i.baseVacaciones ,ii.mCcostoSigo, ii.aCcostoSigo ,DATEPART(month,b.fecha),j.contratista,c.lote,k.codigo,k.descripcion
order by b.novedad

select distinct a.id,a.nombre, a.codigo idGrupo, a.descripcion grupo, isnull(b.contratista,0) contratista, isnull(desarrollo,0) desarrollo,isnull(b.valorTotal,0) valorTotal  from (select * from @mes, aGrupoNovedad) a  left join (
select mes,codLabor, nombreLabor, umedida, count(idtercero) trabajadores,  SUM(cantidad) cantidad, 
sum(valorTotal) valorTotal, desarrollo, contratista from  @tmpResumen
group by codLabor, nombreLabor, desarrollo,umedida,mes,contratista
) b on a.codigo=b.codLabor and a.id = b.mes