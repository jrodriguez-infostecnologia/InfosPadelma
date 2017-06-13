

CREATE proc [dbo].[spApruebaTransaccionSanidad]
@tipo varchar(50),
@numero varchar(50),
@usuario varchar(50),
@empresa int,
@retorno int output
as

begin tran apruebaSanidad

declare @concepto varchar(50), @registro int, @lote varchar(50), @linea int, @palma int ,  @cantidad float, @naturaleza int,
@registroMov int, @hBrutas decimal(18,2) , @hNetas decimal(18,2), @densidadSiembra decimal(18,2), @tipoT varchar(50), @numeroT varchar(50), @registroT int

DECLARE cursorLotes CURSOR
FOR 
select a.tipo, a.numero, b.registro ,b.item, registro ,b.lote, b.linea, palma, cantidad, b.naturaleza from aSanidad a join aSanidadDetalle b on a.numero=b.numero and a.tipo=b.tipo
and a.empresa=b.empresa 
where a.empresa=@empresa and a.tipo=@tipo and a.numero=@numero

OPEN cursorLotes
FETCH NEXT FROM cursorLotes into @tipoT, @numeroT, @registroT,  @concepto, @registro, @lote, @linea,@palma, @cantidad,@naturaleza

WHILE @@FETCH_STATUS = 0
BEGIN

set @cantidad = isnull( @cantidad,0)
set @palma = ISNULL(@palma,0)

if @naturaleza =3 
begin
set @registroMov = (select count(*) +1 from amovimientoLotes
		where codigo=@lote and empresa=@empresa)

insert aMovimientoLotes
select @tipoT,@numeroT, @registroT,empresa, codigo, @registroMov, seccion,finca, añoSiembra, mesSiembra,palmasBrutas, 
round((palmasProduccion-@cantidad),0) palmasProduccion, hBrutas, 
 hNetas, dSiembra, variedad,
 densidad, noLineas, fechaRegistro, usuario, desarrollo from aLotes
where codigo=@lote  and empresa=@empresa

--update aLotes
--set 
--palmasProduccion = round((isnull(palmasProduccion,0)-@cantidad),0) 
--where codigo=@lote  and empresa=@empresa
--update aLotesDetalle
--set noPalma= noPalma-@cantidad
--where lote=@lote and linea=@linea and empresa=@empresa


end





FETCH NEXT FROM cursorLotes  into @tipoT, @numeroT, @registroT,  @concepto, @registro, @lote, @linea,@palma, @cantidad,@naturaleza
END

   CLOSE cursorLotes
    DEALLOCATE cursorLotes


update aSanidad
set ejecutado=1,
aprobado=1,
usuarioAprobado=@usuario,
fechaAprobado=getdate()
where numero= @numero and tipo=@tipo and empresa=@empresa

update aSanidadDetalle
set ejecutado=1
where numero= @numero and tipo=@tipo and empresa=@empresa


if @@ERROR=0
begin
set @retorno = 0
commit tran apruebaSanidad
end
else
begin
set @retorno =1
rollback tran apruebaSanidad
end



--delete aMovimientoLotes