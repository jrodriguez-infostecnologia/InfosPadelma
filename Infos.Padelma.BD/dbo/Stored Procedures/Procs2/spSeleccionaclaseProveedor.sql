create proc [dbo].[spSeleccionaclaseProveedor]
@clase int,
@tercero int,
@proveedor varchar(10),
@empresa int
as

select * from cxpProveedorCalseIR
where clase=@clase
and proveedor=@proveedor
and tercero=@tercero
and empresa=@empresa