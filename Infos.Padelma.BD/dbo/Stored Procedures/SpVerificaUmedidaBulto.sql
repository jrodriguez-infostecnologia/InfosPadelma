create proc SpVerificaUmedidaBulto
@umedida varchar(50),
@empresa int,
@retorno int output

as

declare @bulto varchar(50)

select  @bulto=codigo from gUnidadMedida
where empresa=@empresa and codigo=@umedida


if @bulto='BUL'
begin
	set @retorno = 1 
end
else
begin
	set @retorno = 0
end