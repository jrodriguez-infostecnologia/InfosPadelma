CREATE proc [dbo].[spSeleccionaLiquidacionContratistaPeriodo]
@empresa int,
@año int,
@periodo int
as

declare @fi date, @ff date, @mes int

select @mes=mes,@fi=fechaInicial,@ff=fechaFinal  from nPeriodoDetalle
where año=@año and noPeriodo=@periodo and empresa=@empresa

select SUBSTRING(CONVERT(varchar, CONVERT(money, RTRIM(identificacion)), 1), 1, LEN(CONVERT(varchar, CONVERT(money, RTRIM(identificacion)), 1)) - 3) AS cedula,
dbo.fretornanombremes(@mes) nombreMes,
CONVERT(varchar(4), año) + RTRIM(RIGHT('00' + RTRIM(mes), 2)) AS periodoUnido, *,@fi fechaInicial,@ff fechaFinal,DATENAME(WEEKDAY,fecha) diaSemana,
convert (int,substring(numero,4,len(numero))) numeroT,@periodo noPeriodo
FROM vSeleccionaLiquidacionContratista
where fechaT between @fi and @ff and empresa=@empresa