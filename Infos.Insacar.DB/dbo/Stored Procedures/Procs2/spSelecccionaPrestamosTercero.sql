CREATE proc spSelecccionaPrestamosTercero
@tercero int,
@empresa int
as

select a.codigo,fecha,a.empleado,c.descripcion nombreTrabajador,a.concepto,b.descripcion nombreConcepto,
a.año,a.mes,a.periodoInicial,a.valor,a.cuotas,cuotasPendiente,valorSaldo,a.valorCuotas from nPrestamo a
join nConcepto b on  b.codigo=a.concepto and b.empresa=a.empresa
join cTercero c on c.id=a.empleado and c.empresa=a.empresa
where a.empresa=@empresa and a.empleado=@tercero