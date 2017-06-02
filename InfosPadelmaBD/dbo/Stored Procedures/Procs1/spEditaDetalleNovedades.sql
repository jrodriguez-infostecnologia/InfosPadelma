CREATE PROCEDURE [dbo].[spEditaDetalleNovedades] @empresa int,@registro int,@cantidad int,@añoInicial int,@añoFinal int,@periodoInicial int,@periodoFinal int,
@frecuencia int,@valor money,@anulado bit,@tipo varchar(50),@numero varchar(50),@concepto varchar(50),@empleado varchar(50),@detalle varchar(250),@Retorno int output  
AS begin tran nNovedadesDetalle update nNovedadesDetalle set cantidad = @cantidad,añoInicial = @añoInicial,añoFinal=@añoFinal,periodoInicial = @periodoInicial,periodoFinal = @periodoFinal,
frecuencia = @frecuencia,valor = @valor,anulado = @anulado,concepto = @concepto,empleado = @empleado,detalle = @detalle 
where empresa = @empresa and tipo = @tipo and numero = @numero and registro = @registro 
if (@@error = 0 ) begin set @Retorno = 0 commit tran nNovedadesDetalle end else begin set @Retorno = 1 rollback tran nNovedadesDetalle end