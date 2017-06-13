CREATE proc [dbo].[spRetornaNombreArchivoPlano]
@empresa int,
@periodo int,
@año int,
@retorno varchar(100) output
as

--select distinct  c.descripcion+ '_Periodo_' + CONVERT(varchar(50),noPeriodo) + '_del_' +CONVERT(varchar(50),fechaInicial,112) + '_al_' + CONVERT(varchar(50),fechaFinal,112)   descripcion  
--from nPeriodoDetalle a join nPagosNomina b on a.noPeriodo=b.periodoNomina and a.año=b.año 
--join gBanco c on b.Banco=c.codigo and b.empresa=c.empresa
--where a.empresa=@empresa
--and  noPeriodo = @periodo
--and a.año=@año
--and b.anulado=0

set @retorno =(
select distinct  c.descripcion+ '_Periodo_' + CONVERT(varchar(50),noPeriodo) + '_del_' +CONVERT(varchar(50),fechaInicial,112) + '_al_' + CONVERT(varchar(50),fechaFinal,112)   descripcion  
from nPeriodoDetalle a join nPagosNomina b on a.noPeriodo=b.periodoNomina and a.año=b.año 
join gBanco c on b.Banco=c.codigo and b.empresa=c.empresa
where a.empresa=@empresa
and  noPeriodo = @periodo
and a.año=@año
and b.anulado=0
)

if @retorno is null
set @retorno =''