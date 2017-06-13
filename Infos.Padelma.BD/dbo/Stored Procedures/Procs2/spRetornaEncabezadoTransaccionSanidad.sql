
CREATE proc [dbo].[spRetornaEncabezadoTransaccionSanidad]
@numero varchar(50),
@tipo varchar(50),
@empresa int 
as


select * from aSanidad
where numero = @numero and tipo=@tipo and empresa = @empresa
and anulado=0