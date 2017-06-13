create proc spSeleccionaCcosto
@empresa int,
@auxiliar bit
as


select * from cCentrosCosto
where activo=1 and empresa=@empresa and auxiliar=@auxiliar