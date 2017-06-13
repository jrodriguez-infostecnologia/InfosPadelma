
CREATE PROCEDURE [dbo].[SpInsertaaLotesCanal] @empresa int,@registro int,@metros decimal(18,3),@lote varchar(50),@tipoCanal varchar(10),@Retorno int output  
AS begin tran aLotesCanal insert aLotesCanal( empresa,registro,metros,lote,tipoCanal ) select @empresa,@registro,@metros,@lote,@tipoCanal 
if (@@error = 0 ) begin set @Retorno = 0 commit tran aLotesCanal end else begin set @Retorno = 1 rollback tran aLotesCanal end