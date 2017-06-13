CREATE proc [dbo].[spSeleccionaVacacionesxEmpleado]
@empresa int,
@empleado int,
@periodoInicial date,
@periodoFinal date,
@registro int
as

select  distinct 
convert(varchar(10), a.periodoInicial,111) +' - '+convert(varchar(10),b.periodoFinal,111) periodoPagado ,
a.*, 
c.descripcion desConcepto, 
c.codigo idConcepto, 
b.signo,
b.valorTotal valorTotal,
b.valorUnitario,
d.codigo idEmpleado,
d.descripcion desEmpleado,
f.codigo codCcosto,
f.descripcion desCcosto, 
g.codigo codDepartamento ,
g.descripcion desDepartamento,
e.salario ,
h.descripcion entidad
from nVacaciones a left join nVacacionesDetalle b on 
	a.periodoFinal=b.periodoFinal and a.periodoInicial=b.periodoInicial and a.empleado=b.empleado
	and a.registro=b.registro 
	and a.empresa=b.empresa 
	left join nConcepto c on b.concepto = c.codigo and c.empresa=b.empresa
	join nFuncionario d on d.tercero = a.empleado and d.empresa=a.empresa
	join nContratos  e on a.empleado = e.tercero and e.empresa=a.empresa and e.activo=1
	join cCentrosCosto f on f.codigo = e.ccosto and f.empresa=a.empresa
	join nDepartamento g on e.departamento = g.codigo and g.empresa=a.empresa
	left join cTercero h on h.id=b.entidad and h.empresa=a.empresa
	where a.empleado=@empleado and  a.empresa=@empresa
	and b.periodoInicial=@periodoInicial and b.periodoFinal=@periodoFinal
	and a.registro=@registro