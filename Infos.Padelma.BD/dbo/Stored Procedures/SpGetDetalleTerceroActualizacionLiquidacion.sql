CREATE PROCEDURE [dbo].[SpGetDetalleTerceroActualizacionLiquidacion]
	@empresa int,
	@tercero int
AS
	SELECT DISTINCT 
	ter.id, 
	ter.descripcion,
	ter.codigo identificacion,
	contr.id contrato
	FROM
	cTercero ter
	INNER JOIN nContratos contr
	ON contr.tercero = ter.id
	AND contr.empresa = ter.empresa
	WHERE ter.empresa = @Empresa
	AND ter.id = @tercero;
RETURN 0
