CREATE proc spSeleccionaProgramacionesFecha
@empresa int,
@fi date,
@ff date
as

select a.fecha,a.fechaDespacho,c.codigo IdCliente,c.descripcion DesCliente,
b.descripcionAbreviada desProducto, a.planta,a.estado,a.cantidad, a.vehiculo,a.remolque, a.codigoConductor,a.nombreConductor from logProgramacionVehiculo a
join iItems b on b.codigo=a.producto and b.empresa=a.empresa
join cTercero c on c.id =a.cliente
where a.empresa=@empresa and fecha between @fi and @ff