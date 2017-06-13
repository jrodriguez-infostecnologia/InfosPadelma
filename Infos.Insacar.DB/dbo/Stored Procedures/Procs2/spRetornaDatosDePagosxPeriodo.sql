CREATE proc [dbo].[spRetornaDatosDePagosxPeriodo]
@empresa int,
@numero varchar(50),
@año int,
@periodo int
as


select a.*, b.descripcion 
from vSeleccionaPago a join gFormaPago b on a.formaPago=b.codigo
and a.empresa=b.empresa 
where a.empresa=@empresa  and año=@año and noPeriodo=@periodo
and numero like '%'+@numero+'%'
and a.anulado=0 --and noContrato=2