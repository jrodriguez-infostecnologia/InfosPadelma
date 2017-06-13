create proc spSeleccionaLoteCanal
@empresa int,
@codigo varchar(10)
as



select * from aLotesCanal
where empresa=@empresa
and lote=@codigo