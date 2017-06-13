CREATE proc [dbo].[spSeleccionaTiquetesBasculaExtractora]
@extractora int,
@empresa int,
@tiquete varchar(50)
as

select	a.empresa,
tipo,	numero,convert(date,fechaProceso) fecha	,tiquete	,remision,	pesoBruto	,pesoDescuento	,pesoTara,	
pesoNeto - pesoDescuento pesoNeto	,fechaBruto,	fechaTara	,fechaNeto,	estado,
	tipoVehiculo,	vehiculo,	remolque,	item,	procedencia,finca,	usuario,	fechaProceso,	racimos,	bodega,	sacos,	urlTiquete,	analisisRegistrado,	pesoSacos,	sellos,	tipoDescargue,	codigoConductor,	nombreConductor	,a.tercero,	vehiculoInterno,
b.tercero extractora, c.descripcion nombreFinca, c.codigo idFinca from bRegistroBascula  a 
join gempresa b on a.empresa = b.id
join aFinca c on c.codigoEquivalencia=a.finca and c.empresa=@empresa
where b.id = @extractora 
and tipo in ('EMP') and pesoneto<>0
and tiquete not in (select distinct tiquete from vSeleccionaTransaccionTiquete where empresa=@empresa and anulado=0 and tiquete is not null)
and tiquete like '%'+ @tiquete+'%'