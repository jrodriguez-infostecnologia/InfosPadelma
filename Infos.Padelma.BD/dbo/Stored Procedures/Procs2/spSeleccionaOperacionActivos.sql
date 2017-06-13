create proc spSeleccionaOperacionActivos
as

select * from sOperaciones
where activo=1