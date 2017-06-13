create PROCEDURE [dbo].[SpEliminalAnalisisItem] @empresa int,
@item int,
@Retorno int output  AS begin tran lAnalisisItem delete lAnalisisItem where empresa = @empresa and item = @item 
if (@@error = 0 ) begin set @Retorno = 0 commit tran lAnalisisItem end else begin set @Retorno = 1 rollback tran lAnalisisItem end