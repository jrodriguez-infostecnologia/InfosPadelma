
CREATE proc [dbo].[spVerificaClaseSeguridadSocial]
@clase int,
@empresa int,
@retorno int output
as

if exists(
select * from cClaseParametroContaNomi
where codigo= @clase and (tipo='SS' or tipo= 'CI') and empresa=@empresa)
begin
	set @retorno=1
end
else
begin
set @retorno=	0
end