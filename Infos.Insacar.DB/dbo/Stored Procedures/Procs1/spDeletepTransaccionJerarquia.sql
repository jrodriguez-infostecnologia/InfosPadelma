CREATE proc [dbo].[spDeletepTransaccionJerarquia]
@empresa int,
@tipo varchar(50),
@año int,
@mes int,
@numero varchar(50),
@fecha datetime,
@Retorno int
as
begin tran pTransaccionJerarquia

delete pTransaccionJerarquia
where tipo = @tipo and
numero = @numero and
fecha=@fecha and
empresa=@empresa and
año=@año and
mes = @mes 

if (@@error = 0 ) begin set @Retorno = 0 commit tran pTransaccionJerarquia end else begin set @Retorno = 1 rollback tran pTransaccionJerarquia end