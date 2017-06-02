create proc spSeleccionaCcostoInforme
@empresa int 
as


select * from cCentrosCosto
where empresa=@empresa