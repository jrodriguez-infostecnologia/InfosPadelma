﻿CREATE PROCEDURE SpGetaTipoCanalkey @empresa int,@codigo varchar(10) AS  select * from aTipoCanal where codigo = @codigo and empresa = @empresa