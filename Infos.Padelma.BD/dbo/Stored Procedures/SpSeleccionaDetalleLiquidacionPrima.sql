CREATE PROCEDURE [dbo].[SpSeleccionaDetalleLiquidacionPrima]
	@empresa int,
	@tipo varchar(50),
	@numero varchar(50)
AS
	SELECT 
	ter.id codigoTercero,
	ter.codigo IdentificacionTercero,
	ter.descripcion NombreTercero,
	prima_detalle.fechaIngreso,
	prima_detalle.fechaInicial,
	prima_detalle.fechaFinal,
	prima_detalle.basico,
	prima_detalle.valorTransporte Transporte,
	prima_detalle.valorPromedio,
	prima_detalle.base,
	prima_detalle.diasPromedio,
	prima_detalle.diasPrimas,
	prima_detalle.valorPrima
	FROM nLiquidacionPrimaDetalle prima_detalle
	INNER JOIN cTercero ter
	ON 
	ter.id = prima_detalle.tercero AND
	ter.empresa = prima_detalle.empresa
	INNER JOIN nContratos contratos
	ON
	contratos.id = prima_detalle.contrato AND
	contratos.empresa = prima_detalle.empresa;
		
RETURN 0
