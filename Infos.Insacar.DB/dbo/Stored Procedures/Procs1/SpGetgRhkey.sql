﻿CREATE PROCEDURE SpGetgRhkey @empresa int,@codigo varchar(50) AS  select * from gRh where codigo = @codigo and empresa = @empresa