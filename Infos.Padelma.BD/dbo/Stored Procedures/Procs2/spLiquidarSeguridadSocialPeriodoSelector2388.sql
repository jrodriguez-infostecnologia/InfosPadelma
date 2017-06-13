CREATE proc [dbo].[spLiquidarSeguridadSocialPeriodoSelector2388]
@año int,
@empresa int,
@mes int,
@registro int
as

select  aa.*
from  nSeguridadSocialPila aa
		where aa.empresa=@empresa and aa.año=@año and aa.mes=@mes and  aa.registro=@registro
order by aa.registro