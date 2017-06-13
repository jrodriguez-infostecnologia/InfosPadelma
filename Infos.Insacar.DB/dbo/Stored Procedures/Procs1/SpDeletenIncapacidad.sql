CREATE PROCEDURE [dbo].[SpDeletenIncapacidad] @empresa int,@tercero int,@numero int,@usuario varchar(50),@Retorno int output  AS begin 
tran nIncapacidad 
update  nIncapacidad set
anulado=1,
usuarioAnulado=@usuario,
fechaAnulado=GETDATE()
where empresa = @empresa and tercero = @tercero and numero = @numero if (@@error = 0 ) begin set @Retorno = 0 commit tran nIncapacidad end else begin set @Retorno = 1 rollback tran nIncapacidad end