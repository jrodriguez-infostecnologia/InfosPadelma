create proc spEliminarTransaccionLabores
@tipo varchar(50),
@numero varchar(50),
@empresa int,
@retorno int output

as

begin tran EliminarTransaccionLabores

 delete   atransaccionNovedad
 where numero = @numero and tipo=@tipo and empresa=@empresa

 delete aTransaccionTercero 
 where numero = @numero and empresa=@empresa and tipo=@tipo

 delete aTransaccionBascula
 where numero =@numero and empresa=@empresa and tipo=@tipo

 delete aTransaccion
 where numero=@numero and tipo=@tipo and empresa=@empresa


if (@@error = 0 ) 
begin set @Retorno = 0 
commit tran spEliminarTransaccionLabores 
end 
else 
begin 
set @Retorno = 1 
rollback 
tran spEliminarTransaccionLabores end