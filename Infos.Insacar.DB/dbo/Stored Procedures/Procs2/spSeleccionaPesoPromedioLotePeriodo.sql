CREATE proc [dbo].[spSeleccionaPesoPromedioLotePeriodo]
@empresa int,
@año int,
@mes int,
@lote varchar(50),
@tipo varchar(50),
@valor decimal(18,3) output
as

declare @fruta decimal(18,3), @racimos decimal(18,3)

select @fruta= SUM(isnull(a.cantidad,0)), @racimos=sum(isnull(a.racimos,0)) from aTransaccion c 
join aTransaccionNovedad a on a.tipo=c.tipo and a.numero=c.numero and a.empresa=c.empresa
join aNovedad b on b.codigo=a.novedad and b.empresa=a.empresa 
where lote=@lote and b.claseLabor=2 and c.anulado=0
and a.año=@año and a.mes =@mes and a.empresa=@empresa and a.tipo=@tipo

if @racimos=0 or @fruta is null
	set @valor=0
else
	set @valor=   round(@fruta/@racimos,2)

	--select @fruta,@racimos