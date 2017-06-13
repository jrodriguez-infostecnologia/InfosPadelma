
CREATE PROCEDURE [dbo].[SpDeletenNovedadesDetalle] @empresa int,@tipo varchar(50),@numero varchar(50),
@Retorno int output  AS begin tran nNovedadesDetalle 
delete nNovedadesDetalle where empresa = @empresa and tipo = @tipo and numero = @numero 
if (@@error = 0 ) begin set @Retorno = 0 commit tran nNovedadesDetalle end 
else begin set @Retorno = 1 rollback tran nNovedadesDetalle end