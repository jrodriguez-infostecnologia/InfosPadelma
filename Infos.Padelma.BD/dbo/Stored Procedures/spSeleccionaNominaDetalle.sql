
CREATE PROCEDURE [dbo].[spSeleccionaNominaDetalle]
	@Año int = 2017, 
	@Periodo int = 17, 
	@Empresa int = 3,
	@Tipo varchar(50) = 'LQN',
	@Numero varchar(50) = 'LQN00000000000000000080',
	@CodTercero int = 280,
	@CodContrato int = 1
AS
BEGIN
	SELECT
	vLiq.registroDetalleNomina,
	vLiq.codConcepto,
	vLiq.Expr1 descripcionConcepto,
	vLiq.cantidad,
	--case when valorUnitario=0 then convert(int,(valorTotal/cantidad))
	 --else  vLiq.valorUnitario end 
	vLiq.valorUnitario,
	vLiq.valorTotal,
	vLiq.valorTotalR,
	vLiq.vTotalNR,
	vLiq.porcentaje,
	vLiq.signo,
	vLiq.validaPorcentaje,
	vLiq.baseSeguridadSocial
	FROM
	vLiquidacionDefinitivaReal vLiq
	WHERE vLiq.empresa = @Empresa
	AND vLiq.año = @Año
	AND vLiq.noPeriodo = @Periodo
	AND vLiq.tipo = @Tipo
	AND vLiq.numero = @Numero
	AND vLiq.codTercero = @CodTercero
	AND vLiq.id = @CodContrato;
END