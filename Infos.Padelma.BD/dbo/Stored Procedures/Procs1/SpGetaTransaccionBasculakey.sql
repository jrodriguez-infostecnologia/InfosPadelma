﻿CREATE PROCEDURE SpGetaTransaccionBasculakey @empresa int,@terceroExtractrora int,@tipo varchar(50),@numero varchar(50) AS  select * from aTransaccionBascula where empresa = @empresa and numero = @numero and terceroExtractrora = @terceroExtractrora and tipo = @tipo