CREATE proc SeleccionaListaPrecioLotes
@empresa int,
@año int
as




select a.*,b.descripcion, datename(month,convert(date,'01/'+ CONVERT(varchar(4),a.mes)+'/'+CONVERT(varchar(4),a.año))) nombreMes from aLotePesosPeriodo a
join aLotes b on b.codigo=a.lote and b.empresa=a.empresa
where a. empresa=@empresa and año=@año