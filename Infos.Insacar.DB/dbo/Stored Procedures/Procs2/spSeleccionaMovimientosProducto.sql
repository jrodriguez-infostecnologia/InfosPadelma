create proc [dbo].[spSeleccionaMovimientosProducto]
@producto varchar(50),
@empresa int
as

select *,0 valor from pProductoMovimiento a
join iItems b on b.codigo=a.movimiento and b.empresa=a.empresa
where a.producto=@producto
and a.empresa=@empresa
order by a.orden