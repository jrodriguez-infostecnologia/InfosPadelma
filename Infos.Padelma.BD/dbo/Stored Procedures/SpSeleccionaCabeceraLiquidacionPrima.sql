CREATE PROCEDURE [dbo].[SpSeleccionaCabeceraLiquidacionPrima]
	@empresa int,
	@tipo varchar(50),
	@numero varchar(50)
AS
	SELECT DISTINCT
		liq.tipo,
		liq.numero,
		liq.periodo,
		liq.año,
		liq.fecha,
		liq.observacion,
		item.añoInicial,
		item.añoFinal,
		item.periodoInicial,
		item.periodoFinal
	FROM nLiquidacionPrimaDetalle item
	INNER JOIN nLiquidacionPrima liq
	ON liq.empresa = item.empresa
	AND liq.tipo = item.tipo
	AND liq.numero = item.numero
	WHERE 
	liq.empresa = @empresa AND
	liq.tipo = @tipo AND
	liq.numero = @numero;
RETURN 0
