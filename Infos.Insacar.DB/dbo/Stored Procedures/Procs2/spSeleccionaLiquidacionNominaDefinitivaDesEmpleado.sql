CREATE proc [dbo].[spSeleccionaLiquidacionNominaDefinitivaDesEmpleado]
@empresa int,
@año int,
@periodo int,
@numero varchar(50),
@ccostoMayor varchar(50),
@ccosto varchar(50)
as

select DISTINCT a.identificacion, a.codTercero,
 convert(varchar(50),a.codTercero) +' - '+ 
 convert(varchar(50),a.identificacion) +' - '+ a.nombreTercero nombreTercero
from vSeleccionaLiquidacionDefinitiva a
where  a.empresa=@empresa and a.noPeriodo=@periodo and a.año=@año and a.anulado=0 and a.numero like '%'+ @numero+ '%'
and a.mayor like '%'+ @ccostoMayor+ '%' and a.codCCosto like '%'+ @ccosto+ '%'