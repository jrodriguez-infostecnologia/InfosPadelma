CREATE proc spSeleccionaTiquetesNoRegistrados
@empresa int,
@fi date,
@ff date
as

select convert(date,fechaProceso) fecha, tiquete, vehiculo,remolque, pesoNeto, racimos, b.descripcion nombreFinca, a.finca from bRegistroBascula a
join aFinca b on b.codigo=a.finca and b.empresa=a.empresa
where 
 tipo='EMP'
and finca in (select distinct codigoEquivalencia from aFinca where empresa=@empresa and codigoEquivalencia is not null)
and tiquete not in (select distinct tiquete from aTransaccion a join aTransaccionBascula b on b.tipo=a.tipo
and b.numero=a.numero and b.empresa=a.empresa where a.anulado=0 and a.empresa=@empresa)
and CONVERT(date, fechaProceso) between @fi and @ff and a.tiquete<>''