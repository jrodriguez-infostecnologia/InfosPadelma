
CREATE proc [dbo].[spSeleccionaNovedadLoteRangoSiembra]
@lote varchar(50), @empresa int,@fechaLabor date
as

declare @añoDesde int , @añohasta int,  @añosDiferencia int
set @añohasta = DATEPART(year, @fechaLabor)

select @añoDesde=añoSiembra from aLotes where codigo=@lote and empresa=@empresa
set @añosDiferencia= @añohasta - @añoDesde

select top 1 * from aNovedad where claseLabor=2
and  @añosDiferencia between añodesde and añoHasta and empresa=@empresa