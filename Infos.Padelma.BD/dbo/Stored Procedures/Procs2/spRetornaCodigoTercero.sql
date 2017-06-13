
CREATE proc [dbo].[spRetornaCodigoTercero]
@codigo varchar(50),
@empresa int,
@retorno int output
as
if  exists(select  * from cTercero where codigo=@codigo and empresa=@empresa)
set @retorno=1
else
set @retorno=0