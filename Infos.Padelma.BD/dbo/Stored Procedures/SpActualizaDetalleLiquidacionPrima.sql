CREATE PROCEDURE [dbo].[SpActualizaDetalleLiquidacionPrima]
	@DataTable as ActualizaDetalleLiquidacionPrimaType READONLY
AS
	UPDATE 
	liqPrima 		
	SET 
	basico = _source.basico,
	valorTransporte = _source.valorTransporte,
	valorPromedio = _source.valorPromedio,
	base = _source.base,
	diasPromedio = _source.diasPromedio,
	diasPrimas = _source.diasPrimas,
	valorPrima = _source.valorPrima
	FROM 
	nLiquidacionPrimaDetalle liqPrima
	INNER JOIN @DataTable _source
	ON _source.empresa = liqPrima.empresa
	AND _source.tipo = liqPrima.tipo
	AND _source.numero = liqPrima.numero
	AND _source.tercero = liqPrima.tercero;
RETURN 0
