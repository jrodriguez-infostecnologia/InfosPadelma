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

select @registro = registro +1 from npagosNomina
where periodoNomina=@periodoNomina and año=@año and mes=@mes
and empresa=@empresa

insert nPagosNomina( fecha,empresa,año,periodoNomina,fechaAnualado,fechaRegistro,anulado,Banco,TipoCuenta,noCuenta,NoChequeInicial,usuario,usuarioAnulado,mes, registro,valorTotal , numero) 
select @fecha,@empresa,@año,@periodoNomina,@fechaAnualado,@fechaRegistro,@anulado,@Banco,@TipoCuenta,@noCuenta,@NoChequeInicial,@usuario,@usuarioAnulado,@mes,@registro,@valorTotal, @numero

if exists (select * from nPagosNominaDetalle where periodoNomina=@periodoNomina and año=@año and mes=@mes and empresa=@empresa)
and @NoChequeInicial <>''
	set @NoChequeInicial = (select max(noCheque)+1 from nPagosNominaDetalle where periodoNomina=@periodoNomina and año=@año and mes=@mes and empresa=@empresa)

insert  nPagosNominaDetalle
select distinct empresa, año, mes, noPeriodo,@registro, Item, codigoBanco, tercero, claseContrato, valorPago, tipoCuenta,  @numero,@NoChequeInicial, formaPago , nocontrato,codCcosto
from vSeleccionaPago
where noPeriodo=@periodoNomina and año=@año and empresa=@empresa and numero=@numero

update nLiquidacionNomina
set estado='L'
where empresa=@empresa and numero = @numero


 if (@@error = 0 ) begin set @Retorno = 0 
 commit tran nPagosNomina end else begin set 
 @Retorno = 1 rollback tran nPagosNomina end