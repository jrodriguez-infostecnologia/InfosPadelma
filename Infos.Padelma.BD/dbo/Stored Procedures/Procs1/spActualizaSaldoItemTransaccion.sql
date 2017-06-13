CREATE proc [dbo].[spActualizaSaldoItemTransaccion]
@empresa int,
@tipo varchar(50),
@numero varchar(50),
@retorno int output
as


begin tran ActualizaSaldoItemTransaccion

declare @referencia varchar(50), @fecha date, @item int, @cantidad float, @lote varchar(50),  @saldoInicial float, @saldofinal float

if @tipo <> 'PFA'
BEGIN

if not exists (select * from aTransaccion where tipo=@tipo and numero=@numero and anulado=1 and empresa=@empresa)
begin
	
DECLARE cursorItems CURSOR FOR   
select item, b.cantidad, a.referencia, b.lote, a.fecha  from aTransaccion a 
join aTransaccionItem b on a.tipo=b.tipo and a.numero=b.numero and a.empresa=b.empresa
where a.empresa=@empresa  and a.tipo=@tipo and a.numero=@numero 
  
OPEN cursorItems  
  
FETCH NEXT FROM cursorItems   
INTO @item, @cantidad, @referencia, @lote, @fecha
  
WHILE @@FETCH_STATUS = 0  
BEGIN 

if not exists(select * from aTransaccionItemSaldo where empresa=@empresa and tipo = @tipo and numero=@numero and item=@item and lote=@lote)
begin
	select @saldoInicial = isnull(b.saldo,0)  from aTransaccion a join aTransaccionItem b on a.tipo=b.tipo and a.numero=b.numero
	and a.empresa=b.empresa
	where a.empresa=@empresa   and a.numero=@referencia and item=@item and b.lote=@lote

	set @saldofinal=(@saldoInicial - @cantidad)

	insert aTransaccionItemSaldo
    select @empresa empresa, @tipo tipo, @numero num, @referencia refe,  @lote lote, @item item,@fecha fecha, @saldoInicial si,  0 suma, @cantidad resta,  @saldofinal saldofinal  , 0 anu

	update aTransaccionItem 
	set saldo= @saldofinal
	where empresa=@empresa and numero=@referencia and item=@item and lote=@lote

	update aTransaccion
	set cerrado=1
	where numero=@referencia and empresa=@empresa
	
end
else
begin
	select @saldoInicial = b.saldo  from aTransaccion a join aTransaccionItem b on a.tipo=b.tipo and a.numero=b.numero
	and a.empresa=b.empresa
	where a.empresa=@empresa   and a.numero=@referencia and item=@item and b.lote=@lote


	set @saldofinal=(@saldoInicial + @cantidad)

	update aTransaccionItem 
	set saldo= @saldofinal
	where empresa=@empresa and numero=@referencia and item=@item and lote=@lote
	
	set @saldoInicial = @saldofinal

	delete aTransaccionItemSaldo
	where empresa=@empresa and tipo=@tipo and numero=@numero and referencia=@referencia and item=@item and lote=@lote

	set @saldofinal=(@saldofinal - @cantidad)
	insert aTransaccionItemSaldo
    select @empresa empresa, @tipo tipo, @numero num, @referencia refe,  @lote lote, @item item,@fecha fecha, @saldoInicial si,  0 suma, @cantidad resta,  @saldofinal saldofinal  , 0 anu

	update aTransaccionItem 
	set saldo= @saldofinal
	where empresa=@empresa and numero=@referencia and item=@item and lote=@lote

	update aTransaccion
	set cerrado=1
	where numero=@referencia and empresa=@empresa
end



FETCH NEXT FROM cursorItems   
INTO @item, @cantidad, @referencia, @lote,@fecha
end	
end

else
begin



DECLARE cursorItems CURSOR FOR   
select item, b.cantidad, a.referencia, b.lote, a.fecha  from aTransaccion a 
join aTransaccionItem b on a.tipo=b.tipo and a.numero=b.numero and a.empresa=b.empresa
where a.empresa=@empresa  and a.tipo=@tipo and a.numero=@numero  and a.anulado=1
  
OPEN cursorItems  
  
FETCH NEXT FROM cursorItems   
INTO @item, @cantidad, @referencia, @lote, @fecha
  
WHILE @@FETCH_STATUS = 0  
BEGIN 

	select @saldoInicial = b.saldo  from aTransaccion a join aTransaccionItem b on a.tipo=b.tipo and a.numero=b.numero
	and a.empresa=b.empresa
	where a.empresa=@empresa   and a.numero=@referencia and item=@item and b.lote=@lote
	set @saldofinal=(@saldoInicial + @cantidad)


	update aTransaccionItem 
	set saldo= @saldofinal
	where empresa=@empresa and numero=@referencia and item=@item and lote=@lote

	insert aTransaccionItemSaldo
    select @empresa empresa, @tipo tipo, @numero num, @referencia refe,  @lote lote, @item item,@fecha fecha, @saldoInicial si,  @cantidad suma, 0 resta,  @saldofinal saldofinal  , 1 anu

FETCH NEXT FROM cursorItems   
INTO @item, @cantidad, @referencia, @lote,@fecha
end	



end

CLOSE cursorItems  
    DEALLOCATE cursorItems  

END




if @@ERROR = 0
begin
	set @retorno = 0
	commit tran ActualizaSaldoItemTransaccion
end
else
begin
	set @retorno = 1
	rollback tran ActualizaSaldoItemTransaccion
end