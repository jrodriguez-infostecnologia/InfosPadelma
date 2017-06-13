CREATE proc spSeleccionaAusentismos
@tipo varchar(50),
@año int,
@empresa int
as

select *  from vausentismo
where empresa=@empresa and (year(fechainicial)=@año or year(fechafinal)=@año)
and tipoincapacidad=@tipo
order by fechaInicial