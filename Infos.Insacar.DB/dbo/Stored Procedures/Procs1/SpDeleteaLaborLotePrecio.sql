﻿CREATE PROCEDURE SpDeleteaLaborLotePrecio @empresa int,@labor varchar(50),@finca varchar(50),@lote varchar(50),@Retorno int output  AS begin tran aLaborLotePrecio delete aLaborLotePrecio where empresa = @empresa and labor = @labor and finca = @finca and lote = @lote if (@@error = 0 ) begin set @Retorno = 0 commit tran aLaborLotePrecio end else begin set @Retorno = 1 rollback tran aLaborLotePrecio end