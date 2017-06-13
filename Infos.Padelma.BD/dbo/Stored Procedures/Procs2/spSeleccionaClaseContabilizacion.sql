CREATE proc [dbo].[spSeleccionaClaseContabilizacion]
@empresa int
as


select * from cClaseParametroContaNomi
where empresa=@empresa