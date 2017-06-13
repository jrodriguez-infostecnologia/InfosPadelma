CREATE proc [dbo].[spSeleccionaProSinEjecucion]
@empresa int
as
	select distinct  a.numero , SUBSTRING(a.numero,1,3) + convert(varchar(20),CONVERT(int,SUBSTRING(a.numero,4,len(a.numero))))+' * '+ convert(varchar(50),a.fecha) +' * ' +observacion as cadena
 from aTransaccion a join  aTransaccionNovedad b on a.numero= b.numero and a.tipo=b.tipo and a.empresa=b.empresa
 where a.empresa=@empresa  and 
 b.ejecutado<> 1 and a.tipo= 'PRL'
 and anulado<>1