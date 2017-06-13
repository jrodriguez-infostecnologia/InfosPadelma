﻿CREATE PROCEDURE SpActualizaaLabor @empresa int,@ciclos int,@tarea int,@naturaleza int,@fechaRegistro datetime,@impuesto bit,@activo bit,@codigo varchar(50),@descripcion varchar(50),@desCorta varchar(50),@grupo varchar(50),@uMedida varchar(50),@equivalencia varchar(50),@concepto varchar(50),@usuario varchar(50),@Retorno int output  AS begin tran aLabor update aLabor set ciclos = @ciclos,tarea = @tarea,naturaleza = @naturaleza,fechaRegistro = @fechaRegistro,impuesto = @impuesto,activo = @activo,descripcion = @descripcion,desCorta = @desCorta,grupo = @grupo,uMedida = @uMedida,equivalencia = @equivalencia,concepto = @concepto,usuario = @usuario where empresa = @empresa and codigo = @codigo if (@@error = 0 ) begin set @Retorno = 0 commit tran aLabor end else begin set @Retorno = 1 rollback tran aLabor end