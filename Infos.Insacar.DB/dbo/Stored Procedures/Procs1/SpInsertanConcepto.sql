
CREATE PROCEDURE [dbo].[SpInsertanConcepto] @empresa int,@signo int,@tipoLiquidacion int,@controlConcepto int,@descuentaDomingo bit ,@descuentaTransporte bit,
@prioridad int,@prestacionSocial bit,@sumaPrestacionSocial bit,@mostrarCantidad bit,@nomes int,
@valor money,@valorMinimo money,@fechaRegistro datetime,@basePrimas bit,@baseCajaCompensacion bit,@baseCesantias bit,@baseVacaciones bit,@baseIntereses bit,@baseSeguridadSocial bit,@baseEmbargo bit,
@controlaSaldo bit,@manejaRango bit,@ingresoGravado bit,@activo bit,@validaPorcentaje bit,@fijo bit,@porcentaje decimal,@codigo varchar(50),@descripcion varchar(550),@mostrarFecha bit,@noMostrar bit,@ausentismo bit,
@mostrarDetalle bit,@abreviatura varchar(20),@base varchar(50),@usuarioRegistro varchar(50),@Retorno int output  AS begin tran nConcepto 
insert nConcepto( empresa,signo,tipoLiquidacion,controlConcepto,prioridad,valor,valorMinimo,fechaRegistro,basePrimas,baseCajaCompensacion,baseCesantias,baseVacaciones,
baseIntereses,baseSeguridadSocial,baseEmbargo,controlaSaldo,manejaRango,ingresoGravado,activo,validaPorcentaje,fijo,porcentaje,codigo,descripcion,abreviatura,base,usuarioRegistro,
 descuentaDomingo,descuentaTransporte, mostrarFecha,noMostrar,mostrarDetalle,ausentismo ,prestacionSocial,sumaPrestacionSocial,mostrarCantidad, noMes) 
select @empresa,@signo,@tipoLiquidacion,@controlConcepto,@prioridad,@valor,@valorMinimo,@fechaRegistro,@basePrimas,@baseCajaCompensacion,@baseCesantias,@baseVacaciones,@baseIntereses,
@baseSeguridadSocial,@baseEmbargo,@controlaSaldo,@manejaRango,@ingresoGravado,@activo,@validaPorcentaje,@fijo,@porcentaje,@codigo,@descripcion,@abreviatura,@base,@usuarioRegistro ,
@descuentaDomingo,@descuentaTransporte,@mostrarFecha,@noMostrar,@mostrarDetalle,@ausentismo,@prestacionSocial,@sumaPrestacionSocial,@mostrarCantidad,@nomes
if (@@error = 0 ) begin set @Retorno = 0 commit tran nConcepto end else begin set @Retorno = 1 rollback tran nConcepto end