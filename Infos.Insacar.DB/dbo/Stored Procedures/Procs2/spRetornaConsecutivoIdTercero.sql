CREATE proc [dbo].[spRetornaConsecutivoIdTercero]
@empresa int,
@retorno int output
as
if not exists(select top 1 * from cTercero where empresa=@empresa)
set @retorno=1
else
select top 1  @retorno=id+1 from cTercero where empresa=@empresa
order by id desc