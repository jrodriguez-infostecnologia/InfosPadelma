

create proc [dbo].[spConsecutivoIncapacidadTercero]
@tercero varchar(50),@empresa int,@consecutivo int output
as

set @consecutivo= (select Max(numero)+1 from nIncapacidad 
where tercero=@tercero
and empresa=@empresa)

if @consecutivo is null
set @consecutivo=1