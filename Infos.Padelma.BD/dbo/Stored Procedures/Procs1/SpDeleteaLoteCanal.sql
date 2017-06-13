
CREATE PROCEDURE [dbo].[SpDeleteaLoteCanal] @empresa int,@lote varchar(50),@Retorno int output  AS begin tran aLoteCanal 
delete aLoteCanal where empresa = @empresa and lote = @lote 
if (@@error = 0 ) begin set @Retorno = 0 commit tran aLoteCanal end else begin set @Retorno = 1 rollback tran aLoteCanal end