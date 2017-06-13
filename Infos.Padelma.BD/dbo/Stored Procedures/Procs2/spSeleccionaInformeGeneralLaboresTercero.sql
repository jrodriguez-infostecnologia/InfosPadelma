create proc [dbo].[spSeleccionaInformeGeneralLaboresTercero]
@fechaInicial date,
@fechaFinal date,
@empresa int
as

select c.tercero idTercero, e.descripcion tercero from aTransaccion a
join aTransaccionNovedad b on a.numero=b.numero and a.tipo=b.tipo and a.empresa=b.empresa
left join aTransaccionTercero c on a.numero=c.numero and c.tipo=a.tipo and  c.empresa=a.empresa
and b.novedad=c.novedad and c.registroNovedad=b.registro
join aNovedad d on b.novedad=d.codigo and d.empresa=b.empresa
join cTercero e on e.id=c.tercero and e.empresa=c.empresa
join aFinca f on a.finca=f.codigo and a.empresa=f.empresa
left join aSecciones g on g.codigo=b.seccion and g.empresa=b.empresa

where a.fecha between @fechaInicial and @fechaFinal
and a.anulado=0