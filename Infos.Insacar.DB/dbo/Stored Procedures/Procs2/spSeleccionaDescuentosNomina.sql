CREATE proc [dbo].[spSeleccionaDescuentosNomina]
@empresa int,
@año int,
@periodo int,
@numero varchar(50)
as

select *,valorTotal valorConcepto from vSeleccionaLiquidacionDefinitiva
where empresa=@empresa and año=@año and noPeriodo=@periodo and anulado=0 and numero=@numero