CREATE PROCEDURE [dbo].[spSeleccionaBasculaDetalle]
	@fechaI	date,
	@fechaF	date,
	@empresa int
AS
/***************************************************************************
Nombre: spSeleccionaBasculaDetalle
Tipo: Procedimiento Almacenado
Desarrollado: Infos Tecnologia SAS

Argumentos de entrada: Fecha inicial, fecha final
Argumentos de salida: 
Descripción: Selecciona la báscula completa
*****************************************************************************/

	select convert( datetime,convert(varchar(50),a.fecha,103),103 ) as fecha,
	a.tipo,a.numero,a.tiquete,a.remision,a.pesoBruto,a.pesoTara,
	a.pesoNeto,a.fechaBruto,a.fechaTara,a.fechaNeto,a.estado,a.tipoVehiculo,
	a.vehiculo,a.remolque,a.item producto,h.descripcion desProducto, isnull(a.procedencia,d.descripcion) procedencia ,
	a.finca as codFinca,e.descripcion as Finca,a.usuario funcionario,a.fechaProceso,
	a.racimos,a.bodega,a.sacos,a.urlTiquete,a.analisisRegistrado,a.pesoSacos,
	a.sellos,a.tipo cooperativa
	,a.codigoConductor ,a.nombreConductor,f.descripcion as proveedor,c.cliente,d.descripcion,c.lugarEntrega,
	a.pesoDescuento, a.pesoNeto-a.pesoDescuento as pesoTotal, c.cliente
	from bRegistroBascula a
	left join logdespacho c on c.numero=a.numero and c.tipo=a.tipo and c.empresa=a.empresa
	LEFT JOIN aFinca e on e.codigo=a.finca and e.empresa=a.empresa
	left join cTercero d on d.id=c.cliente and d.empresa=c.empresa
	left join bProcedencia g on g.codigo=a.procedencia and g.empresa=a.empresa
	left join cTercero f on f.id=g.proveedor and f.empresa=g.empresa
	left join iItems h on h.codigo=a.item and h.empresa=a.empresa
	where	
	convert( date,a.fechaProceso) between @fechaI and @fechaF and a.empresa=@empresa

	order by fecha