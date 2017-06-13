
CREATE PROCEDURE [dbo].[SpDeletepTransaccionDetalle] @empresa int,@tipo varchar(50),
@numero varchar(50),@Retorno int output  AS begin tran pTransaccionDetalle 
delete pTransaccionDetalle where empresa = @empresa and tipo = @tipo and numero = @numero 
if (@@error = 0 ) begin set @Retorno = 0 commit tran pTransaccionDetalle end else begin set @Retorno = 1 rollback tran pTransaccionDetalle end