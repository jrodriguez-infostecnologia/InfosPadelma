create proc [dbo].[spSeleccionaRemolquesPropios]
@empresa int
as


select * from bVehiculo a
join bTipoVehiculo b on b.codigo=a.tipo and b.empresa=a.empresa
where a.activo=1 and b.aplicaRemolque=0