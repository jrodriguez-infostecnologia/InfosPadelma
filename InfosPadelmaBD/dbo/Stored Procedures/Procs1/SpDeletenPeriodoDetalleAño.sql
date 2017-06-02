
CREATE PROCEDURE [dbo].[SpDeletenPeriodoDetalleAño] @empresa int,@año int,@Retorno int output  AS begin tran nPeriodoDetalle 
delete nPeriodoDetalle where empresa = @empresa and año = @año 
if (@@error = 0 ) begin set @Retorno = 0 commit tran nPeriodoDetalle end else begin set @Retorno = 1 rollback tran nPeriodoDetalle end