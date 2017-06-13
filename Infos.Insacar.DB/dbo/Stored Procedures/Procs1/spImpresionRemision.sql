CREATE PROCEDURE [dbo].[spImpresionRemision]
	@despacho	varchar(50)	,
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


	select 
	b.cliente,
	isnull(c.descripcion,'No existe tercero en el sistema comunicarse con Sistemas') as nombreCliente,
	c.direccion,
	b.lugarEntrega,
	b.comercializadora,
	d.descripcion as descripcionComercializadora,
	a.fecha,
	rtrim( b.numero ) as numero,
	rtrim( b.remision ) as remision,
	rtrim( b.tiquete ) as tiquete,
	upper( g.descripcion ) as producto,
	a.sellos,
	a.pesoBruto,
	dbo.f_numeroletras(pesoBruto) letraBruto,
	dbo.f_numeroletras(pesoTara) letraTara,
	dbo.f_numeroletras(pesoNeto) letraNeto,
	a.pesoTara,
	a.pesoNeto,
	e.codigoConductor   idConductor,
	e.nombreConductor nombreConductor,
	a.vehiculo,
	a.sacos,
	b.remisionComercializadora	,
	h.razonSocial desPlanta,
	rtrim(h.codigo) +  ' - ' + h.dv idPlanta,
	h.fax faxPlanta,	
	h.telefono telPlanta,
	h.direccion dirPlanta,
	h.contacto contactoPlanta,
	i.nombre + ' - ' + j.descripcion CiudadPlanta,
	convert(varchar(50),convert(int,(substring(b.remision,5,LEN(b.remision))))) noDespacho
	from bRegistroBascula a
	join 	logDespacho b on a.tipo = b.tipo and a.numero = b.numero and a.empresa=b.empresa
	left join cTercero c on b.cliente = c.id and b.empresa=c.empresa
	left join cTercero d on b.comercializadora = d.id and d.empresa=b.empresa
	join iItems g on a.item = g.codigo and g.empresa=a.empresa
	join bRegistroPorteria e on e.numero=a.remision and e.empresa=a.empresa
	left join cTercero h on h.id=b.planta and h.empresa=b.empresa
	left join gCiudad i on i.codigo=h.ciudad and i.empresa=h.empresa
	left join gPais j on j.codigo=i.pais and j.empresa=i.empresa
	where a.numero = @despacho