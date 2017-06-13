CREATE proc [dbo].[spSeleccionaInformeGeneralLaboresAgronomicos]
@fechaInicial date,
@fechaFinal date,
@empresa int
as

select a.*, b.descripcion contratista  from vSeleccionaTransaccionesAgronomico a 
left join 
(select a.tercero,  b.descripcion, a.empresa  from nFuncionario a join  cxpProveedor b on a.proveedor=b.idTercero and a.empresa = b.empresa
where a.contratista=1 and a.empresa=@empresa)  b on a.idTercero=b.tercero and a.codEmpresa=b.empresa
where fechaTransaccion between @fechaInicial and @fechaFinal
and anulado=0 and a.codEmpresa=@empresa