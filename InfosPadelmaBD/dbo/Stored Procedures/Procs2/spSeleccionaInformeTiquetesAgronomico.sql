CREATE proc [dbo].[spSeleccionaInformeTiquetesAgronomico]
@fechaInicial date,
@fechaFinal date,
@tiquete varchar(50),
@empresa int
as

select a.fecha fechaTransaccion,b.año, b.mes, 
a.tipo, a.numero, a.finca idFinca, f.descripcion  finca,
b.seccion idSeccion, g.descripcion Seccion, b.lote, b.novedad idNovedad,  d.descripcion novedad,
c.tercero idTercero, e.descripcion tercero, c.cantidad, c.jornales, b.racimos racimoLabor,b.pesoRacimo,
dd.tiquete , a.remision, dd.pesoNeto, dd.fecha fechaTIQ, dd.vehiculo, dd.remolque,dd.racimos racimosTIQ,dd.terceroExtractrora idExtractora,
h.razonSocial desExtractora, i.nit, i.razonSocial, b.fecha fechaLabor,b.registro regLote, j.descripcion desLote,d.claseLabor,
k.descripcion desTipoTransaccion
 from aTransaccion a
join aTransaccionNovedad b on a.numero=b.numero and a.tipo=b.tipo and a.empresa=b.empresa
join aTransaccionTercero c on a.numero=c.numero and c.tipo=a.tipo and  c.empresa=a.empresa
join aTransaccionBascula dd on a.numero = dd.numero and dd.tipo = a.tipo and dd.empresa =a.empresa and b.novedad=c.novedad and c.registroNovedad=b.registro
join aNovedad d on b.novedad=d.codigo and d.empresa=b.empresa
join cTercero e on e.id=c.tercero and e.empresa=c.empresa
join aFinca f on a.finca=f.codigo and a.empresa=f.empresa
join aLotes j on j.codigo=b.lote and j.empresa=b.empresa
join gTipoTransaccion	k on k.codigo=a.tipo and k.empresa=a.empresa
left join aSecciones g on g.codigo=b.seccion and g.empresa=b.empresa
join cTercero h on h.id=dd.terceroExtractrora and h.empresa=dd.empresa 
join gEmpresa i on i.id = a.empresa
where a.fecha between @fechaInicial and @fechaFinal and a.anulado=0
and dd.tiquete like '%'+@tiquete+'%' and a.empresa=@empresa
order by d.claseLabor, numero