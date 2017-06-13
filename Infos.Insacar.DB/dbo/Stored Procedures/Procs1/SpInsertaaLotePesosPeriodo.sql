
CREATE PROCEDURE [dbo].[SpInsertaaLotePesosPeriodo] @empresa int,@año int,@mes int,@automatico bit,@pesoRacimo decimal(18,3),@fi date, @ff date,
@finca varchar(50),@seccion varchar(50),@lote varchar(50),@Retorno int output  AS begin tran aLotePesosPeriodo 

insert aLotePesosPeriodo( empresa,año,mes,automatico,pesoRacimo,finca,seccion,lote,fechaInicial,fechaFinal ) 
select @empresa,@año,@mes,@automatico,@pesoRacimo,@finca,@seccion,@lote,@fi,@ff
 if (@@error = 0 ) 

begin set @Retorno = 0 commit tran aLotePesosPeriodo end else begin set @Retorno = 1 rollback tran aLotePesosPeriodo end