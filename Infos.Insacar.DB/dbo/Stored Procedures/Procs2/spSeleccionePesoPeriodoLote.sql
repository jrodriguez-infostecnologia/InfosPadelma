CREATE proc spSeleccionePesoPeriodoLote
@año int,
@empresa int
as

declare @meses table
( mes int, nombreMes varchar(50))

insert @meses
select 1, 'Enero'
union
select 2,'Febrero'
union
select 3,'Marzo'
union
select 4,'Abril'
union
select 5,'Mayo'
union
select 6,'Junio'
union
select 7,'Julio'
union
select 8, 'Agosto' 
union
select 9 , 'Septiembre'
union
select 10,'Octubre'
union
select 11,'Noviembre'
union
select 12,'Diciembre'


select b.codigo, b.descripcion nombreLote, a.mes, a.nombreMes, ISNULL(c.pesoRacimo,0) pesoPromedio from @meses a
cross join aLotes b 
left join aLotePesosPeriodo c on c.lote = b.codigo and c.año =@año
and c.empresa=b.empresa and c.mes= a.mes
where b.empresa=@empresa 
order by b.codigo, mes