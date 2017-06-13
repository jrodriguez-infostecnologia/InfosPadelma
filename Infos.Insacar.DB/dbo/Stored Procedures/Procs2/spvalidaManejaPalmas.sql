CREATE proc [dbo].[spvalidaManejaPalmas]
@novedad varchar(50),
@empresa int,
@retorno int output
as

set @retorno = 0

if exists (
select * from anovedad
where manejaPalma= 1 and codigo=@novedad 
and empresa=@empresa)
begin
	set @retorno = 1
end