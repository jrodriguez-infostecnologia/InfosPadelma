CREATE PROCEDURE [dbo].[SpActualizacPeriodo] @empresa int,@año int,@mes int,@cerrado bit, 
@fechaInicial date, @fechaFinal date, @Retorno int output  AS begin tran cPeriodo 
update cPeriodo set cerrado = @cerrado, fechaInicial=@fechaInicial, fechaFinal=@fechaFinal
 where empresa = @empresa and año = @año and mes = @mes 
if (@@error = 0 ) begin set @Retorno = 0 commit tran cPeriodo end 
else begin set @Retorno = 1 rollback tran cPeriodo end