CREATE proc spSeleccionaLaboresNoPagadasNominas
@empresa int,
@fi date,
@ff date
as

select a.fecha,d.tercero codTercero,d.descripcion nombreTercero, c.lote,c.novedad,e.descripcion nombreNovedad, c.cantidad,c.precioLabor,c.cantidad*c.precioLabor as valorTotal from aTransaccion a
join aTransaccionNovedad b on b.numero=a.numero and b.tipo=a.tipo
join aTransaccionTercero c on c.numero=b.numero and c.tipo=a.tipo and c.registroNovedad=b.registro
join nFuncionario d on d.tercero=c.tercero and d.empresa=c.empresa
join aNovedad e on e.codigo=c.novedad and e.empresa=c.empresa
where anulado=0 and c.ejecutado=0 and d.contratista=0
and a.fecha between @fi and @ff and a.empresa=@empresa