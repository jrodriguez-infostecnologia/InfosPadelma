create proc [dbo].[spVerificaOrdenSalida]
@empresa int,
@despacho varchar(50),
@retorno int output
as

set @retorno =0

if ((select ordenSalida from bRegistroBascula
where tiquete=@despacho and empresa=@empresa) is not null)
begin
set @retorno = 1
end