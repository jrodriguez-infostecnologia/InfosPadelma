CREATE proc [dbo].[spSeleccionaParametrizacionCon]
@empresa int
as

select distinct a.id, a.tipo, a.clase idClase, b.descripcion Clase, 
isnull(a.concepto,ee.codigo) idConcepto, isnull(e.descripcion,ee.descripcion) concepto,
d.codigo idMCCNomi, d.descripcion MCcostoNomi,
a.cCosto idccostoNomi, c.descripcion ccostoNomi,
f.codigo idDep, f.descripcion deparmatamento,
g.codigo idCuentaGasto, g.nombre CuentaGasto,
h.codigo idCuentaActivo, h.nombre cuentaActivo,
i.codigo idCuentaCon, i.nombre CuentaContratista,
j.codigo idCuentCred, j.nombre Cuentacredito,
k.codigo idCCMayorSigo, k.descripcion CCMayorSigo,
l.codigo idCCSigo, l.descripcion CCSigo,
m.codigo idCCCred, m.descripcion CCCredito,
a.tercero,
a.terceroCredito
 from 
cParametroContaNomi a join cClaseParametroContaNomi b on a.clase = b.codigo and a.empresa=b.empresa
left join cCentrosCosto c on a.cCosto = c.codigo and a.empresa=c.empresa
left join cCentrosCosto d on a.cCostoMayor = d.codigo and a.empresa=d.empresa
left join nConcepto e on a.concepto =e.codigo and a.empresa=e.empresa
left join aNovedad ee on a.concepto = 'L'+ee.codigo and a.empresa=ee.empresa
left join nDepartamento f on a.departamento = f.codigo and f.empresa=a.empresa
left join cPuc g on a.cuentaGasto = g.codigo and a.empresa=g.empresa 
left join cPuc h on a.cuentaActivo = h.codigo and a.empresa=h.empresa
left join cpuc i on a.cuentaContratista = i.codigo and a.empresa=i.empresa
left join cpuc j on a.cuentaCredito = j.codigo and j.empresa=a.empresa
left join cCentrosCostoSigo k on a.cCostoMayorSigo = k.codigo and a.empresa=k.empresa 
left join cCentrosCostoSigo l on a.cCostoSigo = l.codigo and a.empresa=l.empresa and l.mayor=a.cCostoMayorSigo
left join cCentrosCostoSigo m on a.ccostoMayorCredito =m.codigo and a.empresa=m.empresa
left join cCentrosCostoSigo o on a.cCostoCredito = o.codigo and o.empresa=a.empresa
where a.empresa=@empresa