﻿CREATE PROCEDURE [dbo].[SpDeletenLiquidacionNomina] @empresa int,@año int,@mes int,@noPeriodo int,@tipo varchar(50),@numero varchar(50),@Retorno int output  AS begin tran nLiquidacionNomina delete nLiquidacionNomina where año = @año and empresa = @empresa and mes = @mes and noPeriodo = @noPeriodo and numero = @numero and tipo = @tipo if (@@error = 0 ) begin set @Retorno = 0 commit tran nLiquidacionNomina end else begin set @Retorno = 1 rollback tran nLiquidacionNomina end