CREATE proc [dbo].[spSeleccionaLoteDetalle]
@empresa int,
@codigo char(10)
as

select * from aLotesDetalle
where empresa=@empresa and lote=@codigo