CREATE proc [dbo].[spSeleccionaLotesPorFincaSeccion]
@empresa int
as


select a.codigo codFinca, a.descripcion nombreFinca, a.hectareas HaFinca,f.codigo codPropietario, f.razonSocial nombrePropietario, a.zonaGeografica, d.nombre nombreCiudad,
b.codigo codSeccion, b.descripcion nombreSeccion, b.hBrutas HaSeccion, c.codigo codLote, c.descripcion nombreLote, convert(varchar(4),añoSiembra) + '-'+  rtrim(RIGHT('00' + rtrim(mesSiembra), 2))   siembra,palmasBrutas,palmasProduccion,c.hBrutas haLotes ,hNetas,dSiembra,
densidad,e.descripcion nombreVariedad , e.procedencia procedenciaVariedad , isnull(sum(g.noPalma),c.palmasProduccion) noPalmas,
c.activo estado 
from aFinca a
left join aLotes c on c.finca=a.codigo  and c.empresa=a.empresa
left join aSecciones b on b.finca=a.codigo and c.seccion=b.codigo and b.empresa=a.empresa
left join gCiudad d on d.codigo=a.ciudad and d.empresa=a.empresa
left join aVariedad e on e.codigo=c.variedad and e.empresa=c.empresa
left join cTercero f on f.id=a.proveedor and f.empresa=a.empresa
left join aLotesDetalle g on g.lote=c.codigo and g.empresa=c.empresa
where a.empresa=@empresa
group by a.codigo , a.descripcion , a.hectareas ,f.codigo , f.razonSocial , a.zonaGeografica, d.nombre ,
b.codigo , b.descripcion , b.hBrutas , c.codigo , c.descripcion ,añoSiembra,mesSiembra,palmasBrutas,palmasProduccion,c.hBrutas  ,hNetas,dSiembra,
densidad,e.descripcion  , e.procedencia,c.activo