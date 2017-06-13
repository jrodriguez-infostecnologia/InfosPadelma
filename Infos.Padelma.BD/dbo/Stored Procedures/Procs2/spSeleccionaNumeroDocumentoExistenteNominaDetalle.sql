
CREATE PROCEDURE  spSeleccionaNumeroDocumentoExistenteNominaDetalle
	@Año int = 2016, 
	@Periodo int = 13, 
	@Empresa int = 1,
	@Tipo varchar(50) = 'LQC'
AS
BEGIN
	SELECT DISTINCT vLiq.numero 
	FROM
	vLiquidacionDefinitivaReal vLiq
	WHERE vLiq.empresa = @Empresa
	AND vLiq.año = @Año
	AND vLiq.noPeriodo = @Periodo
	AND vLiq.tipo = @Tipo;
END