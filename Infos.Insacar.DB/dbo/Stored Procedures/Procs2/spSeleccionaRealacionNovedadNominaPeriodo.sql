CREATE proc spSeleccionaRealacionNovedadNominaPeriodo
@periodo int,
@año int,
@empresa int
as

declare @fi date,@ff date
select @fi=fechaInicial,@ff=fechaFinal from nPeriodoDetalle
where empresa= @empresa and noPeriodo=@periodo and año=@año

select b.id,b.codigo,b.descripcion nombreTrabajador, d.descripcion nombreCargo,
e.descripcion tipoAusentismo, a.fechaInicial,a.fechaFinal
  from nIncapacidad a
join cTercero b on b.id=a.tercero and b.empresa = a.empresa
join nContratos c on c.tercero=b.id and c.empresa=b.empresa
join nTipoIncapacidad e on e.codigo=a.tipoIncapacidad and e.empresa=a.empresa
left join nCargo d on d.codigo=c.cargo and d.empresa=c.empresa
where a.empresa=@empresa and anulado=0 and  (fechaInicial between @fi and @ff or 
fechaFinal between @fi and @ff or (fechaInicial<@fi and fechaFinal>@ff))
union
select b.id,b.codigo,b.descripcion,d.descripcion, case when a.tipo=2 then 'Vacaciones pagadas' else  'Vacaciones disfrutadas' end,
a.fechaSalida,a.fechaRetorno
 from nVacaciones a
join cTercero b on b.id=a.empleado and b.empresa = a.empresa
join nContratos c on c.tercero=b.id and c.empresa=b.empresa
left join nCargo d on d.codigo=c.cargo and d.empresa=c.empresa
where a.empresa=@empresa and anulado=0 and  (fechaSalida between @fi and @ff or 
fechaRetorno between @fi and @ff or (fechaSalida<@fi and fechaRetorno>@ff))
union
select  b.id,b.codigo,b.descripcion,d.descripcion, 'Ingreso',
 c.fechaIngreso,c.fechaingreso
from  cTercero b 
join nContratos c on c.tercero=b.id and c.empresa=b.empresa
left join nCargo d on d.codigo=c.cargo and d.empresa=c.empresa
where b.empresa=@empresa and  (fechaIngreso between @fi and @ff )
union
select  b.id,b.codigo,b.descripcion,d.descripcion, 'Retiro',
 c.fechaRetiro,c.fechaRetiro
from  cTercero b 
join nContratos c on c.tercero=b.id and c.empresa=b.empresa
left join nCargo d on d.codigo=c.cargo and d.empresa=c.empresa
where b.empresa=@empresa and  (fechaRetiro between @fi and @ff )