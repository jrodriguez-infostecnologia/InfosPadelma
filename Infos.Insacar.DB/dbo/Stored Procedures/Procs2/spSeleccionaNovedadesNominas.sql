CREATE proc spSeleccionaNovedadesNominas
@empresa int,
@fi date,
@ff date
as

select a.tipo,a.numero,a.fecha,a.ccosto,e.descripcion nombreCcosto,a.anulado,a.fechaRegistro,a.fechaAnulado,a.usuarioRegistro,a.usuarioAnulado,b.añoFinal,b.añoInicial,b.periodoInicial,b.periodoFinal,
b.concepto,c.descripcion nombreConcepto,b.empleado, d.descripcion nombreTercero,b.cantidad,b.valor,b.detalle from nNovedades a
join nNovedadesDetalle b on b.numero=a.numero and b.empresa=a.empresa and b.tipo=a.tipo
join nConcepto c on c.codigo=b.concepto and c.empresa=b.empresa
join cTercero d on d.id=b.empleado and d.empresa=b.empresa
left join cCentrosCosto e on e.empresa=a.empresa and e.codigo=a.ccosto
where a.empresa=@empresa and convert(date,a.fecha) between  @fi and @ff --and a.anulado=0 and b.anulado=0