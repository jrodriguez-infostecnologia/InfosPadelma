﻿CREATE PROCEDURE [dbo].[SpInsertanCuadrilla] @empresa int,@activo bit,@departamento varchar(50),@codigo varchar(50),@descripcion varchar(250),@Retorno int output  AS begin tran nCuadrilla insert nCuadrilla( empresa,activo,departamento,codigo,descripcion ) select @empresa,@activo,@departamento,@codigo,@descripcion if (@@error = 0 ) begin set @Retorno = 0 commit tran nCuadrilla end else begin set @Retorno = 1 rollback tran nCuadrilla end