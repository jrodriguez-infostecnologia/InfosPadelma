CREATE proc [dbo].[spSeleccionaTraFerSaldo] 
@empresa int
as

select  distinct
a.numero, 
'FER : ' + CONVERT(varchar(50), a.fecha) + ' hasta: ' + CONVERT(varchar(50), a.fechaFinal) +' - ' + a.observacion
as cadena 
from aTransaccion a 
join aTransaccionItem b on 
a.tipo=b.tipo and a.numero=b.numero and a.empresa=b.empresa
join iItems c on c.codigo=b.item and c.empresa=b.empresa
where
anulado=0 and b.saldo>0 --and a.cerrado=0 
and a.empresa=@empresa