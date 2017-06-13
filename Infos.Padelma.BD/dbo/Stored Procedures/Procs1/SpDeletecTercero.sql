CREATE PROCEDURE [dbo].[SpDeletecTercero] @id int, @empresa int,
@Retorno int output  AS begin tran cTercero delete cTercero where id = @id and empresa=@empresa
 if (@@error = 0 ) begin set @Retorno = 0 commit tran cTercero end else begin set @Retorno = 1 rollback tran cTercero end