create proc [dbo].[spConsecutivoContratoTercero]
@tercero varchar(50),
@empresa int,
@consecutivo int output
as

set @consecutivo= (select Max(id)+1 from nContratos
where codigoTercero=@tercero
and empresa=@empresa)

if @consecutivo is null
set @consecutivo=1