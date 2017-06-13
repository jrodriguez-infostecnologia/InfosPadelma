create proc [dbo].[spAnulaVacaciones]
@empresa int,
@empleado int,
@periodoInicial date,
@periodoFinal date,
@registro int,
@usuario varchar(50),
@retorno int output
as
begin tran AnulaVacaciones

update  nVacaciones
set anulado=1,
usuarioAnulado=@usuario,
fechaAnulado=GETDATE()
where empleado=@empleado and empresa=@empresa and periodoInicial=@periodoInicial
and periodoFinal=@periodoFinal and registro=@registro

if (@@error = 0 )
 begin set @Retorno = 0
 commit tran AnulaVacaciones 
 end else begin set @Retorno = 1 
 rollback tran AnulaVacaciones end