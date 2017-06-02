CREATE proc [dbo].[spDeletepTransaccionJerarquiaAnalisis]
@empresa int,
@tipo varchar(50),
@numero varchar(50),
@jerarquia int,
@año int,
@mes int,
@fecha datetime,
@Retorno int output
as
begin tran pTransaccionJerarquiaAnalisis

delete pTransaccionJerarquiaAnalisis
where tipo = @tipo and
numero = @numero and
jerarquia = @jerarquia and
fecha=@fecha and
empresa=@empresa and
año = @año and 
mes =@mes

if (@@error = 0 ) begin set @Retorno = 0 commit tran pTransaccionJerarquiaAnalisis end else begin set @Retorno = 1 rollback tran pTransaccionJerarquiaAnalisis end