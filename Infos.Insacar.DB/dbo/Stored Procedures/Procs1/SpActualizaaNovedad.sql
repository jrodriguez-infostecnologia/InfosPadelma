CREATE PROCEDURE [dbo].[SpActualizaaNovedad] @empresa int,@ciclos int,@tarea int,@naturaleza int,@añoDesde int,@añoHasta int,@claseLabor int,@fechaRegistro datetime,
@impuesto bit,@manejaLote bit,@manejaSaldo bit,@manejaCanal bit,@manejaLinea bit,@manejaPalma bit,@manejaRacimo bit,@manejaJornal bit,@porHaNeta bit,@porHaBruta bit,@noPrestacional bit,
@porHaProduccion bit,@manejaBascula bit,@manejaFecha bit,@manejaRango bit,@activo bit,@codigo varchar(50),@descripcion varchar(200),@desCorta varchar(50),@manejaDecimal bit,
@grupo varchar(50),@uMedida varchar(50),@equivalencia varchar(50),@concepto varchar(50),@grupoIR varchar(50),@tipoCanal varchar(10),
@manejaCaracteristica bit,
@Retorno int output  AS begin tran aNovedad 
update aNovedad set ciclos = @ciclos,tarea = @tarea,naturaleza = @naturaleza,añoDesde = @añoDesde,añoHasta = @añoHasta,claseLabor = @claseLabor,fechaRegistro = @fechaRegistro,
impuesto = @impuesto,manejaLote = @manejaLote,manejaSaldo = @manejaSaldo,manejaCanal = @manejaCanal,manejaLinea = @manejaLinea,manejaPalma = @manejaPalma,manejaRacimo = @manejaRacimo,
manejaJornal = @manejaJornal,porHaNeta = @porHaNeta,porHaBruta = @porHaBruta,porHaProduccion = @porHaProduccion,manejaBascula = @manejaBascula,manejaFecha = @manejaFecha,
manejaRango = @manejaRango,activo = @activo,descripcion = @descripcion,desCorta = @desCorta,grupo = @grupo,uMedida = @uMedida,equivalencia = @equivalencia,concepto = @concepto,
noPrestacional=@noPrestacional,
manejaDecimal=@manejaDecimal,grupoIR = @grupoIR,tipoCanal = @tipoCanal, manejaCaracteristica=@manejaCaracteristica where codigo = @codigo and empresa = @empresa 
if (@@error = 0 ) begin set @Retorno = 0 commit tran aNovedad end 
else begin set @Retorno = 1 rollback tran aNovedad end