CREATE proc [dbo].[spVerificaClaseConceptosContabilizacion]
@empresa int,
@clase varchar(50),
@retorno int output
as

if  exists (select * from cClaseParametroContaNomi where empresa=@empresa and codigo=@clase and (tipo='PA' or  tipo='CI'))
begin
set @retorno=1
end
else
begin
set @retorno=0
end