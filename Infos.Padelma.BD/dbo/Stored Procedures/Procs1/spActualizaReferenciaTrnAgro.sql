
create PROCEDURE [dbo].spActualizaReferenciaTrnAgro 
@numero varchar(50) ,
@empresa int,
@Retorno int output
AS 

begin tran ActualizaReferencia
 update   atransaccionNovedad
 set ejecutado=1
 where numero = @numero and empresa=@empresa

 update aTransaccionTercero 
 set ejecutado=1
 where numero = @numero and empresa=@empresa


if (@@error = 0 ) 
begin set @Retorno = 0 
commit tran ActualizaReferencia 
end 
else 
begin 
set @Retorno = 1 
rollback 
tran ActualizaReferencia end