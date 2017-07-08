
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
	vLiq.valorUnitario,
	vLiq.valorTotal,
	vLiq.valorTotalR,
	vLiq.vTotalNR,
	vLiq.porcentaje,
	vLiq.signo,
	vLiq.validaPorcentaje,
	vLiq.baseSeguridadSocial,
	CAST(CASE WHEN COUNT(nov.codigo)>0 THEN 1  ELSE 0 END AS BIT) agrupaLaboresAgronomico
	FROM
	vLiquidacionDefinitivaReal vLiq
	LEFT JOIN aNovedad nov
	ON nov.empresa = vLiq.empresa
	AND nov.concepto = vLiq.codConcepto
	WHERE vLiq.empresa = @Empresa
	AND vLiq.año = @Año
	AND vLiq.noPeriodo = @Periodo
	AND vLiq.tipo = @Tipo
	AND vLiq.numero = @Numero
	AND vLiq.codTercero = @CodTercero
	AND vLiq.id = @CodContrato
	GROUP BY 
	vLiq.registroDetalleNomina,
	vLiq.empresa,
	vLiq.codConcepto,
	vLiq.Expr1,
	vLiq.cantidad,
	vLiq.valorUnitario,
	vLiq.valorTotal,
	vLiq.valorTotalR,
	vLiq.vTotalNR,
	vLiq.porcentaje,
	vLiq.signo,
	vLiq.validaPorcentaje,
	vLiq.baseSeguridadSocial;
END