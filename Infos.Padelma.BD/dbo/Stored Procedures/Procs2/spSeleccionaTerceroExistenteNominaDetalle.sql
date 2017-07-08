
CREATE PROCEDURE spSeleccionaTerceroExistenteNominaDetalle
	@Año int = 2016, 
	@Periodo int = 13, 
	@Empresa int = 1,
	@Tipo varchar(50) = 'LQC',
	@Numero varchar(50) = 'LQC00000000000000000018'
AS
BEGIN
	SELECT DISTINCT vLiq.codTercero, CONCAT(vLiq.codTercero,' - ', vLiq.descripcion) descripcion 
	FROM
	vLiquidacionDefinitivaReal vLiq
	WHERE vLiq.empresa = @Empresa
	AND vLiq.año = @Año
	AND vLiq.noPeriodo = @Periodo
	AND vLiq.tipo = @Tipo
	AND vLiq.numero = @Numero;
END