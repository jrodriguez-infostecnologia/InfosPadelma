CREATE proc [dbo].[VerificaPeridoPagadoNomina]
@empresa int,
@periodo int,
@año int,
@documentoNomina varchar(50),
@retorno int output
as


if exists (select * from npagosNomina a join nPagosNominaDetalle b 
on b.año=a.año and b.mes=a.mes and b.periodoNomina=a.periodoNomina and b.empresa=a.empresa
where a.empresa=@empresa and a.periodoNomina=@periodo and a.año=@año and anulado=0 
and b.documentoNomina =@documentoNomina)
set @retorno=1
else
set @retorno=0