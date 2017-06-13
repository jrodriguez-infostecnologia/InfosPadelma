
CREATE PROCEDURE [dbo].[SpDeleteiItemsCriterios] @empresa int,@item int ,@Retorno int output  
AS begin tran iItemsCriterios delete iItemsCriterios 
where empresa = @empresa and item = @item 
if (@@error = 0 ) begin set @Retorno = 0 commit tran iItemsCriterios end 
else begin set @Retorno = 1 rollback tran iItemsCriterios end