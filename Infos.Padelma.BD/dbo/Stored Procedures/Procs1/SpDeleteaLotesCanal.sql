CREATE PROCEDURE [dbo].[SpDeleteaLotesCanal] @empresa int,@lote varchar(50),@Retorno int output  AS 
begin tran aLotesCanal delete aLotesCanal where empresa = @empresa and lote = @lote 
if (@@error = 0 ) begin set @Retorno = 0 commit tran aLotesCanal end else begin set @Retorno = 1 rollback tran aLotesCanal end