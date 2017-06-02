﻿
CREATE PROCEDURE spSeleccionaContratoExistenteNominaDetalle
	@Año int = 2016, 
	@Periodo int = 13, 
	@Empresa int = 1,
	@Tipo varchar(50) = 'LQC',
	@Numero varchar(50) = 'LQC00000000000000000018',
	@CodTercero int = 319
AS
BEGIN
	SELECT DISTINCT vLiq.id codContrato,
	'No. Contrato ('+ convert(varchar,vLiq.id)+') - Fecha Retiro ' + CONVERT(varchar, vLiq.fechaRetiro,103) descContrato
	FROM
	vLiquidacionDefinitivaReal vLiq
	WHERE vLiq.empresa = @Empresa
	AND vLiq.año = @Año
	AND vLiq.noPeriodo = @Periodo
	AND vLiq.tipo = @Tipo
	AND vLiq.numero = @Numero
	AND vLiq.codTercero = @CodTercero;
END