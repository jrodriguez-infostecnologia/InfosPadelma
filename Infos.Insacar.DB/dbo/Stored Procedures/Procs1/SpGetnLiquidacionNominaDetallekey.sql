﻿CREATE PROCEDURE [dbo].[SpGetnLiquidacionNominaDetallekey] @empresa int,@año int,@mes int,@noPeriodo int,@tipo varchar(50),@numero varchar(50) AS  select * from nLiquidacionNominaDetalle where año = @año and empresa = @empresa and mes = @mes and noPeriodo = @noPeriodo and numero = @numero and tipo = @tipo