CREATE proc [dbo].[spRetornaMesPeriodoNomina] 
@año int ,
@noPeriodo int,
@empresa int,
@retorno int output
as


select @retorno=mes from nPeriodoDetalle 
where empresa=@empresa
and noPeriodo=@noPeriodo 
and año=@año


if @retorno is null
set @retorno=14