CREATE proc [dbo].[spSeleccionaOperadoresLogistico]
@empresa int
as

select tercero, descripcion, codigo from nFuncionario
where operadorLogistico=1