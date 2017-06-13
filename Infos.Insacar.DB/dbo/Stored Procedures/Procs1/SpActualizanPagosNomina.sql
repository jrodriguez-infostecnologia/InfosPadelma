
CREATE PROCEDURE [dbo].[SpActualizanPagosNomina] @fecha date,@empresa int,@año int,@periodoNomina int,@registro int,@fechaAnualado datetime,@fechaRegistro datetime,@anulado bit,@Banco varchar(50),@TipoCuenta varchar(50),@noCuenta varchar(50),@NoChequeInicial varchar(50),@usuario varchar(50),@usuarioAnulado varchar(50),@mes int,@valorTotal money,@numero varchar(50),@Retorno int output  AS begin tran nPagosNomina 

select @mes = mes from nPeriodoDetalle
where noPeriodo=@periodoNomina and año=@año
and empresa=@empresa

delete nPagosNominaDetalle
where año=@año and mes=@mes and periodoNomina=@periodoNomina
and empresa=@empresa and registro=@registro

update nPagosNomina set fecha = @fecha,
fechaAnualado = @fechaAnualado,
fechaRegistro = @fechaRegistro,
anulado = @anulado,
Banco = @Banco,
TipoCuenta = @TipoCuenta,
noCuenta = @noCuenta,
NoChequeInicial = @NoChequeInicial,
usuario = @usuario,
usuarioAnulado = @usuarioAnulado ,
valorTotal=@valorTotal
where año = @año 
and empresa = @empresa 
and mes = @mes 
and periodoNomina = @periodoNomina 
and registro = @registro 
and anulado=0
and numero=@numero

if exists (select * from nPagosNominaDetalle where periodoNomina=@periodoNomina and año=@año and mes=@mes and empresa=@empresa)
and @NoChequeInicial <>''
set @NoChequeInicial = (select max(noCheque)+1 from nPagosNominaDetalle where periodoNomina=@periodoNomina and año=@año and mes=@mes and empresa=@empresa)


insert  nPagosNominaDetalle
select distinct empresa, año, mes, noPeriodo,@registro, Item, codigoBanco, tercero, claseContrato, valorPago, tipoCuenta,  @numero,@NoChequeInicial, formaPago , nocontrato,codCcosto
from vSeleccionaPago
where noPeriodo=@periodoNomina and año=@año and empresa=@empresa and numero=@numero


if (@@error = 0 ) begin set @Retorno = 0 
commit tran nPagosNomina end 
else begin set @Retorno = 1
rollback tran nPagosNomina end