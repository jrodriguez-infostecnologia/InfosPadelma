create proc spSeleccionaOperadoresLogistico
@empresa int
as

select tercero, descripcion from nFuncionario
where operadorLogistico=1