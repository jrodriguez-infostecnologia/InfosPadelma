CREATE proc [dbo].[spcontabilizaNominaTipoPeriodo]
@año int, 
@periodo int,
@tipo varchar(4),
@empresa int,
@fechaT datetime,
@usuario varchar(50),
@observacion varchar(500),
@numeroLiquidacion varchar(50),
@retorno varchar(50) output,
@numeroTraCont varchar(50) output
as

begin tran ccontabilizacion

set @retorno=0

declare @periodoContable varchar(6), @tipoTransaccion varchar(50), @numeroTransaccion varchar(50), @retornoConsecutivo varchar(50)

if  @tipo = 'CA' set @tipoTransaccion='CAU' 
if  @tipo = 'PR' set @tipoTransaccion='PRO' 
if  @tipo = 'SS' set @tipoTransaccion='SGS' 
if  @tipo = 'PA' set @tipoTransaccion='PAG' 
if  @tipo = 'PS' set @tipoTransaccion='CPS' 
if  @tipo = 'CC' set @tipoTransaccion='CAC' 
if  @tipo = 'CI' set @tipoTransaccion='CAI' 

if not exists(select * from gTipoTransaccion where codigo = @tipoTransaccion and empresa=@empresa)
begin
set @retorno=2
end
else
begin
	 exec spRetornaConsecutivoTransaccion @tipoTransaccion, @empresa, @numeroTransaccion output
end

set @periodoContable = (select top 1 periodoContable from cPrecontabilizacion where empresa=@empresa and periodoNomina=@periodo and año=@año and tipo=@tipo )

if  (select cerrado from cPeriodo where empresa=@empresa and periodo= isnull(@periodoContable,''))  = 1
begin
set @retorno=3
end

if exists (select distinct * from cPrecontabilizacion where empresa=@empresa and periodoNomina=@periodo and año=@año and tipo=@tipo and cuentaContable='')
begin
set @retorno=4
end


if not exists (select distinct * from cPrecontabilizacion where empresa=@empresa and periodoNomina=@periodo and año=@año and tipo=@tipo)
begin
set @retorno=5
end


if exists (select distinct * from cPrecontabilizacion where empresa=@empresa and periodoNomina=@periodo and año=@año and tipo=@tipo and estado=0 
and ((len(ltrim(rtrim(mCcostoContable)))>0 and  len(ltrim(rtrim(aCcostoContable)))=0)  or (len(ltrim(rtrim(mCcostoContable)))=0 and  len(ltrim(rtrim(aCcostoContable)))>0)) ) 
begin
set @retorno=6
end


if exists (select distinct * from cContabilizacion where empresa=@empresa and periodoNomina=@periodo and año=@año and tipoLiquidacion=@tipo and anulado=0 and tipoLiquidacion<> 'PS' )
begin
set @retorno=7 
set @numeroTransaccion = (select distinct numero from cContabilizacion where empresa=@empresa and periodoNomina=@periodo and año=@año and tipoLiquidacion=@tipo and anulado=0)
end



if exists (select distinct * from cContabilizacion a join cContabilizacionDetalle b on a.numero=b.numero and a.tipo=b.tipo where a.empresa=@empresa and a.periodoNomina=@periodo and a.año=@año and a.tipoLiquidacion='PS' and anulado=0 and b.docNomina =  @numeroLiquidacion )
begin
set @retorno=8
set @numeroTransaccion = (select distinct a.numero from cContabilizacion a join cContabilizacionDetalle b on a.numero=b.numero and a.tipo=b.tipo where a.empresa=@empresa and a.periodoNomina=@periodo and a.año=@año and a.tipoLiquidacion=@tipo and anulado=0 and b.docNomina=@numeroLiquidacion )
end

IF @tipo='ps'
begin
if not exists (select distinct * from cPrecontabilizacion where empresa=@empresa and periodoNomina=@periodo and año=@año  and isnull(docNomina,'') =  isnull(@numeroLiquidacion,'') )
begin
set @retorno=9
set @numeroTransaccion = (select distinct a.numero from cContabilizacion a join cContabilizacionDetalle b on a.numero=b.numero and a.tipo=b.tipo where a.empresa=@empresa and a.periodoNomina=@periodo and a.año=@año and a.tipoLiquidacion=@tipo and anulado=0 and b.docNomina=@numeroLiquidacion )
end
end



if @retorno=0
begin
insert cContabilizacion
select top 1 empresa,
@tipoTransaccion,
@numeroTransaccion,
tipo,
año,
mes,
periodoContable,
@periodo,
1,
@fechat,
getdate(),
@usuario,
@observacion,
0,
null,
null
from cPrecontabilizacion where empresa=@empresa and periodoNomina=@periodo and año=@año and tipo=@tipo

insert cContabilizacionDetalle
select empresa	,
@tipoTransaccion,
@numeroTransaccion,
tipo	,
año	,
mes	,
periodoContable	,
registro	,
codigoEmpleado	,
identificacionEmpleado	,
tipoNomina	,
docNomina	,
contrato	,
periodoNomina	,
claseContrato	,
manejaLabCam	,
manejaHE	,
mCcostoNomina	,
aCcostoNomina	,
departamento	,
codigoConcepto	,
codigoLabor	,
cuentaContable	,
mCcostoContable	,
aCcostoContable	,
terceroContable	,
debito	,
credito	,
entidadSalud	,
entidadPension	,
entidadArl	,
entidadCaja	,
entidadSena	,
entidadCesantias	,
EntidadFsolidaridad	,
EntidadICBF	,
EntidadAdicional	,
mCcostoLote	,
aCcostoLote	,
LoteDesarrollo	,
baseCesantias	,
basePrimas	,
baseIntereses	,
baseVacaciones	,
baseEmbargos	,
baseCajaCompensacion	,
baseSeguridadSocial	,
tipoConcepto	,
conceptoReferencia	,
1	,
@fechaT	,
getdate()	,
@usuario	
from cPrecontabilizacion where empresa=@empresa and periodoNomina=@periodo and año=@año and tipo=@tipo
and  isnull(docNomina,'') like '%'+isnull(@numeroLiquidacion,'')+'%'


update cPrecontabilizacion 
set estado=1
where empresa=@empresa and periodoNomina=@periodo and año=@año and tipo=@tipo
and isnull(docNomina,'') like '%'+isnull(@numeroLiquidacion,'')+'%'

exec [dbo].[spActualizaConsecutivoTransaccion]
	@tipoTransaccion,
	@empresa,
	@retornoConsecutivo output

end

if @numeroTraCont is null
set @numeroTraCont=''

	
if @@ERROR = 0
begin
	set @numeroTraCont = isnull(@numeroTransaccion,'')
	commit tran ccontabilizacion
end
else
begin
	rollback tran ccontabilizacion
end

--go
--declare @retorno varchar(50), @numeroTraCont varchar(50)

--exec spcontabilizaNominaTipoPeriodo
--2016, 
--25,
--'CA',
--1,
--'27/07/2016',
--'SISTEMA',
--'PRUEBA',
--@retorno output,
--@numeroTraCont  output

--select @retorno, @numeroTraCont