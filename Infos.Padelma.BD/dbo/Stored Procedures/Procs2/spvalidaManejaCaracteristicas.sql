CREATE proc [dbo].[spvalidaManejaCaracteristicas]
@novedad varchar(50),
@empresa int,
@retorno int output
as

set @retorno=0

if exists(
select * from aNovedad
where codigo = @novedad and empresa=@empresa and manejaCaracteristica=1 and activo=1)
begin
set @retorno = 1
end