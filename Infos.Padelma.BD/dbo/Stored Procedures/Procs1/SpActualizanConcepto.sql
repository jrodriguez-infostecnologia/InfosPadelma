CREATE PROCEDURE [dbo].[SpActualizanConcepto] @empresa int,@signo int,@tipoLiquidacion int,
@controlConcepto int,@prioridad int,@valor money,@valorMinimo money,@fechaRegistro datetime,@basePrimas bit,@prestacionSocial bit,
@baseCajaCompensacion bit,@baseCesantias bit,@baseVacaciones bit,@baseIntereses bit,@baseSeguridadSocial bit,@ausentismo bit,@sumaPrestacionSocial bit,
@baseEmbargo bit,@controlaSaldo bit,@manejaRango bit,@ingresoGravado bit,@activo bit,@validaPorcentaje bit,@fijo bit,@mostrarDetalle bit,
@mostrarCantidad bit,@nomes int,
@porcentaje decimal,@codigo varchar(50),@descripcion varchar(550),@abreviatura varchar(20),@base varchar(50),@mostrarFecha bit,@noMostrar bit,
@usuarioRegistro varchar(50),@descuentaDomingo bit ,@descuentaTransporte bit, @Retorno int output  AS begin tran nConcepto
update nConcepto set signo = @signo,tipoLiquidacion = @tipoLiquidacion,controlConcepto = @controlConcepto,prioridad = @prioridad,sumaPrestacionSocial=@sumaPrestacionSocial,
descuentaDomingo=@descuentaDomingo, descuentaTransporte=@descuentaTransporte,valor = @valor,valorMinimo = @valorMinimo,fechaRegistro = @fechaRegistro,basePrimas = @basePrimas,
baseCajaCompensacion = @baseCajaCompensacion,baseCesantias = @baseCesantias,baseVacaciones = @baseVacaciones,baseIntereses = @baseIntereses,baseSeguridadSocial = @baseSeguridadSocial,
baseEmbargo = @baseEmbargo,controlaSaldo = @controlaSaldo,manejaRango = @manejaRango,ingresoGravado = @ingresoGravado,activo = @activo,validaPorcentaje = @validaPorcentaje,fijo = @fijo,
porcentaje = @porcentaje,descripcion = @descripcion,abreviatura = @abreviatura,base = @base,usuarioRegistro = @usuarioRegistro, mostrarFecha=@mostrarFecha, noMostrar=@noMostrar,
mostrarDetalle=@mostrarDetalle,ausentismo=@ausentismo,prestacionSocial=@prestacionSocial,mostrarCantidad=@mostrarCantidad,noMes=@nomes
 where empresa = @empresa and codigo = @codigo 
if (@@error = 0 ) begin set @Retorno = 0 commit tran nConcepto end else begin set @Retorno = 1 rollback tran nConcepto end