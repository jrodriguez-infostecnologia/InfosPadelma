﻿CREATE PROCEDURE [dbo].[SpInsertanTipoNomina] @empresa int,@fechaRegistro datetime,@activo bit,@codigo varchar(50),@descripcion varchar(550),@periocidad varchar(50),@observacion varchar(5550),@usuario nchar,@Retorno int output  AS begin tran nTipoNomina insert nTipoNomina( empresa,fechaRegistro,activo,codigo,descripcion,periocidad,observacion,usuario ) select @empresa,@fechaRegistro,@activo,@codigo,@descripcion,@periocidad,@observacion,@usuario if (@@error = 0 ) begin set @Retorno = 0 commit tran nTipoNomina end else begin set @Retorno = 1 rollback tran nTipoNomina end