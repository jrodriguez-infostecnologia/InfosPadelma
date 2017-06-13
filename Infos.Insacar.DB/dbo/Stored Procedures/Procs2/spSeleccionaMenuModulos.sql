CREATE proc spSeleccionaMenuModulos
@modulo varchar(150)
as

		select * from sMenu
		where modulo=@modulo