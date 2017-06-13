create proc spValidarClaseContrato
@claseContrato varchar(50),
@empresa int,
@retorno int output
as 


if exists(select * from nClaseContrato where empresa=@empresa and codigo=@claseContrato and electivaProduccion=1)
	set @retorno =1
else
	set @retorno =0