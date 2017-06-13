
CREATE PROCEDURE [dbo].[SpActualizaaPeriodo] @empresa int,@año int,@mes int,@cerrado bit,@Retorno int output  AS begin tran aPeriodo 
update aPeriodo set cerrado = @cerrado where empresa = @empresa and año = @año and mes = @mes 
if (@@error = 0 ) begin set @Retorno = 0 commit tran aPeriodo end else begin set @Retorno = 1 rollback tran aPeriodo end