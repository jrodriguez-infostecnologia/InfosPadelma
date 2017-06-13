create PROCEDURE [dbo].[SpDeleteiItemsBodega] @empresa int,@item varchar(50),
@Retorno int output  AS begin tran iItemsBodega delete iItemsBodega where  empresa = @empresa and item = @item 
if (@@error = 0 ) begin set @Retorno = 0 commit tran iItemsBodega end else begin set @Retorno = 1 rollback tran iItemsBodega end