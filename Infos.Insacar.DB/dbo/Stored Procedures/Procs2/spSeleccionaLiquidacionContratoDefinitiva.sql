CREATE proc [dbo].[spSeleccionaLiquidacionContratoDefinitiva]
@empresa int,
@numero varchar(50)
as

select distinct  
j.codigo identificacion, j.id codTercero, j.descripcion nombreTercero, 
c.ccosto codCCosto,
 d.descripcion nombreCcosto, 
 --c.salario sueldo,
  CASe when i.codigo='03' and b.concepto=nn.cesantias then b.valorUnitario else c.salario end sueldo,
m.descripcion nombreCargo, b.concepto codConcepto, 
k.descripcion  nombreConcepto, 
--sum(b.cantidad) cantidad,
--sum(case when k.signo=2 then  b.valorTotal *-1 else b.valorTotal end) valorTotal,
b.cantidad,
case when k.signo=2 then  b.valorTotal *-1 else b.valorTotal end valorTotal,
b.valorUnitario,
 case when  b.saldo=0 then null else b.saldo end saldo, b.noPeriodo, 
 case when k.mostrarFecha=1 then b.fechaInicial else null end fecha, b.fechaInicial, b.fechaFinal, a.año,
  a.mes,  
   n.descripcion nombreDepartamento, c.departamento codDepto, k.signo, a.empresa, 
   k.prioridad, k.mostrarFecha, k.noMostrar, 
d.mayor cCostoMayor,
c.fechaIngreso,isnull(c.fechaRetiro, c.fechaContratoHasta) fechaRetiro, 
 i.descripcion nombreClaseContrato,i.codigo, 
 g.descripcion motivoRetiro,
k.prestacionSocial, case when c.auxilioTransporte=1 then h.vAuxilioTransporte else 0 end auxilioTransporte,
hh.razonSocial AS nombreEPS, CASE WHEN c.entidadPension = '' THEN '' ELSE ii.razonSocial END AS nombrePension
from nLiquidacionNomina a
join nLiquidacionNominaDetalle b on b.numero=a.numero and b.tipo=a.tipo and a.empresa=b.empresa
join nContratos c on c.tercero=b.tercero and c.id=b.contrato and c.empresa=a.empresa
join cCentrosCosto d on d.codigo=b.ccosto and c.empresa=a.empresa
join nPeriodoDetalle e on e.noPeriodo=b.noPeriodo and e.año=b.año and e.empresa=b.empresa
 join nProrroga f on f.contrato=b.contrato and f.tercero=b.tercero and f.empresa=a.empresa and f.tipo='R' 
 join nMotivoRetiro g on g.codigo= f.motivoRetiro and g.empresa=f.empresa
join nParametrosAno h on h.empresa=a.empresa and h.ano=a.año
join nClaseContrato i on i.codigo=c.claseContrato and i.empresa=c.empresa
join cTercero j on j.id=b.tercero and j.empresa=b.empresa
join nConcepto k on k.codigo=b.concepto and k.empresa=b.empresa
 join nCargo m on m.codigo=c.cargo and m.empresa=c.empresa
 join nParametrosGeneral nn on nn.empresa=a.empresa
 join nDepartamento n on n.codigo=c.departamento and n.empresa=c.empresa
LEFT JOIN dbo.nEntidadEps AS jj ON jj.codigo = c.entidadEps AND jj.empresa = c.empresa 
LEFT JOIN dbo.nEntidadFondoPension AS kk ON kk.codigo = c.entidadPension AND kk.empresa = c.empresa
LEFT OUTER JOIN dbo.cTercero AS hh ON hh.id = jj.tercero AND hh.empresa = e.empresa 
LEFT OUTER JOIN dbo.cTercero AS ii ON ii.id = kk.tercero AND ii.empresa = e.empresa 
where  a.empresa=@empresa and a.anulado=0 and a.numero like  '%'+@numero+'%' and a.tipo='LQC'
--group by j.codigo , j.id , j.descripcion , 
--c.ccosto ,d.descripcion , 
-- i.codigo, b.concepto,nn.cesantias, b.valorUnitario , c.salario,
--m.descripcion , b.concepto , 
--k.descripcion  ,k.signo,b.valorUnitario,
--  b.saldo, b.noPeriodo, 
--  k.mostrarFecha,b.fechaInicial , b.fechaInicial, b.fechaFinal, a.año,
--  a.mes,  
--   n.descripcion , c.departamento , k.signo, a.empresa, 
--   k.prioridad, k.mostrarFecha, k.noMostrar, 
--d.mayor ,c.fechaIngreso,isnull(c.fechaRetiro, c.fechaContratoHasta) , 
-- i.descripcion ,i.codigo, 
-- g.descripcion ,
--k.prestacionSocial,  c.auxilioTransporte, h.vAuxilioTransporte,
--hh.razonSocial ,  c.entidadPension , ii.razonSocial 
order by nombreConcepto