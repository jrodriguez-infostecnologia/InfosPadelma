CREATE PROCEDURE [dbo].[SpInsertanPagosNomina] 
@fecha date,
@registro int,
@empresa int,
@año int,
@periodoNomina int,
@fechaAnualado datetime,
@fechaRegistro datetime,
@anulado bit,
@Banco varchar(50),
@TipoCuenta varchar(50),
@noCuenta varchar(50),
@NoChequeInicial varchar(50),
@usuario varchar(50),
@usuarioAnulado varchar(50),
@mes int,
@numero varchar(50),
@valorTotal money,
@Retorno 
int output  
AS 
begin tran nPagosNomina 
select @mes= mes from nPeriodoDetalle
where noPeriodo=@periodoNomina and año=@año
and empresa=@empresa

declare @mcheque bit = 0
if @NoChequeInicial>0 
set @mcheque = 1

select @registro = registro +1 from npagosNomina
where periodoNomina=@periodoNomina and año=@año and mes=@mes
and empresa=@empresa

insert nPagosNomina( fecha,empresa,año,periodoNomina,fechaAnualado,fechaRegistro,anulado,Banco,TipoCuenta,noCuenta,NoChequeInicial,usuario,usuarioAnulado,mes, registro,valorTotal , numero, mPagoCheque) 
select @fecha,@empresa,@año,@periodoNomina,@fechaAnualado,@fechaRegistro,@anulado,@Banco,@TipoCuenta,@noCuenta,@NoChequeInicial,@usuario,@usuarioAnulado,@mes,@registro,@valorTotal, @numero, @mcheque


insert  nPagosNominaDetalle
select distinct empresa, año, mes, noPeriodo,@registro, Item, codigoBanco, tercero, claseContrato, valorPago, tipoCuenta,  @numero,0, formaPago , nocontrato,codCcosto
from vSeleccionaPago
where noPeriodo=@periodoNomina and año=@año and empresa=@empresa and numero=@numero
and cheque=0

insert  nPagosNominaDetalle
select distinct empresa, año, mes, noPeriodo,@registro, Item, codigoBanco, tercero, claseContrato, valorPago, tipoCuenta,  @numero,ROW_NUMBER() OVER(ORDER BY tercero desc) + @NoChequeInicial, formaPago , nocontrato,codCcosto
from vSeleccionaPago
where noPeriodo=@periodoNomina and año=@año and empresa=@empresa and numero=@numero
and cheque=1

update nLiquidacionNomina
set estado='L'
where empresa=@empresa and numero = @numero


 if (@@error = 0 ) begin set @Retorno = 0 
 commit tran nPagosNomina end else begin set 
 @Retorno = 1 rollback tran nPagosNomina end