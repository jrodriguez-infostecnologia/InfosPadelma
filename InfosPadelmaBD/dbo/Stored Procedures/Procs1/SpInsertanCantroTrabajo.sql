﻿CREATE PROCEDURE [dbo].[SpInsertanCantroTrabajo] @empresa int,@activo bit,@porcentaje decimal,@codigo varchar(50),@descripcion varchar(550),@Retorno int output  AS begin tran nCantroTrabajo insert nCantroTrabajo( empresa,activo,porcentaje,codigo,descripcion ) select @empresa,@activo,@porcentaje,@codigo,@descripcion if (@@error = 0 ) begin set @Retorno = 0 commit tran nCantroTrabajo end else begin set @Retorno = 1 rollback tran nCantroTrabajo end