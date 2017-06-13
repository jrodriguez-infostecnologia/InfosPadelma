CREATE proc [dbo].[spAnulaPeridoPagadoNomina]
@empresa int, 
@periodo int, 
@año int,
@usuario varchar(50),
@documento varchar(50),
@retorno int output
as

begin tran pagoNomina

update nPagosNomina
set anulado=1,
usuarioAnulado=@usuario,
fechaAnualado = getdate()
where
empresa=@empresa and periodoNomina=@periodo and año=@año  and numero=@documento

if (@@error = 0 ) begin set @Retorno = 0 commit tran pagoNomina end else begin set @Retorno = 1 rollback tran pagoNomina end