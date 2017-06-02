
CREATE PROCEDURE [dbo].[SpInsertaaNovedad] @empresa int,@ciclos int,@tarea int,@naturaleza int,@añoDesde int,@añoHasta int,@claseLabor int,@fechaRegistro datetime,
@impuesto bit,@manejaLote bit,@manejaSaldo bit,@manejaCanal bit,@manejaLinea bit,@manejaPalma bit,@manejaRacimo bit,@manejaJornal bit,@porHaNeta bit,@porHaBruta bit,@noPrestacional bit,
@porHaProduccion bit,@manejaBascula bit,@manejaFecha bit,@manejaRango bit,@activo bit,@codigo varchar(50),@descripcion varchar(200),@desCorta varchar(50),@grupo varchar(50),
@uMedida varchar(50),@equivalencia varchar(50),@concepto varchar(50),@grupoIR varchar(50),@tipoCanal varchar(10),@usuario varchar(50), @manejaDecimal bit, 
@manejaCaracteristica bit,
@Retorno int output  AS begin tran aNovedad 
insert aNovedad( empresa,ciclos,tarea,naturaleza,añoDesde,añoHasta,claseLabor,fechaRegistro,impuesto,manejaLote,manejaSaldo,manejaCanal,manejaLinea,manejaPalma,manejaRacimo,manejaJornal,
porHaNeta,porHaBruta,porHaProduccion,manejaBascula,manejaFecha,manejaRango,activo,codigo,descripcion,desCorta,grupo,uMedida,equivalencia,concepto,grupoIR,tipoCanal,usuario,manejaDecimal,noPrestacional, manejaCaracteristica ) 
select @empresa,@ciclos,@tarea,@naturaleza,@añoDesde,@añoHasta,@claseLabor,@fechaRegistro,@impuesto,@manejaLote,@manejaSaldo,@manejaCanal,@manejaLinea,@manejaPalma,@manejaRacimo,
@manejaJornal,@porHaNeta,@porHaBruta,@porHaProduccion,@manejaBascula,@manejaFecha,@manejaRango,@activo,@codigo,@descripcion,@desCorta,@grupo,@uMedida,@equivalencia,@concepto,@grupoIR,
@tipoCanal,@usuario,@manejaDecimal,@noPrestacional, @manejaCaracteristica
 if (@@error = 0 ) begin set @Retorno = 0 commit tran aNovedad end else begin set @Retorno = 1 rollback tran aNovedad end