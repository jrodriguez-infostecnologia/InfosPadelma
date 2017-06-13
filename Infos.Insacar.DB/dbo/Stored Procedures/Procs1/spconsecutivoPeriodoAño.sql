create proc [dbo].[spconsecutivoPeriodoAño]
@año int,
@empresa int,
@retorno int output
as


select @retorno=max(noPeriodo)+1 from nPeriodoDetalle 
where año=@año and empresa = @empresa

set @retorno = isnull(@retorno,1)