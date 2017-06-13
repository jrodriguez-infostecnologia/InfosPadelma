CREATE PROCEDURE [dbo].[spImpresionRemision]
	@tiquete	varchar(50)	,
	@empresa int
AS
/***************************************************************************
Nombre: spImpresionOrdenEnvio
Tipo: Procedimiento Almacenado
Desarrollado: Infos Tecnologia SAS

Argumentos de entrada: Número despacho
Argumentos de salida: 
Descripción: Selecciona los datos para la impresión de despachos por orden de 
		     envío
*****************************************************************************/


DECLARE @cadena varchar(1000)

SELECT @cadena= COALESCE(@cadena + '-', '') + Sello FROM lRegistroSellos a
join bRegistroBascula b on b.numero=a.numero and b.tipo=a.tipo and b.empresa=a.empresa
where b.tiquete=@tiquete and a.empresa=@empresa and a.anulado=0


	select 
	b.cliente,
	isnull(c.descripcion,'No existe tercero en el sistema comunicarse con Sistemas') as nombreCliente,
	c.direccion,
	 gg.descripcion  lugarEntrega,
	b.comercializadora,
	d.descripcion as descripcionComercializadora,
	a.fechaProceso fecha,
	rtrim( a.numero ) as numero,
	rtrim( a.remision ) as remision,
	rtrim( a.tiquete ) as tiquete,
	upper( g.descripcion ) as producto,
	@cadena sellos,
	a.pesoBruto,
	dbo.f_numeroletras(pesoBruto) letraBruto,
	dbo.f_numeroletras(pesoTara) letraTara,
	dbo.f_numeroletras(pesoNeto) letraNeto,
	a.pesoTara,
	a.pesoNeto,
	b.codigoConductor   idConductor,
	b.nombreConductor nombreConductor,
	a.vehiculo,
	a.sacos,
	a.remisionComercializadora	,
	h.razonSocial desPlanta,
	rtrim(h.codigo) +  ' - ' + h.dv idPlanta,
	h.fax faxPlanta,	
	h.telefono telPlanta,
	h.direccion dirPlanta,
	h.contacto contactoPlanta,
	i.nombre + ' - ' + j.descripcion CiudadPlanta,
	convert(varchar(50),convert(int,(substring(a.remisionPlanta,5,LEN(a.remisionPlanta))))) noDespacho,
	b.numero numeroProgramacion
	from bRegistroBascula a
	join logProgramacionVehiculo b on a.numero = b.despacho and a.remision =b.numero and a.empresa=b.empresa
	join cTercero d on b.comercializadora = d.id and d.empresa=b.empresa
	join cTercero c on b.tercero = c.id and b.empresa=c.empresa
	join cxcCliente gg on gg.codigo=b.cliente and gg.idTercero=b.tercero and gg.empresa=b.empresa
	join iItems g on a.item = g.codigo and g.empresa=a.empresa
	left join cTercero h on h.id=b.planta and h.empresa=b.empresa
	left join gCiudad i on i.codigo=h.ciudad and i.empresa=h.empresa
	left join gPais j on j.codigo=i.pais and j.empresa=i.empresa
	where a.tiquete = @tiquete and a.empresa=@empresa