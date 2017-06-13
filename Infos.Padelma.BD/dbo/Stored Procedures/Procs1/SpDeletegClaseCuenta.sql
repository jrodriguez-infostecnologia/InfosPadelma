create PROCEDURE [dbo].[SpDeletegClaseCuenta] @empresa int,@codigo varchar(50),@Retorno int output  AS 
begin tran gClaseCuenta delete gClaseCuenta where codigo = @codigo and empresa = @empresa 
if (@@error = 0 ) begin set @Retorno = 0 commit tran gClaseCuenta end else begin set @Retorno = 1 rollback tran gClaseCuenta end