CREATE proc spAnulaTransacionContable
@empresa int,
@tipo varchar(50),
@tipoLiquidacion varchar(50),
@numero varchar(50),
@año int,
@periodo int,
@usuario varchar(50),
@retorno int output
as

begin tran anulaConta

update cContabilizacion
set anulado=1,
usuarioAnulado=@usuario,
fechaAnulado=getdate(),
observacion = '** REGISTRO ANULADO ** por ' +  @usuario  
where empresa=@empresa and tipoLiquidacion=@tipoLiquidacion and periodoNomina=@periodo
and tipo=@tipo and numero=@numero 
and año=@año

update cPrecontabilizacion
set estado=0
where empresa=@empresa and tipo=@tipoLiquidacion and periodoNomina=@periodo
and año=@año 

if @@ERROR = 0
begin
set @retorno=0
commit tran anulaConta
end
else
begin
set @retorno=1 
rollback tran anulaConta
end