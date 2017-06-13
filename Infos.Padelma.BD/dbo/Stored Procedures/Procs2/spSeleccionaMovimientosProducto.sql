CREATE proc [dbo].[spSeleccionaMovimientosProducto]
@producto varchar(50),
@empresa int,
@modulo varchar(150)
as

select *,0 valor from pProductoMovimiento a
join iItems b on b.codigo=a.movimiento and b.empresa=a.empresa
where a.producto=@producto and a.modulo=@modulo
and a.empresa=@empresa
order by a.orden