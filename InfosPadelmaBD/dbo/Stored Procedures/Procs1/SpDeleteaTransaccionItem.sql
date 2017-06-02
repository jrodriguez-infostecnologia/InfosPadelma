create PROCEDURE [dbo].[SpDeleteaTransaccionItem] 
@empresa int,
@tipo varchar(50),
@numero varchar(50),
@Retorno int output  AS 
begin tran 
aTransaccionItem 
delete aTransaccionItem where 
empresa = @empresa 
and numero = @numero 
and tipo = @tipo 
if (@@error = 0 ) begin set @Retorno = 0 commit tran aTransaccionItem end else begin set @Retorno = 1 rollback tran aTransaccionItem end