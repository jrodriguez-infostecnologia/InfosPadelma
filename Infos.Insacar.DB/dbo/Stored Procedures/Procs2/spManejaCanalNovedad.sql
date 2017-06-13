CREATE proc [dbo].[spManejaCanalNovedad]
@novedad varchar(50),
@empresa int,
@retorno varchar(5) output
as

declare @resultado bit

select @resultado=manejacanal from anovedad
where codigo=@novedad and empresa=@empresa

if @resultado = 1
set @retorno='true'
else
set @retorno='false'