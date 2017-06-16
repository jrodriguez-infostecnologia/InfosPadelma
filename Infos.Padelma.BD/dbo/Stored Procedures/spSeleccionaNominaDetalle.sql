
CREATE PROCEDURE spSeleccionaNominaDetalle
	@Año int = 2016, 
	@Periodo int = 13, 
	@Empresa int = 1,
	@Tipo varchar(50) = 'LQC',
	@Numero varchar(50) = 'LQC00000000000000000018',
	@CodTercero int = 319,
	@CodContrato int = 1
AS
BEGIN
	SELECT
	vLiq.registroDetalleNomina,
	vLiq.codConcepto,
	vLiq.Expr1 descripcionConcepto,
	vLiq.cantidad,
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