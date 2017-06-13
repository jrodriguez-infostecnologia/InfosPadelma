CREATE proc [dbo].[spActualizapTransaccionJerarquiaAnalisis]
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
@Retorno int
as
begin tran pTransaccionJerarquiaAnalisis

update pTransaccionJerarquiaAnalisis
set
resultado = @resultado,
prioridad = @prioridad,
valor = @valor,
fechaRegistro = @fechaRegistro,
usuario = @usuario
where 

tipo = @tipo and 
numero = @numero and
jerarquia = @jerarquia 
and fecha=@fecha
and empresa=@empresa
and analisis = @analisis
and registro =@registro
and año=@año
and mes =@mes



if (@@error = 0 ) begin set @Retorno = 0 commit tran pTransaccionJerarquiaAnalisis end else begin set @Retorno = 1 rollback tran pTransaccionJerarquiaAnalisis end