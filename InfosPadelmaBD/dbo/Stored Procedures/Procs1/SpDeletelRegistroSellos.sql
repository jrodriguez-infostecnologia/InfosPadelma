CREATE PROCEDURE [dbo].[SpDeletelRegistroSellos] @empresa int,@tipo varchar(50),@numero varchar(50),@Sello varchar(50), @usuario varchar(50),@Retorno int output  AS begin tran lRegistroSellos

update lRegistroSellos
set anulado=1,
usuarioAnulado=@usuario,
fechaAnulado = getdate()
where empresa = @empresa and numero = @numero and Sello = @Sello and tipo = @tipo 

if (@@error = 0 ) begin set @Retorno = 0 commit tran lRegistroSellos end else begin set @Retorno = 1 rollback tran lRegistroSellos end