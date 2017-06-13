CREATE proc [dbo].[spSeleccionaHojadeVidaFincaFecha]
@año int,
@empresa int
as


declare @tmpResumen table
(	mes int,
	codLabor varchar(50),
	nombreLabor varchar(200),
	idtercero int,
	nombreTercero varchar(200),
	umedida varchar(50),
	cantidad decimal(18,2),
	valorTotal decimal(18,2)
)
insert @tmpResumen
select datepart(month, a.fecha),f.codigo codgrupo , f.descripcion desGrupo,
c.tercero idtercero, e.descripcion destercero,d.uMedida , 
sum(c.cantidad) cantidad, sum(c.precioLabor* c.cantidad) valorTotal  from aTransaccion a 
join aTransaccionNovedad b on a.numero=b.numero and a.tipo=b.tipo and a.empresa=b.empresa 
join aTransaccionTercero c on b.numero=c.numero and b.tipo=c.tipo and b.registro=c.registroNovedad and b.empresa=c.empresa 
join aNovedad d on b.novedad = d.codigo and b.empresa=d.empresa
join cTercero e on c.tercero=e.id and e.empresa=c.empresa
join aGrupoNovedad f on f.codigo= d.grupo and f.empresa=d.empresa
where DATEPART(year,a.fecha)=@año  
and a.anulado=0 
group by  f.codigo, f.descripcion,e.descripcion, c.tercero,b.novedad, d.descripcion,d.uMedida, a.fecha 
order by b.novedad


select mes,codLabor, nombreLabor, umedida, count(idtercero) trabajadores,  SUM(cantidad) cantidad, 
sum(valorTotal) valorTotal from @tmpResumen
group by codLabor, nombreLabor,mes, umedida
order by mes