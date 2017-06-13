CREATE proc [dbo].[spActualizapTransaccionJerarquia]
@empresa int,
@tipo varchar(50),
@numero varchar(50),
@año int,
@mes int,
@fechaRegistro datetime,
@fecha datetime,
@usuario varchar(50),
@observacion varchar(500),
@anulado bit,
@usuarioAnulado varchar(50),
@Retorno int output
as
begin tran pTransaccionJerarquia

update pTransaccionJerarquia
set 
fechaRegistro = @fechaRegistro,
usuario = @usuario,
observacion = @observacion,
anulado = @anulado,
usuarioAnulado = @usuarioAnulado
where tipo = @tipo and
numero = @numero and
fecha = @fecha and
empresa=@empresa and
año=@año and
mes =@mes

if (@@error = 0 ) begin set @Retorno = 0 commit tran pTransaccionJerarquia end else begin set @Retorno = 1 rollback tran pTransaccionJerarquia end