create proc [dbo].[spRetornaEncabezadoTransaccionLaboresReferencia]
@numero varchar(50),
@empresa int 
as


select * from atransaccion
where numero = @numero  and empresa = @empresa