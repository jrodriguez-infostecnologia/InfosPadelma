
CREATE proc [dbo].[spInsertaDetalleVacaciones] 
@empresa int,
@periodoInicial date,
@periodoFinal date,
@empleado int,
@registro int,
@concepto varchar(50),
@cantidad decimal(18,2),
@valorUnitario decimal(18,2),
@valorTotal decimal(18,2),
@noPrestamo int,
@retorno int output

as

begin tran nVacacionesDetalle

declare @signo int , @saldo decimal(18,2),
@baseSeguridadSocial bit,
@baseEmbargos bit,
@porcentaje decimal(18,2),@entidad varchar(50),
@entidadFE varchar(50),
@entidadEPS varchar(50),
@entidadPension varchar(50),
@entidadSindicato varchar(50)


select @signo = signo, @baseEmbargos=baseEmbargo, @baseSeguridadSocial=baseSeguridadSocial,
@porcentaje=porcentaje from nconcepto
where codigo=@concepto and empresa=@empresa

select @entidadEPS=entidadEps, @entidadPension =entidadPension, @entidadSindicato=entidadSindicato,
@entidadFE=entidadFondoEmpleado from ncontratos
 where tercero=@empleado and empresa=@empresa
 and activo=1

if exists (select * from nparametrosgeneral where salud=@concepto or incapacidades=@concepto and empresa=@empresa)
begin
set @entidad=(select tercero from nEntidadEps
where codigo=@entidadEps and empresa=@empresa)
end

if exists (select * from nparametrosgeneral where pension=@concepto and  empresa=@empresa)
begin
set @entidad=(select tercero from nEntidadFondoPension
where codigo=@entidadPension and empresa=@empresa)
end

if exists (select * from nparametrosgeneral where sindicato=@concepto and empresa=@empresa)
begin
set @entidad=(select tercero from nEntidadFondo
where codigo=@entidadSindicato and empresa=@empresa)
end

if exists (select * from nparametrosgeneral where fondoEmpleado=@concepto and empresa=@empresa)
begin
set @entidad=(select tercero from nEntidadFondo
where codigo=@entidadSindicato and empresa= @empresa)
end



insert 
nVacacionesDetalle
( periodoInicial,periodoFinal,empresa,empleado,registro,signo,noDias,valorUnitario,valorTotal,saldo,baseSeguridadSocial,baseEmbargos,cantidad,porcentaje,concepto,entidad,noPrestamo ) 
select
 @periodoInicial,@periodoFinal,@empresa,@empleado,@registro,@signo,0,@valorUnitario,@valorTotal,@saldo,@baseSeguridadSocial,@baseEmbargos,@cantidad,@porcentaje,@concepto,@entidad,@noPrestamo
if (@@error = 0 ) begin set @Retorno = 0 commit tran nVacacionesDetalle end else begin set @Retorno = 1 rollback tran nVacacionesDetalle end