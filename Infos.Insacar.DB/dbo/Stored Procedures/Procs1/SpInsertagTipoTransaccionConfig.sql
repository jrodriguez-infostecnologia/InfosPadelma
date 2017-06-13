CREATE PROCEDURE [dbo].[SpInsertagTipoTransaccionConfig] @empresa int,@nivelDestino int,@ajuste bit,@salida bit,@validaSaldo bit,@manejaTalonario bit,@mTipoLiquidacionNomina bit,@tipoLiquidacionNomina varchar(50),
@referenciaTercero bit,@cantidadEditable bit,@vUnitarioEditable bit,@pIvaEditable bit,@manejaBodega bit,@liberaReferencia bit,@entradaDirecta bit,@registroDirecto bit,@consignacion bit,
@diaSemana bit,@manejaDocumento bit,@vigencia bit,@pDesEditable bit,@UmedidaEditable bit,@estudioCompra bit,@registroProveedor bit,@fechaActual bit,@manejaBascula bit,
@tipoTransaccion varchar(50),@formatoImpresion varchar(250),@dsReferenciaDetalle varchar(250),@Retorno int output  AS begin tran gTipoTransaccionConfig 
insert gTipoTransaccionConfig( empresa,nivelDestino,ajuste,salida,validaSaldo,manejaTalonario,referenciaTercero,cantidadEditable,vUnitarioEditable,
pIvaEditable,manejaBodega,liberaReferencia,entradaDirecta,registroDirecto,consignacion,diaSemana,manejaDocumento,vigencia,pDesEditable,UmedidaEditable,
estudioCompra,registroProveedor,fechaActual,manejaBascula,tipoTransaccion,formatoImpresion,dsReferenciaDetalle ,mTipoLiquidacionNomina,tipoLiquidacionNomina) 
select @empresa,@nivelDestino,@ajuste,@salida,@validaSaldo,@manejaTalonario,@referenciaTercero,@cantidadEditable,@vUnitarioEditable,@pIvaEditable,
@manejaBodega,@liberaReferencia,@entradaDirecta,@registroDirecto,@consignacion,@diaSemana,@manejaDocumento,@vigencia,@pDesEditable,@UmedidaEditable,@estudioCompra,
@registroProveedor,@fechaActual,@manejaBascula,@tipoTransaccion,@formatoImpresion,@dsReferenciaDetalle,@mTipoLiquidacionNomina,@tipoLiquidacionNomina
if (@@error = 0 ) begin set @Retorno = 0 commit tran gTipoTransaccionConfig end else begin set @Retorno = 1 rollback tran gTipoTransaccionConfig end