CREATE proc  spSeleccionaLoteCanalInforme
@empresa int
as

select finca,d.descripcion desFinca,a.codigo codigoLote,seccion,a.descripcion descripcionLote,añoSiembra,palmasBrutas,
palmasProduccion,hBrutas,hNetas,dSiembra,densidad,NoLineas,desarrollo,registro,tipoCanal,c.descripcion desTipoCanal,metros from aLotes a
join aLotesCanal b on b.lote=a.codigo and b.empresa=a.empresa
join aTipoCanal c on c.codigo=b.tipoCanal and c.empresa=b.empresa
join aFinca d on d.codigo=a.finca and d.empresa=a.empresa
where a.empresa=@empresa