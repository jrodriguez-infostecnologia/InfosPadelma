﻿CREATE PROCEDURE [dbo].[SpInsertabRegistroPorteria] @empresa int,@fechaEntrada datetime,@fechaSalida datetime,
@fechaProgramacion datetime,@fechaRegistro datetime,@propio bit,@numero varchar(50),@tipo varchar(50),
@remision varchar(50),@codigoConductor varchar(50),@nombreConductor varchar(250),@vehiculo varchar(50),
@remolque varchar(50),@usuario varchar(50),@estado char(2),@Retorno int output  AS begin tran bRegistroPorteria 

declare @tipoTransaccion varchar(50)

if @tipo='entrada'
	set @tipoTransaccion = (select entradas from gParametrosGenerales where empresa=@empresa)
else
	set @tipoTransaccion = (select salidas from gParametrosGenerales where empresa=@empresa)

insert bRegistroPorteria( empresa,fechaEntrada,fechaSalida,fechaProgramacion,fechaRegistro,propio,numero,tipo,remision,
codigoConductor,nombreConductor,vehiculo,remolque,usuario,estado ) 
select @empresa,@fechaEntrada,@fechaSalida,@fechaProgramacion,@fechaRegistro,@propio,@numero,@tipoTransaccion,@remision,
@codigoConductor,@nombreConductor,UPPER(@vehiculo),upper(@remolque),@usuario,@estado 
if (@@error = 0 ) begin set @Retorno = 0 commit tran bRegistroPorteria end 
else begin set @Retorno = 1 rollback tran bRegistroPorteria end