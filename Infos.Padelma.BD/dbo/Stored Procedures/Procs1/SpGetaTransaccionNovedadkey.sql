﻿CREATE PROCEDURE SpGetaTransaccionNovedadkey @empresa int,@registro int,@tipo varchar(50),@numero varchar(50),@novedad varchar(50) AS  select * from aTransaccionNovedad where empresa = @empresa and novedad = @novedad and numero = @numero and registro = @registro and tipo = @tipo