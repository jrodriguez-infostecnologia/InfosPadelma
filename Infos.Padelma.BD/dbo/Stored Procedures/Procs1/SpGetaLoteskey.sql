﻿CREATE PROCEDURE SpGetaLoteskey @empresa int,@codigo varchar(50) AS  select * from aLotes where codigo = @codigo and empresa = @empresa