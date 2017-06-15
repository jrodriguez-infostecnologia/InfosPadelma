CREATE PROCEDURE spEliminaNominaDetalle
	@Año int = 2016, 
	@Periodo int = 13, 
	@Empresa int = 1,
	@Tipo varchar(50) = 'LQC',
	@Numero varchar(50) = 'LQC00000000000000000018',
	@CodTercero int = 319,
	@CodContrato int = 1
AS
	DELETE FROM nLiquidacionNominaDetalle 
	WHERE empresa = @Empresa
	AND año = @Año
	AND noPeriodo = @Periodo
	AND tipo = @Tipo
	AND numero = @Numero
	AND tercero = @CodTercero
	AND contrato = @CodContrato;
RETURN 0

