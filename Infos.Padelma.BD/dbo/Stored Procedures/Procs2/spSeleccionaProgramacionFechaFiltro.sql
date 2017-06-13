CREATE proc [dbo].[spSeleccionaProgramacionFechaFiltro]
@fi date,
@ff date,
@empresa int,
@filtro varchar(100)
as

select turno, c.descripcion desTurno, a.fecha, b.tercero,b.codigo,b.descripcion,a.cuadrilla, d.descripcion desCuadrilla,a.horaInicio,a.horaEntrada,a.horaSalida,a.estado from nProgramacion a
join nFuncionario b on b.tercero=a.funcionario and b.empresa=a.empresa
left join nTurno c on c.codigo=a.turno and c.empresa=a.empresa
left join nCuadrilla d on d.codigo=a.cuadrilla and d.empresa=a.empresa
where a.empresa=@empresa and a.fecha between @fi and @ff
and (b.codigo like '%'+@filtro+'%' or b.descripcion like '%'+@filtro+'%' or d.descripcion like '%'+@filtro+'%')
order by b.descripcion,fecha