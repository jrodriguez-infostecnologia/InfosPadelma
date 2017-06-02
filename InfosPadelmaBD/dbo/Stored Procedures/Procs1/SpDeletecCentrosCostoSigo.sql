CREATE PROCEDURE [dbo].[SpDeletecCentrosCostoSigo] @empresa int,@codigo varchar(50),@Retorno int output  AS 
begin tran cCentrosCostoSigo delete cCentrosCostoSigo where codigo = @codigo and empresa = @empresa 
if (@@error = 0 ) begin set @Retorno = 0 commit tran cCentrosCostoSigo end else begin set @Retorno = 1 rollback tran cCentrosCostoSigo end