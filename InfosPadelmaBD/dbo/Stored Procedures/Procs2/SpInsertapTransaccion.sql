﻿CREATE PROCEDURE [dbo].[SpInsertapTransaccion] @fecha date,@empresa int,@año int,@mes int,@producto int,@fechaRegistro datetime,@fechaAnulado datetime,@anulado bit,@tipo varchar(50),@numero varchar(50),@usuario varchar(50),@usuarioAnulado varchar(50),@Observacion varchar(5500),@Retorno int output  AS begin tran pTransaccion insert pTransaccion( fecha,empresa,año,mes,producto,fechaRegistro,fechaAnulado,anulado,tipo,numero,usuario,usuarioAnulado,Observacion ) select @fecha,@empresa,@año,@mes,@producto,@fechaRegistro,@fechaAnulado,@anulado,@tipo,@numero,@usuario,@usuarioAnulado,@Observacion if (@@error = 0 ) begin set @Retorno = 0 commit tran pTransaccion end else begin set @Retorno = 1 rollback tran pTransaccion end