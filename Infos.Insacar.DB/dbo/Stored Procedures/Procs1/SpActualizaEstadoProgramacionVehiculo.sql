create PROCEDURE [dbo].[SpActualizaEstadoProgramacionVehiculo] 
@numero varchar(50),
@tipo varchar(50),
@empresa int,
@estado varchar(50),
@despacho varchar(50),
@Retorno int output  
AS begin tran logProgramacionVehiculo 
update logProgramacionVehiculo set 
despacho = @despacho,
estado = @estado
where empresa = @empresa and numero = @numero and tipo = @tipo 
if (@@error = 0 ) begin set @Retorno = 0 commit tran logProgramacionVehiculo end else begin set @Retorno = 1 rollback tran logProgramacionVehiculo end