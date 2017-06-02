CREATE proc [dbo].[spSeleccionaTrabajadoresActivosNomina]
@empresa int
as

select a.tercero,
 f.descripcion  NombreEmpleado,
 f.nit,
a.fechaIngreso ,
a.departamento idDepartamento,
c.descripcion departamento,
d.descripcion cargo,
a.salario , b.codigo idCcosto, b.descripcion ccosto,
g.codigo idMayor, g.descripcion mayorCcosto
 from nContratos a
join cCentrosCosto b on a.ccosto = b.codigo  and a.empresa =b.empresa 
join nDepartamento c on a.departamento = c.codigo and c.empresa =a.empresa
join nCargo d on a.cargo =d.codigo and d.empresa = a.empresa 
join cTercero f on a.tercero = f.id and a.empresa =f.empresa
left join cCentrosCosto  g on b.mayor = g.codigo and g.nivel =1 and g.empresa=b.empresa
join nFuncionario h on a.tercero = h.tercero  and h.empresa = a.empresa
where a.activo =1 and h.activo = 1
and a.empresa=@empresa