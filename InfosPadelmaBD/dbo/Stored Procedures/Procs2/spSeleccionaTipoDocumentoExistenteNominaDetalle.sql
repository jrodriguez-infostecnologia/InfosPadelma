
CREATE PROCEDURE  spSeleccionaTipoDocumentoExistenteNominaDetalle
	@Año int = 2016, 
	@Periodo int = 13, 
	@Empresa int = 1
AS
BEGIN
	SELECT DISTINCT gTransac.codigo, UPPER(gTransac.descripcion) tipo
	FROM
	vLiquidacionDefinitivaReal vLiq
	INNER JOIN 
	gTipoTransaccion gTransac
	ON vLiq.tipo = gTransac.codigo 
	AND vLiq.empresa = gTransac.empresa
	WHERE vLiq.empresa = @Empresa
	AND vLiq.año = @Año
	AND vLiq.noPeriodo = @Periodo;
END