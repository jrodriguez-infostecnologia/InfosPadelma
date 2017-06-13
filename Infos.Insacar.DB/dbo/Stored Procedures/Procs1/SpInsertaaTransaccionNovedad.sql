

CREATE PROCEDURE [dbo].[SpInsertaaTransaccionNovedad] @fecha date,@empresa int,@año int,@mes int,@novedad varchar(50),
@registro int,@recimos int,@ejecutado bit,@cantidad decimal(18,3),
@jornales decimal(18,3),@saldo decimal(18,3),@tipo varchar(50),@numero varchar(50),
@uMedida varchar(50),@seccion varchar(50),@precioLabor money,
@lote varchar(50), @pesoRacimo float,@Retorno int output 
 AS begin tran aTransaccionNovedad 

 declare @perido int,@concepto varchar(50)
set @perido = (select periodo from aTransaccion where numero=@numero and tipo=@tipo and empresa=@empresa)

 declare @signo int = isnull((select naturaleza from aNovedad where codigo=@novedad and empresa=@empresa) ,0)
 set @concepto  = isnull((select top 1 concepto from aNovedad where codigo=@novedad and empresa=@empresa) ,null)

 insert aTransaccionNovedad( fecha,empresa,año,mes,novedad,registro,racimos,pesoRacimo,ejecutado,cantidad,jornales,saldo,tipo,numero,uMedida,seccion,lote,signo, precioLabor,periodo,concepto ) 
 select @fecha,@empresa,@año,@mes,@novedad,@registro, @recimos,@pesoRacimo,@ejecutado,@cantidad,@jornales,@saldo,@tipo,@numero,@uMedida,@seccion,@lote,@signo ,@precioLabor,@perido,@concepto
 if (@@error = 0 ) begin set @Retorno = 0 commit tran aTransaccionNovedad end else begin set @Retorno = 1 rollback tran aTransaccionNovedad end