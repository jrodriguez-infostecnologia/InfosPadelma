CREATE proc spSeleccionaFincaLotes
@codigo varchar(50),
@empresa int
as

select * from aLotes
where finca=@codigo and empresa=@empresa and activo=1
order by descripcion