create proc spSeleccionaContratosDestajos
@empresa int
as

select a.empresa,a.id contrato, a.tercero, b.codigo ,b.descripcion,a.fechaIngreso,c.nombreGrupoLabor,a.cantidadDestajo, sum(cantidadTercero) cantidadLabores,a.cantidadDestajo- sum(cantidadTercero) Diferencia from nContratos a
join cTercero b on b.id=a.tercero and b.empresa=a.empresa
join vTransaccionAgronomico c on c.idTercero=a.tercero and c.contrato=a.id 
and c.codEmpresa=a.empresa and a.grupoLaborDestajo=c.codGrupoLabor and c.anulado=0
where a.manejaDestajo=1 and a.activo=1 and a.empresa=@empresa
group by a.id , a.tercero, b.codigo ,b.descripcion,a.cantidadDestajo,a.fechaIngreso,c.nombreGrupoLabor,a.empresa