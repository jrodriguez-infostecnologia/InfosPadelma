create proc [dbo].[spVerificaClaseContrato]
@empresa int,
@clase varchar(50),
@retorno int output
as

set
@retorno = 0

select @retorno = terminoFijo from nclasecontrato
where empresa=@empresa and codigo = @clase