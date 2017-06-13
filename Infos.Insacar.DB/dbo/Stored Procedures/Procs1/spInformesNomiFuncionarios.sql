CREATE proc [dbo].[spInformesNomiFuncionarios]
@empresa int
as
select a.codigo,a.tercero idTercero, a.descripcion, a.fechaNacimiento, b.nombre ciudadNacimiento, a.sexo , a.rh GS ,
c.descripcion nivelEducativo, e.codigo codCargo, e.descripcion nombreCargo,
f.codigo codCCosto,f.descripcion nombreCcosto, d.fechaIngreso,d.fechaRetiro,d.salario,g.descripcion nombreEps,h.descripcion nombrePension,
i.descripcion nombreARP, j.descripcion nombreCaja, k.descripcion nombreCalseContrato,case when  a.activo = 1 then 'activo' else 'no activo' end estado,
l.direccion,case when  d.mSindicato=1 then 'X' else '' end sindical,case when  d.mFondoEmpleado=1 then 'X' else '' end fondoEmpleado,
case when  d.pactoColectivo=1 then 'X' else '' end pactoColectivo,l.telefono,case when  a.contratista=1 then 'X' else '' end contratista,
case when  d.auxilioTransporte=1 then 'X' else '' end  transporte
from nFuncionario a
join cTercero l on l.id=a.tercero and l.empresa=a.empresa
left join nContratos d on d.tercero=a.tercero and d.empresa =a.empresa
left join gCiudad b on a.ciduadNacimiento =b.codigo and a.empresa=b.empresa
left join gNivelEducativo c on a.nivelEducativo=c.codigo and c.empresa=b.empresa 
left join nCargo e on e.codigo=d.cargo and e.empresa=d.empresa
left join cCentrosCosto f on f.codigo=d.ccosto and f.empresa=d.empresa
left join nEntidadEps g on g.codigo=d.entidadEps and g.empresa=d.empresa
left join nEntidadFondoPension h on h.codigo=d.entidadPension and h.empresa=d.empresa
left join nEntidadArp i on i.codigo=d.entidadArp and i.empresa=d.empresa
left join nEntidadCaja j on j.codigo=d.entidadCaja and j.empresa=d.empresa
left join nClaseContrato k on k.codigo=d.claseContrato and k.empresa=d.empresa
where a.empresa=@empresa