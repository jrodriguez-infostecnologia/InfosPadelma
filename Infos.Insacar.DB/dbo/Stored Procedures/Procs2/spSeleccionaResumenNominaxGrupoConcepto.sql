CREATE proc [dbo].[spSeleccionaResumenNominaxGrupoConcepto]
 @año int,
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


select a.id,a.nombre,a.codigo concepto, a.descripcion grupo,  isnull(b.ValorTotal,0) valorTotal from (select * from ngrupoConcepto, @mes) a 
left join ( select d.codigo idGrupo,isnull(d.descripcion,'Otros') grupo,  sum(a.valorTotal) ValorTotal, a.mes 
from vSeleccionaLiquidacionDefinitiva a 
left join ngrupoconceptoDetalle c on c.cocepto=a.codConcepto 
join ngrupoconcepto d on d.codigo=c.grupo and d.empresa=a.empresa
where a.empresa=@empresa and año=@año
group by d.codigo,d.descripcion, mes) b on a.codigo=b.idGrupo and a.id=b.mes 
order by a.id