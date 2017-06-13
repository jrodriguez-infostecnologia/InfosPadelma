CREATE proc [dbo].[spRetornaNombreArchivoPlanoConta]
@empresa int,
@periodo int,
@año int,
@retorno varchar(100) output
as



set @retorno =(
select distinct  'Causacion_Contable_Periodo_' + CONVERT(varchar(50),noPeriodo) + '_del_' +CONVERT(varchar(50),fechaInicial,112) + '_al_' + CONVERT(varchar(50),fechaFinal,112)   descripcion  
from nPeriodoDetalle a join nPagosNomina b join gBanco c on b.Banco=c.codigo and b.empresa=c.empresa
on a.noPeriodo=b.periodoNomina and a.año=b.año 
where a.empresa=@empresa
and  noPeriodo = @periodo
and a.año=@año
and b.anulado=0)

if @retorno is null
set @retorno =''