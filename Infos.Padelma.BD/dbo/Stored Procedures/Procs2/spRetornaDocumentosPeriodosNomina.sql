CREATE proc [dbo].[spRetornaDocumentosPeriodosNomina]
@empresa int,
@año int,
@periodo int
as

select distinct numero from vLiquidacionDefinitivaReal
where empresa=@empresa and noPeriodo = @periodo and año=@año
and tipo in ('lqC') and anulado=0