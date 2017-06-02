CREATE proc [dbo].[spInformeFuncionariosContratos]
@empresa int,
@activo int
as

if @activo=1
begin
select a.id, b.tercero idTercero,b.codigo, b.descripcion, a.id NoContrato, c.descripcion ccosto, d.descripcion departamento ,
a.fechaIngreso, e.descripcion TipoContrato,  a.diasContrato duracion, a.fechaContratoHasta,
f.descripcion FondoCesantias,
g.descripcion Arp,
h.descripcion Caja,
i.descripcion Eps,
j.descripcion FondoPension,
a.salario,
k.descripcion banco,
l.descripcion tipoCuenta,
a.cuentaBancaria 
 from ncontratos a
join nFuncionario b on b.tercero=a.tercero and a.empresa=b.empresa
left join cCentrosCosto c on a.ccosto =c.codigo and a.empresa=c.empresa
left join nDepartamento d on a.departamento=d.codigo and a.empresa=d.empresa 
left join nClaseContrato e on a.claseContrato=e.codigo and a.empresa=e.empresa
left join nEntidadAfc f on a.entidadCesantias=f.codigo and a.empresa=f.empresa
left join nEntidadArp g on a.entidadArp = g.codigo and a.empresa=g.empresa
left join nEntidadCaja h on a.entidadCaja=h.codigo and a.empresa=h.empresa
left join nEntidadEps i on a.entidadEps = i.codigo and a.empresa=i.empresa 
left join nEntidadFondoPension j on a.entidadPension = j.codigo and a.empresa =j.empresa
left join gBanco k on a.banco=k.codigo and a.empresa=k.empresa
left join gTipoCuenta l on a.tipoCuenta =l.codigo and a.empresa=l.empresa
where a.empresa=@empresa and a.activo=1
end


if @activo=2
begin
select a.id, b.tercero idTercero,b.codigo, b.descripcion, a.id NoContrato, c.descripcion ccosto, d.descripcion departamento ,
a.fechaIngreso, e.descripcion TipoContrato,  a.diasContrato duracion, a.fechaContratoHasta,
f.descripcion FondoCesantias,
g.descripcion Arp,
h.descripcion Caja,
i.descripcion Eps,
j.descripcion FondoPension,
a.salario,
k.descripcion banco,
l.descripcion tipoCuenta,
a.cuentaBancaria 
 from ncontratos a
join nFuncionario b on b.tercero=a.tercero and a.empresa=b.empresa
left join cCentrosCosto c on a.ccosto =c.codigo and a.empresa=c.empresa
left join nDepartamento d on a.departamento=d.codigo and a.empresa=d.empresa 
left join nClaseContrato e on a.claseContrato=e.codigo and a.empresa=e.empresa
left join nEntidadAfc f on a.entidadCesantias=f.codigo and a.empresa=f.empresa
left join nEntidadArp g on a.entidadArp = g.codigo and a.empresa=g.empresa
left join nEntidadCaja h on a.entidadCaja=h.codigo and a.empresa=h.empresa
left join nEntidadEps i on a.entidadEps = i.codigo and a.empresa=i.empresa 
left join nEntidadFondoPension j on a.entidadPension = j.codigo and a.empresa =j.empresa
left join gBanco k on a.banco=k.codigo and a.empresa=k.empresa
left join gTipoCuenta l on a.tipoCuenta =l.codigo and a.empresa=l.empresa
where a.empresa=@empresa  and a.activo=0
end


if @activo=3
begin
select a.id, b.tercero idTercero,b.codigo, b.descripcion, a.id NoContrato, c.descripcion ccosto, d.descripcion departamento ,
a.fechaIngreso, e.descripcion TipoContrato,  a.diasContrato duracion, a.fechaContratoHasta,
f.descripcion FondoCesantias,
g.descripcion Arp,
h.descripcion Caja,
i.descripcion Eps,
j.descripcion FondoPension,
a.salario,
k.descripcion banco,
l.descripcion tipoCuenta,
a.cuentaBancaria 
 from ncontratos a
join nFuncionario b on b.tercero=a.tercero and a.empresa=b.empresa
left join cCentrosCosto c on a.ccosto =c.codigo and a.empresa=c.empresa
left join nDepartamento d on a.departamento=d.codigo and a.empresa=d.empresa 
left join nClaseContrato e on a.claseContrato=e.codigo and a.empresa=e.empresa
left join nEntidadAfc f on a.entidadCesantias=f.codigo and a.empresa=f.empresa
left join nEntidadArp g on a.entidadArp = g.codigo and a.empresa=g.empresa
left join nEntidadCaja h on a.entidadCaja=h.codigo and a.empresa=h.empresa
left join nEntidadEps i on a.entidadEps = i.codigo and a.empresa=i.empresa 
left join nEntidadFondoPension j on a.entidadPension = j.codigo and a.empresa =j.empresa
left join gBanco k on a.banco=k.codigo and a.empresa=k.empresa
left join gTipoCuenta l on a.tipoCuenta =l.codigo and a.empresa=l.empresa
where a.empresa=@empresa 
end