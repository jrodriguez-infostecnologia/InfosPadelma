create proc [dbo].[SpValidaSellos]
@sello varchar(50),
@empresa int,
@retorno int output
as


set @retorno = 0

--if exists (select * from lRegistroSellos where sello=@sello and empresa=@empresa)
--begin
--set @retorno=1
--end