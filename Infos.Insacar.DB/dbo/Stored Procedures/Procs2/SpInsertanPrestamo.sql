
CREATE PROCEDURE [dbo].[SpInsertanPrestamo] @fecha date,@empresa int,@empleado int,@año int,@mes int,@periodoInicial int,
@cuotas int,@cuotasPendiente int,@frecuencia int,@valor money,@valorCuotas money,@valorSaldo money,
@fechaRegistro datetime,@liquidado bit,@codigo varchar(50),@ccosto varchar(50),
@concepto varchar(50),@observacion varchar(5500),@usuarioRegistro varchar(50),@formaPago varchar(50),
@docRef varchar(200),@Retorno int output  AS begin tran nPrestamo 

if @ccosto='' 
	set @ccosto = (select top 1 ccosto from nContratos where activo=1 and empresa=@empresa and tercero=@empleado)

insert nPrestamo( fecha,empresa,empleado,año,mes,periodoInicial,cuotas,cuotasPendiente,frecuencia,valor,valorCuotas,valorSaldo,fechaRegistro,liquidado,codigo,ccosto,concepto,observacion,usuarioRegistro,formaPago,docRef ) select @fecha,@empresa,@empleado,@año,@mes,@periodoInicial,@cuotas,@cuotasPendiente,@frecuencia,@valor,@valorCuotas,@valorSaldo,@fechaRegistro,@liquidado,@codigo,@ccosto,@concepto,@observacion,@usuarioRegistro,@formaPago,@docRef if (@@error = 0 ) begin set @Retorno = 0 commit tran nPrestamo end else begin set @Retorno = 1 rollback tran nPrestamo end