CREATE PROCEDURE [dbo].[SpActualizalogProgramacionVehiculo] @fecha date,@empresa int,@producto int,@tercero int,@cantidad float,@fechaDespacho datetime,@fechaRegistro datetime,@numero varchar(50),@tipo varchar(50),@vehiculo varchar(50),@despacho varchar(50),@codigoConductor varchar(50),@nombreConductor varchar(250),@programacionCarga varchar(50),@remolque varchar(50),@comercializadora varchar(50),@observacion varchar(250),@planta varchar(50),@estado varchar(2),@cliente varchar(10),@usuario varchar(50), @vehiculoPropio bit ,@certificado varchar(50), @Retorno int output  AS begin tran logProgramacionVehiculo 


update logProgramacionVehiculo set fecha = @fecha,producto = @producto,tercero = @tercero,cantidad = @cantidad,
fechaDespacho = @fechaDespacho,fechaRegistro = @fechaRegistro,vehiculo = @vehiculo,despacho = @despacho,
codigoConductor = @codigoConductor,nombreConductor = @nombreConductor,
programacionCarga = @programacionCarga,remolque = @remolque,comercializadora = @comercializadora,
certificado=@certificado,
observacion = @observacion,planta = @planta,estado = @estado,cliente = @cliente,usuario = @usuario , VehiculoPropio=@vehiculoPropio where empresa = @empresa and numero = @numero and tipo = @tipo 


if (@@error = 0 ) begin set @Retorno = 0 commit tran logProgramacionVehiculo end else begin set @Retorno = 1 rollback tran logProgramacionVehiculo end