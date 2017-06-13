create proc [dbo].[spRetornaEncabezadoTransaccionLaboresTiqueteReferencia]
@numero varchar(50),
@empresa int 
as


select b.* from atransaccion a join atransaccionbascula  b on 
a.numero=b.numero and a.tipo=b.tipo and a.empresa=b.empresa
where a.numero = @numero  and a.empresa = @empresa