
CREATE PROCEDURE [dbo].[SpInsertaaTransaccionTercero] @empresa int,@año int,@mes int,@novedad varchar(50),@registro int,
@tercero int,@ejecutado bit,@cantidad decimal(18,2),@jornales decimal(18,2),@precioLabor money,
@saldo decimal(18,2),@tipo varchar(50),@numero varchar(50),@seccion varchar(50),@registroNovedad int,
@zCuadrilla varchar(50),
@lote char(10),@Retorno int output  AS 
begin tran aTransaccionTercero 

declare @perido int,@ccosto varchar(50),@contrato int
set @perido = (select top 1 periodo from aTransaccion where numero=@numero and tipo=@tipo and empresa=@empresa)
set @registro= (select count(*) from aTransaccionTercero where 	numero=@numero and tipo=@tipo and novedad=@novedad	and empresa=@empresa)

select @ccosto=ccosto,@contrato= id from nContratos where empresa=@empresa and tercero=@tercero --and activo=1
and id in (select max(id) from nContratos where empresa=@empresa and tercero=@tercero --and activo=1
)

if (select b.ccosto from aNovedad a join aGrupoNovedad b on b.codigo=a.grupo and b.empresa=a.empresa where a.empresa=@empresa and a.codigo=@novedad) is not null
	set @ccosto = (select ccosto from aNovedad a join aGrupoNovedad b on b.codigo=a.grupo and b.empresa=a.empresa where a.empresa=@empresa and a.codigo=@novedad)

if EXISTS(select * from aNovedadLotePrecio where empresa=@empresa and novedad=@novedad and baseSueldo=1)
	set @precioLabor = isnull((select top 1 salario / 30 from nContratos where empresa=@empresa and tercero=@tercero and activo=1),0)

declare @valorTotal int = round(isnull(@cantidad,0)*isnull(@precioLabor,0),0)

insert aTransaccionTercero( empresa,año,mes,novedad,registro,tercero,ejecutado,cantidad,jornales,saldo,tipo,numero,seccion,zCuadrilla,lote, registroNovedad, precioLabor,valorTotal,periodo,ccosto,contrato ) 
select @empresa,@año,@mes,@novedad,@registro,@tercero,@ejecutado,@cantidad,@jornales,@saldo,@tipo,@numero,@seccion,@zCuadrilla,@lote,@registroNovedad,@precioLabor,@valorTotal,@perido,@ccosto,@contrato
if (@@error = 0 ) begin set @Retorno = 0 commit tran aTransaccionTercero end else begin set @Retorno = 1 rollback tran aTransaccionTercero end