﻿CREATE PROCEDURE SpGetaNovedadLotePreciokey @empresa int,@registro int,@año varchar(50),@novedad varchar(50) AS  select * from aNovedadLotePrecio where año = @año and empresa = @empresa and novedad = @novedad and registro = @registro