
CREATE PROCEDURE [dbo].[SpInsertaaTransaccion] @fecha date,@fechaFinal date,@empresa int,@año int,
@mes int,@jornal int,@racimos int,@cantidad int,@precio money,
@valorTotal money,@fechaRegistro datetime,@fechaAnulado datetime,
@anulado bit,@tipo varchar(50),@numero varchar(50),@referencia varchar(50),
@remision varchar(50),@observacion varchar(2550),@usuarioRegistro varchar(50),
@usuarioAnulado varchar(50),@finca char(10),@Retorno int output  AS 
begin tran aTransaccion 

declare @perido int
set @perido = (select top 1 noPeriodo from nPeriodoDetalle where empresa=@empresa and @fecha between fechaInicial and fechaFinal and agronomico=1 and cerrado=0)

insert aTransaccion( fecha,fechaFinal,empresa,año,mes,jornal,racimos,cantidad,precio,valorTotal,
fechaRegistro,fechaAnulado,anulado,tipo,numero,referencia,remision,observacion,usuarioRegistro,
usuarioAnulado,finca,periodo ) 
select @fecha,@fechaFinal,@empresa,@año,@mes,@jornal,@racimos,@cantidad,@precio,@valorTotal,
@fechaRegistro,@fechaAnulado,@anulado,@tipo,@numero,@referencia,@remision,@observacion,@usuarioRegistro,
@usuarioAnulado,@finca,@perido
if (@@error = 0 ) begin set @Retorno = 0 commit tran aTransaccion end 
else begin set @Retorno = 1 rollback tran aTransaccion end