CREATE PROCEDURE [dbo].[SpActualizaDetalleLiquidacionPrima]
	@DataTable as ActualizaDetalleLiquidacionPrimaType READONLY
AS

DECLARE @empresa int, @tipo varchar(50), @numero varchar(50);

SELECT DISTINCT 
@empresa=empresa, 
@tipo=tipo, 
@numero=numero
FROM @DataTable;

DELETE nLiquidacionNominaDetalle 
WHERE
@empresa = empresa
AND @empresa = tipo
AND @empresa = numero;

INSERT nLiquidacionPrimaDetalle (empresa,tipo,numero,tercero,añoInicial,añoFinal,periodoInicial,periodoFinal,fechaInicial,fechaFinal,fechaIngreso,basico,valorTransporte,valorPromedio,base,diasPromedio,diasPrimas,contrato) 
SELECT _source.empresa,_source.tipo,_source.numero,_source.tercero,_source.añoInicial,_source.añoFinal,_source.periodoInicial,_source.periodoFinal,_source.fechaInicial,_source.fechaFinal,_source.fechaIngreso,_source.basico,_source.valorTransporte,_source.valorPromedio,_source.base,_source.diasPromedio,_source.diasPrimas,_source.contrato FROM @DataTable _source;

RETURN 0
