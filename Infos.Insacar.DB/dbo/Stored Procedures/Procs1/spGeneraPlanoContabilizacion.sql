CREATE proc [dbo].[spGeneraPlanoContabilizacion]
 @año int,
 @tipo varchar(4),
 @empresa int,
 @noComprobante int,
 @nota varchar(2000),
 @consecutivocruce int,
 @fecha date,
 @documentoContable varchar(50)
as

-- variables

declare @tipoDocCont varchar(50), @cuentaPuente varchar(50),  @cuentaCruce varchar(50), @comprobante varchar(50),
@Curtipo varchar(50),	@Curcomprobante varchar(10) ,@CurNocomprobante int
	,	@Curregistro int,	@CurIdentificacion varchar(50),	@CurCuentaContable varchar(50),
		@Curfecha date,	@CurmayorCcostoSigo varchar(50),	@CurccostoSig varchar(50),	@Curnota Varchar(1000)	,
		@CurNaturaleza	 varchar(1), @CurvalorTotal int, @Curclase int, @CurcuentaPuente varchar(50),
		@contador int=0, @contadorGeneral int=0, @valorDebito int, @valorCredito int, @tercerocruce varchar(50), @maximo int

-- tablas temporales
create table #causacionContableFinal (
tipo varchar(50),
comprobante varchar(50),
Nocomprobante int,
registro int,
Identificacion varchar(50),
CuentaContable varchar(50),
fecha date,
mayorCcostoSigo varchar(50),
ccostoSig varchar(50),
nota varchar(1000),
Naturaleza varchar(1),
valorTotal money
)
create table #causacionContableFinalPR (
tipo varchar(50),
comprobante varchar(50),
Nocomprobante int,
registro int,
Identificacion varchar(50),
CuentaContable varchar(50),
fecha date,
mayorCcostoSigo varchar(50),
ccostoSig varchar(50),
nota varchar(1000),
Naturaleza varchar(1),
valorTotal money
)
-- parametros
select @tipoDocCont = tipoDocumento, @cuentaPuente = cuentaPuente, @cuentaCruce=cuentaCruce, @comprobante=comprobante from cClaseParametroContaNomi
where tipo=@tipo and empresa=@empresa



insert #causacionContableFinal
select @tipoDocCont tipo,	@comprobante comprobante	,@noComprobante Nocomprobante,	ROW_NUMBER()  over (order by  @comprobante   asc)  registro,	terceroContable,	CuentaContable,	@fecha fecha,	mCCostoContable,	aCcostoContable,	@nota nota	, case when sum(debito) - sum(credito) > 0 then 'D' ELSE 'C' end naturaleza,
 ABS(round(SUM(debito) - sum(credito),0)) total
 from cContabilizacionDetalle
 where tipoliquidacion=@tipo and numero=@documentoContable and año=@año
and empresa=@empresa 
group by  cuentaContable, terceroContable,mccostoContable, accostoContable
having  ABS(round(SUM(debito) - sum(credito),0)) >0


