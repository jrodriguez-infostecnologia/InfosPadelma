﻿CREATE PROCEDURE [dbo].[SpInsertanEntidadAfc] @empresa int,@tercero int,@fechaRegistro datetime,@activo bit,@codigo varchar(50),@descripcion varchar(550),@proveedor varchar(50),@codigoNacional varchar(50),@observacion varchar(5550),@usuario varchar(50),@cuenta varchar(50),@Retorno int output  AS begin tran nEntidadAfc insert nEntidadAfc( empresa,tercero,fechaRegistro,activo,codigo,descripcion,proveedor,codigoNacional,observacion,usuario,cuenta ) select @empresa,@tercero,@fechaRegistro,@activo,@codigo,@descripcion,@proveedor,@codigoNacional,@observacion,@usuario,@cuenta if (@@error = 0 ) begin set @Retorno = 0 commit tran nEntidadAfc end else begin set @Retorno = 1 rollback tran nEntidadAfc end