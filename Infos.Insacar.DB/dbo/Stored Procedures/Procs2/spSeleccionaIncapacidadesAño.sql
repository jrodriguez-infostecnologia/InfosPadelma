CREATE proc [dbo].[spSeleccionaIncapacidadesAño]
@empresa int,
@fecha date,
@tercero varchar(50)
as



select numero, convert(varchar(50),numero) + ' - ' + CONVERT(varchar(50), fechaInicial, 103) + ' - ' + CONVERT(varchar(50), fechaFinal, 103)  as cadena 
from  nIncapacidad 
where empresa=@empresa and tercero=@tercero and fechaFinal between dateadd(DAY, -40, @fecha) and @fecha

select dateadd(DAY, -40, @fecha), @fecha