
CREATE PROCEDURE [dbo].[SpActualizaaLotePesosPeriodo] @empresa int,@año int,@mes int,@automatico bit,@pesoRacimo decimal(18,3),@fi date, @ff date,
@finca varchar(50),@seccion varchar(50),@lote varchar(50),@Retorno int output  AS begin tran aLotePesosPeriodo 

update aLotePesosPeriodo set automatico = @automatico,pesoRacimo = @pesoRacimo,seccion = @seccion, fechaInicial=@fi, fechaFinal=@ff
where empresa = @empresa and año = @año and mes = @mes and finca = @finca and lote = @lote 
if (@@error = 0 ) begin set @Retorno = 0 commit tran aLotePesosPeriodo end else begin set @Retorno = 1 rollback tran aLotePesosPeriodo end