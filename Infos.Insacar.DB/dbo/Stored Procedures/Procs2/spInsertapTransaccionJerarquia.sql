CREATE proc [dbo].[spInsertapTransaccionJerarquia]
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

insert pTransaccionJerarquia
(tipo,
numero,
fecha,
empresa,
fechaRegistro,
usuario,
observacion,
anulado,
usuarioAnulado,
año,
mes
)
select
@tipo,
@numero,
@fecha,
@empresa ,
@fechaRegistro,
@usuario,
@observacion,
@anulado,
@usuarioAnulado,
@año,
@mes


if (@@error = 0 ) begin set @Retorno = 0 commit tran pTransaccionJerarquia end else begin set @Retorno = 1 rollback tran pTransaccionJerarquia end