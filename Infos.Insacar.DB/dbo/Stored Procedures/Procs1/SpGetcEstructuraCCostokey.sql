﻿CREATE PROCEDURE SpGetcEstructuraCCostokey @empresa int,@nivel int AS  select * from cEstructuraCCosto where empresa = @empresa and nivel = @nivel