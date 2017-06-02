
CREATE PROCEDURE 
[dbo].[SpDeleteaTransaccionBascula] 
@empresa int,
@tipo varchar(50),@numero varchar(50)
,@Retorno int output  AS begin tran aTransaccionBascula delete aTransaccionBascula where empresa = @empresa and numero = @numero and tipo = @tipo if (@@error = 0 ) begin set @Retorno = 0 commit tran aTransaccionBascula end else begin set @Retorno = 1 rollback tran aTransaccionBascula end