CREATE proc [dbo].[spRetornaDatosTercerosVacaciones]
@empresa int,
@empleado int
as
select c.codigo, c.descripcion, b.codigo, b.descripcion, a.salario from nContratos a join nDepartamento b on a.departamento=b.codigo 
and a.empresa=b.empresa
join cCentrosCosto c on c.codigo=a.ccosto  and c.empresa=a.empresa
where a.empresa=@empresa and a.tercero=@empleado