create proc spRetornaDatosLabores	
@empresa int,
@codigo varchar(50)
as

select * from anovedad
where @codigo = codigo and empresa=@empresa