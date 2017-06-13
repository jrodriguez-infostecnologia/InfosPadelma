create proc spSeleccionaLaboresEmpresa
@empresa int
as


select * from vSeleccionaLabores
where empresa=@empresa