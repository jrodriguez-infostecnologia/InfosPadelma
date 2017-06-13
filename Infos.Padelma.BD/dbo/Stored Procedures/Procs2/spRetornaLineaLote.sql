create proc spRetornaLineaLote
@lote varchar(50),
@empresa int
as

select * from aLotesDetalle
where lote=@lote and empresa=@empresa