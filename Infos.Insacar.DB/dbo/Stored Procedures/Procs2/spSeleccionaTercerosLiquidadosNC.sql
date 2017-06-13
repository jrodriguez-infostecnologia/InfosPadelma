CREATE proc [dbo].[spSeleccionaTercerosLiquidadosNC]
@empresa int,
@año int,
@periodo int
as

select distinct a.numero , a.numero + ' - ' + a.identificacion +' - '+  a.descripcion cadena from vLiquidacionDefinitivaReal a
where empresa=@empresa
and año=@año and tipo='LQC' and anulado=0
and a.noPeriodo=@periodo
and 
isnull(a.numero,'') not in(
select isnull(docNomina,'') from  cContabilizacionDetalle a join cContabilizacion b on a.numero=b.numero and a.tipo=b.tipo and a.empresa=b.empresa
where
a.empresa=@empresa
and a.periodoNomina=@periodo and b.anulado=0 and a.tipoLiquidacion='PS')