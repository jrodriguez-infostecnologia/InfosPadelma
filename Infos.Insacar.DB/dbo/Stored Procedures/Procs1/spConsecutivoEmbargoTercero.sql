
create proc [dbo].[spConsecutivoEmbargoTercero]
@tercero int,
@empresa int,
@consecutivo int output
as

set @consecutivo= (select max(codigo) +1 from nEmbargos
where empleado=@tercero
and empresa=@empresa)

if @consecutivo is null
set @consecutivo=1