CREATE PROCEDURE [dbo].[SpActualizaDetalleLiquidacionPrima]
	@DataTable as ActualizaDetalleLiquidacionPrimaType READONLY
AS
MERGE nLiquidacionPrimaDetalle AS liqPrima
USING @DataTable AS _source
ON _source.empresa = liqPrima.empresa
	AND _source.tipo = liqPrima.tipo
	AND _source.numero = liqPrima.numero
	AND _source.tercero = liqPrima.tercero
WHEN NOT MATCHED BY TARGET
    THEN 
	INSERT(empresa,tipo,numero,tercero,añoInicial,añoFinal,periodoInicial,periodoFinal,fechaInicial,fechaFinal,fechaIngreso,basico,valorTransporte,valorPromedio,base,diasPromedio,diasPrimas,contrato) 
	VALUES(_source.empresa,_source.tipo,_source.numero,_source.tercero,_source.añoInicial,_source.añoFinal,_source.periodoInicial,_source.periodoFinal,_source.fechaInicial,_source.fechaFinal,_source.fechaIngreso,_source.basico,_source.valorTransporte,_source.valorPromedio,_source.base,_source.diasPromedio,_source.diasPrimas,_source.contrato)
WHEN MATCHED 
    THEN UPDATE SET 
	liqPrima.basico = _source.basico,
	liqPrima.valorTransporte = _source.valorTransporte,
	liqPrima.valorPromedio = _source.valorPromedio,
	liqPrima.base = _source.base,
	liqPrima.diasPromedio = _source.diasPromedio,
	liqPrima.diasPrimas = _source.diasPrimas,
	liqPrima.valorPrima = _source.valorPrima
WHEN NOT MATCHED BY SOURCE
    THEN DELETE 
OUTPUT $action, inserted.*, deleted.*;

RETURN 0
