CREATE proc spValidaMenuModulos
@modulo varchar(150),
@retorno int output
as

		if exists (select * from sMenu
		where codigo=@modulo)
		begin
			set @retorno =0
		end
		else
		begin
			set @retorno =1
		end