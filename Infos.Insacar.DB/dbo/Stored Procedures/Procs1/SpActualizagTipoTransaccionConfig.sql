CREATE PROCEDURE [dbo].[SpActualizagTipoTransaccionConfig] @empresa int,@nivelDestino int,@ajuste bit,@salida bit,@validaSaldo bit,@manejaTalonario bit,@mTipoLiquidacionNomina bit,@tipoLiquidacionNomina varchar(50),
@referenciaTercero bit,@cantidadEditable bit,@vUnitarioEditable bit,@pIvaEditable bit,@manejaBodega bit,@liberaReferencia bit,@entradaDirecta bit,@registroDirecto bit,
@consignacion bit,@diaSemana bit,@manejaDocumento bit,@vigencia bit,@pDesEditable bit,@UmedidaEditable bit,@estudioCompra bit,@registroProveedor bit,@fechaActual bit,
@manejaBascula bit,@tipoTransaccion varchar(50),@formatoImpresion varchar(250),@dsReferenciaDetalle varchar(250),@Retorno int output  AS begin tran gTipoTransaccionConfig 
update gTipoTransaccionConfig set nivelDestino = @nivelDestino,ajuste = @ajuste,salida = @salida,validaSaldo = @validaSaldo,manejaTalonario = @manejaTalonario,
referenciaTercero = @referenciaTercero,cantidadEditable = @cantidadEditable,vUnitarioEditable = @vUnitarioEditable,pIvaEditable = @pIvaEditable,manejaBodega = @manejaBodega,
liberaReferencia = @liberaReferencia,entradaDirecta = @entradaDirecta,registroDirecto = @registroDirecto,consignacion = @consignacion,diaSemana = @diaSemana,manejaDocumento = @manejaDocumento,
vigencia = @vigencia,pDesEditable = @pDesEditable,UmedidaEditable = @UmedidaEditable,estudioCompra = @estudioCompra,registroProveedor = @registroProveedor,
fechaActual = @fechaActual,manejaBascula = @manejaBascula,formatoImpresion = @formatoImpresion,dsReferenciaDetalle = @dsReferenciaDetalle,
mTipoLiquidacionNomina=@mTipoLiquidacionNomina , tipoLiquidacionNomina=@tipoLiquidacionNomina
where empresa = @empresa and tipoTransaccion = @tipoTransaccion 
if (@@error = 0 ) begin set @Retorno = 0 commit tran gTipoTransaccionConfig end 
else begin set @Retorno = 1 rollback tran gTipoTransaccionConfig end