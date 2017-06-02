CREATE proc [dbo].[spSeleccionaPrecioNovedadAño]
@empresa int,
@novedad int,
@año int,
@precio money output
as

declare @VDSM money = isnull((select vSalarioMinimo/30 from nParametrosAno where empresa=@empresa and ano=@año),1)

set @precio=  isnull((select case when baseSueldo = 1 then @VDSM else  precioDestajo end FROM aNovedadLotePrecio
where empresa= @empresa and novedad=@novedad and año=@año ),0)