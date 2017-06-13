CREATE proc [dbo].[spSeleccionaclaseCliente]
@clase int,
@tercero int,
@cliente varchar(10),
@empresa int
as

select * from cxcClienteClaseIR
where clase=@clase
and cliente=@cliente
and tercero=@tercero
and empresa=@empresa