set @maximo =(select 
count(*) from #causacionContableFinal where valorTotal>0)


DECLARE CurCont CURSOR 
FOR 
select * from
#causacionContableFinal
where #causacionContableFinal.valorTotal>0
order by Identificacion

OPEN CurCont

FETCH NEXT FROM CurCont 
INTO  @Curtipo,	@Curcomprobante,@CurNocomprobante	,	@Curregistro,	
@CurIdentificacion,	@CurCuentaContable,	@Curfecha,	@CurmayorCcostoSigo,
@CurccostoSig,	@Curnota	,@CurNaturaleza	,  @CurvalorTotal

WHILE @@FETCH_STATUS = 0
BEGIN

set @contador = @contador+1
set @contadorGeneral = @contadorGeneral +1
set @CurvalorTotal = ROUND(@CurvalorTotal,0)


 if exists ( select * from cpuc where ltrim(rtrim(codigo)) = rtrim(ltrim(@cuentaPuente)) and tercero=1 and empresa=@empresa )
 begin
	set @tercerocruce = isnull((select rtrim(ltrim(nit))  from gEmpresa where id=@empresa),'')
 end

if @consecutivocruce = @contador
 begin 

 set @valorDebito = isnull((select distinct sum(isnull(round(valorTotal,0),0)) from #causacionContableFinalPR where Naturaleza='D' and Nocomprobante = @noComprobante),0)
 set @valorCredito = isnull((select distinct sum(isnull(round(valorTotal,0),0)) from #causacionContableFinalPR where Naturaleza='C'and Nocomprobante = @noComprobante),0)
 

 insert #causacionContableFinalPR
 select distinct @Curtipo,	@Curcomprobante	,@noComprobante	,	@contador,	@tercerocruce,	@cuentaPuente,	@fecha,	'',	'',	'CRUCE DE DOCUMENTO'	,
 case when @valorDebito>@valorCredito then 'C' else 'D' end ,
 case when @valorDebito-@valorCredito>0  then @valorDebito-@valorCredito else -(@valorDebito-@valorCredito) end  total
 from #causacionContableFinalPR
 where  Nocomprobante = @noComprobante

 insert #causacionContableFinalPR
 select distinct @Curtipo,	@Curcomprobante	,@noComprobante+1	,	1,	@tercerocruce,	@cuentaPuente,	@fecha,	'',	'',	'SALDO DOCUMENTO ANTERIOR'	,
 case when @valorDebito>@valorCredito then 'D' else 'C' end ,
 case when @valorDebito-@valorCredito>0  then @valorDebito-@valorCredito else -(@valorDebito-@valorCredito) end  total
 from #causacionContableFinalPR
 where  Nocomprobante = @noComprobante
	set @noComprobante = @noComprobante +1 
	set @contador=2
 end 
 	insert #causacionContableFinalPR 
	select  @Curtipo,	@Curcomprobante,@noComprobante	,	@contador,	
	@CurIdentificacion,	@CurCuentaContable,	@Curfecha,	@CurmayorCcostoSigo,
	@CurccostoSig,	@Curnota	,@CurNaturaleza	, round( @CurvalorTotal,0)


 if @maximo = @contadorGeneral and @contador<> @consecutivocruce
 begin 

 set @valorDebito = isnull((select distinct sum(isnull(round(valorTotal,0),0)) from #causacionContableFinalPR where Naturaleza='D' and Nocomprobante = @noComprobante),0)
 set @valorCredito = isnull((select distinct sum(isnull(round(valorTotal,0),0)) from #causacionContableFinalPR where Naturaleza='C'and Nocomprobante = @noComprobante),0)

 insert #causacionContableFinalPR
 select distinct @Curtipo,	@Curcomprobante	,@noComprobante	,	@contador+1,	@tercerocruce,	@CurcuentaPuente,	@fecha,	'',	'',	'CRUCE DE DOCUMENTO'	,
 case when @valorDebito>@valorCredito then 'C' else 'D' end ,
 case when @valorDebito-@valorCredito>0  then @valorDebito-@valorCredito else -(@valorDebito-@valorCredito) end  total
 from #causacionContableFinalPR
 where  Nocomprobante = @noComprobante and abs(@valorDebito-@valorCredito)>0
  end 

FETCH NEXT FROM CurCont 
INTO  @Curtipo,	@Curcomprobante,@CurNocomprobante	,	@Curregistro,	
@CurIdentificacion,	@CurCuentaContable,	@Curfecha,	@CurmayorCcostoSigo,
@CurccostoSig,	@Curnota	,@CurNaturaleza	, @CurvalorTotal
end 


  CLOSE CurCont
    DEALLOCATE CurCont

	--select @tercerocruce

	--select Identificacion from #causacionContableFinalPR
	--where Identificacion in 
	--(select  rtrim(ltrim(nit)) from gEmpresa where id=2)

	select isnull(convert(char(1),ltrim(rtrim(tipo))),'')+
	isnull(convert(char(3),comprobante),'')+
	RIGHT(replicate('0',11) + cast((isnull(ltrim(rtrim(Nocomprobante)),'')) as varchar),11)+
	RIGHT(replicate('0',5) +cast ((isnull(ltrim(rtrim(registro)),'')) as varchar),5)+
	RIGHT(replicate('0',13) +cast (((isnull(replace(ltrim(rtrim(Identificacion)),',',''),''))) as varchar),13)+
	'000' +
	rtrim(ltrim(isnull(CuentaContable,''))) + REPLICATE('0', 10 -len(isnull(rtrim(ltrim(CuentaContable)),''))) +
	 REPLICATE('0', 13)+ --producto
	CONVERT(VARCHAR(8), convert(datetime,@fecha), 112)+
	RIGHT(replicate('0',4) + cast((isnull(convert(varchar(50),ltrim(rtrim(mayorCcostoSigo))),'')) as varchar),4)+
	RIGHT(replicate('0',3) +cast((isnull(ltrim(rtrim(ccostoSig)),'')) as varchar),3)+
	convert(char(50),isnull(ltrim(rtrim(nota)),''))+
	isnull(convert(char(1),ltrim(rtrim(Naturaleza))),'')+
	RIGHT(replicate('0',13) + cast((substring( convert(varchar(5000),ROUND(valorTotal,0)), 1,charindex('.',convert(varchar(5000),ROUND(valorTotal,0)))-1)) as varchar),13)
	+replicate('0',13)
	+replicate('0',171)
 from #causacionContableFinalPR

--  go

-- exec [dbo].[spGeneraPlanoContabilizacion]
-- 2016,
--'CA',
-- 1,
-- 100,
-- 'prueba',
-- 260,
-- '29/07/2016',
-- 'CAU0000000022 '