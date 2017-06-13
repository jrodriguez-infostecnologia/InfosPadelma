CREATE proc [dbo].[spInsertapTransaccionJerarquiaAnalisis]
@tipo varchar(50),
@numero varchar(50),
@jerarquia int,
@año int,
@mes int,
@analisis varchar(50),
@fecha datetime,
@resultado bit,
@prioridad int,
@valor decimal(18, 4),
@fechaRegistro datetime,
@empresa int,
@usuario varchar(50),
@registro int,
@Retorno int output
as
begin tran pTransaccionJerarquiaAnalisis

insert pTransaccionJerarquiaAnalisis
(
tipo,
numero,
fecha,
empresa,
jerarquia,
analisis,
resultado,
prioridad,
valor,
fechaRegistro,
usuario,
registro,
año,
mes
)
select
@tipo,
@numero,
@fecha,
@empresa,
@jerarquia,
@analisis,
@resultado,
@prioridad,
@valor,
@fechaRegistro,
@usuario,
@registro,
@año,
@mes



if (@@error = 0 ) begin set @Retorno = 0 commit tran pTransaccionJerarquiaAnalisis end else begin set @Retorno = 1 rollback tran pTransaccionJerarquiaAnalisis end