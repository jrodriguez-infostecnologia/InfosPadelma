CREATE proc [dbo].[spValidarNumeroPalmas]
@concepto varchar(50),
@lote varchar(50),
@linea  int,
@empresa int,
@cantidad float,
@retorno int output
as

declare @noPalmas int

set @retorno=0

if  exists (select * from aNovedad where codigo=@concepto and empresa=@empresa and naturaleza=2)
begin
		
	set @noPalmas = isnull((select sum(noPalma) from  aLotesDetalle where lote=@lote and linea=@linea and empresa=@empresa),0)
	
	if @cantidad > @noPalmas
	begin
		set @retorno=1
	end
end