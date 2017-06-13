create proc spSeleccionaConceptosClase
@clase int,
@empresa int
as

select * from cConceptoIR
where clase=@clase
and empresa=@empresa