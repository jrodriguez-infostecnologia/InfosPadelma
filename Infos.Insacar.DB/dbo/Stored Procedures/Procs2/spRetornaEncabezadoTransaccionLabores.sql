create proc spRetornaEncabezadoTransaccionLabores
@numero varchar(50),
@tipo varchar(50),
@empresa int 
as


select * from atransaccion
where numero = @numero and tipo=@tipo and empresa = @empresa