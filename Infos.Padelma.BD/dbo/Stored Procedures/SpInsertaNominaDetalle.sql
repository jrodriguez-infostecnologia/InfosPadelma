CREATE PROCEDURE spInsertaNominaDetalle
	@Año int = 2016, 
	@Periodo int = 13, 
	@Empresa int = 1,
	@Tipo varchar(50) = 'LQC',
	@Numero varchar(50) = 'LQC00000000000000000018',
	@CodTercero int = 319,
	@CodContrato int = 1,
	@concepto varchar(50) = '',
	@ValorUnitario money = 1,
	@ValorTotal money = 1,
	@Cantidad decimal(18,3) = 1,
	@registro int = 1

AS
	declare @mes int, @fechaIncial date, @fechaFinal date;
	SELECT TOP 1 @mes = mes, @fechaIncial = fechaInicial, @fechaFinal=fechaFinal FROM nPeriodoDetalle WHERE empresa = @Empresa AND año = @Año AND noPeriodo = @Periodo;

	declare 
		@basePrimas bit = 0, 
		@baseCajaCompensacion bit = 0, 
		@baseCesantias bit = 0, 
		@baseVacaciones bit = 0, 
		@baseIntereses bit = 0, 
		@baseSeguridadSocial bit = 0, 
		@manejaRango bit = 0,  
		@porcentaje decimal(18,3) = 0, 
		@baseEmbargo bit = 0,
		@signo int = 0;
	SELECT 
		@basePrimas = basePrimas, 
		@baseCajaCompensacion = baseCajaCompensacion, 
		@baseCesantias = baseCesantias, 
		@baseVacaciones = baseVacaciones, 
		@baseIntereses = baseIntereses,  
		@baseSeguridadSocial = baseSeguridadSocial, 
		@manejaRango = manejaRango,
		@porcentaje = porcentaje,
		@baseEmbargo = baseEmbargo,
		@signo = signo
	FROM nConcepto 
	WHERE empresa = @Empresa AND codigo = @concepto;

	declare @departamento varchar(50), @ccosto varchar(50);
	SELECT @departamento = departamento, @ccosto = ccosto 
	FROM nContratos 
	WHERE empresa = @Empresa AND id = @CodContrato AND tercero = @CodTercero;

	INSERT INTO nLiquidacionNominaDetalle 
	(tercero, empresa, tipo, numero, año, mes, registro, 
	contrato, noPeriodo, concepto, cantidad, valorUnitario, 
	valorTotal, fechaInicial, fechaFinal, basePrimas, 
	baseCajaCompensacion, baseCesantias, baseVacaciones, 
	baseIntereses, baseSeguridadSocial, manejaRango, 
	baseEmbargo, ccosto, departamento, porcentaje, signo)
	VALUES 
	(@CodTercero, @Empresa, @Tipo, @Numero, @Año, @mes, @registro, 
	@CodContrato, @Periodo, @concepto, @Cantidad, @ValorUnitario, 
	@ValorTotal, @fechaIncial, @fechaFinal, @basePrimas, 
	@baseCajaCompensacion, @baseCesantias, @baseVacaciones, 
	@baseIntereses, @baseSeguridadSocial, @manejaRango, 
	@baseEmbargo, @ccosto, @departamento, @porcentaje, @signo);
	
RETURN 0
