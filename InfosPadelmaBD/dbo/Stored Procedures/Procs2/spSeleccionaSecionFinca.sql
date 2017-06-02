CREATE proc [dbo].[spSeleccionaSecionFinca]
@codigo varchar(50),
@empresa int
as

select * from aSecciones
where finca=@codigo and empresa=@empresa and activo=1
order by descripcion