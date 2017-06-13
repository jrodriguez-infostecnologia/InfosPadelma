create proc spSeleccionaLotesPorFinca
@empresa int
as


select a.codigo codFinca, a.descripcion nombreFinca, a.hectareas HaFinca,f.codigo codPropietario, f.descripcion nombrePropietario, a.zonaGeografica, d.nombre nombreCiudad,
b.codigo codSeccion, b.descripcion nombreSeccion, b.hBrutas HaSeccion, c.codigo codLote, c.descripcion nombreLote, añoSiembra + '-'+mesSiembra,palmasBrutas,palmasProduccion,c.hBrutas haLotes ,hNetas,dSiembra,
densidad,e.descripcion nombreVariedad , e.procedencia procedenciaVariedad  from aFinca a
left join aSecciones b on b.finca=a.codigo and b.empresa=a.empresa
left join aLotes c on c.finca=a.codigo and c.seccion=b.codigo and c.empresa=a.empresa
left join gCiudad d on d.codigo=a.ciudad and d.empresa=a.empresa
left join aVariedad e on e.codigo=c.variedad and e.empresa=c.empresa
left join cTercero f on f.id=a.proveedor and f.empresa=a.empresa
where a.empresa=@empresa