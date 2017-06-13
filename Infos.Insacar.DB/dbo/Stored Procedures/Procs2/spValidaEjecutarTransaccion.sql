create proc spValidaEjecutarTransaccion
@tipo varchar(50),
@numero varchar(50),
@empresa int,
@retorno int output
as


if exists(select * from aTransaccionTercero where empresa=@empresa and tipo=@tipo and numero=@numero and ejecutado=1)
	 set	@retorno=1
else
set	@retorno=0