﻿CREATE PROCEDURE SpGetgTipoTransaccionDiaskey @empresa int,@tipo varchar(50) AS  select * from gTipoTransaccionDias where empresa = @empresa and tipo = @tipo