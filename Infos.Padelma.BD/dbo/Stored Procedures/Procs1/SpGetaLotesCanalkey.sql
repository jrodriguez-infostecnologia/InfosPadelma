﻿CREATE PROCEDURE SpGetaLotesCanalkey @empresa int,@registro int,@lote varchar(50),@tipoCanal varchar(10) AS  select * from aLotesCanal where empresa = @empresa and lote = @lote and registro = @registro and tipoCanal = @tipoCanal