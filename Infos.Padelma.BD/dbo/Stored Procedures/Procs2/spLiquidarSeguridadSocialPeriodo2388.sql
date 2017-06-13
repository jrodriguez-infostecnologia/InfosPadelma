CREATE proc [dbo].[spLiquidarSeguridadSocialPeriodo2388]
@año int,
@empresa int,
@mes int
as
exec spCalculaSeguridadSocialTrabajador2388 @empresa,@mes,@año,''

select * from  nSeguridadSocialPila
		where empresa=@empresa and año=@año and mes=@mes
order by registro