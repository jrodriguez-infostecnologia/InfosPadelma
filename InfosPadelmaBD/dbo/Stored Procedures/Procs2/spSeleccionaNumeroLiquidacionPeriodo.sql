CREATE proc [dbo].[spSeleccionaNumeroLiquidacionPeriodo]
@empresa int,
@periodo int,
@año	 int
as

select numero, numero + ' - Valor Total $ ' +  SUBSTRING(CONVERT(varchar, CONVERT(money, RTRIM(sum(valorTotal))), 1), 1, LEN(CONVERT(varchar, CONVERT(money, RTRIM(sum(valorTotal))), 1)) - 3)  as descripcion  
from vSeleccionaLiquidacionDefinitiva
where empresa=@empresa and noPeriodo=@periodo and anulado=0 and año=@año
group by numero