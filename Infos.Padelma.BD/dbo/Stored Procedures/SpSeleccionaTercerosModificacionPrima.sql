CREATE PROCEDURE [dbo].[SpSeleccionaTercerosModificacionPrima]
	@Empresa int
AS
	SELECT DISTINCT ter.id, CONCAT(ter.id,' - ',ter.codigo,' - ', ter.descripcion) descripcion 
	FROM
	cTercero ter
	INNER JOIN nContratos contr
	ON contr.tercero = ter.id
	AND contr.empresa = ter.empresa
	WHERE ter.empresa = @Empresa;
RETURN 0
