﻿CREATE PROCEDURE SpGetpTransaccionkey @empresa int,@tipo varchar(50),@numero varchar(50) AS  select * from pTransaccion where empresa = @empresa and numero = @numero and tipo = @tipo