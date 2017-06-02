
CREATE PROCEDURE [dbo].[SpInsertaaLoteCanal] @empresa int,@registro int,@metros decimal(18,3),@lote nchar,@tipoCanal nchar,@Retorno int output  
AS begin tran aLoteCanal insert aLoteCanal( empresa,registro,metros,lote,tipoCanal ) select @empresa,@registro,@metros,@lote,@tipoCanal 
if (@@error = 0 ) begin set @Retorno = 0 commit tran aLoteCanal end else begin set @Retorno = 1 rollback tran aLoteCanal end