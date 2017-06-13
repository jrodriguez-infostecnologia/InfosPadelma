﻿CREATE PROCEDURE SpActualizaiItemsCriterios @empresa int,@item int,@fechaRegistro datetime,@idPlan varchar(5),@idMayor varchar(50),@Retorno int output  AS begin tran iItemsCriterios update iItemsCriterios set fechaRegistro = @fechaRegistro where empresa = @empresa and idMayor = @idMayor and idPlan = @idPlan and item = @item if (@@error = 0 ) begin set @Retorno = 0 commit tran iItemsCriterios end else begin set @Retorno = 1 rollback tran iItemsCriterios end