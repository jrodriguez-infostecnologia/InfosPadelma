
CREATE proc [dbo].[spConsecutivoProrrogaContratoTercero]
@empresa int,
@tercero int,
@contrato int,
@tipo varchar(1),
@consecutivo int output
as

set @consecutivo = ( select max(id) +1 from nProrroga
where empresa=@empresa and tercero=@tercero 
--and tipo=@tipo 
and contrato=@contrato)

if @consecutivo is null
set @consecutivo=1