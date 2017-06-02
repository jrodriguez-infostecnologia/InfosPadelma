CREATE PROCEDURE [dbo].[SpActualizanConceptosFijos] @empresa int,@año int,@mes int,@noPeriodo int,@formaPago int,@fechaRegistro datetime,@mDomingo bit,
@liquidada bit,@acumulada bit,@lNovedades bit,@lPresamo bit,@lHoras bit,@lVacaciones bit,@lPrimas bit,@lAusentismo bit,@lEmbargo bit,@lDomingo bit,
 @lfestivo bit,@lDomingoCero bit,@lsindicato bit,
@lOtros bit,@centroCosto varchar(50),@observacion varchar(2550),@usuario varchar(50), @lNovedadesCredito bit,@lFondavi bit,@Retorno int output  
AS begin tran nConceptosFijos update nConceptosFijos set formaPago = @formaPago,fechaRegistro = @fechaRegistro,liquidada = @liquidada,acumulada = @acumulada,
lNovedades = @lNovedades,lPresamo = @lPresamo,lHoras = @lHoras,lVacaciones = @lVacaciones,lPrimas = @lPrimas,lAusentismo = @lAusentismo,lEmbargo = @lEmbargo,
lOtros = @lOtros,observacion = @observacion,usuario = @usuario, lNovedadesCredito = @lNovedadesCredito, lFondavi=@lFondavi,lDomingo=@lDomingo,lFestivo=@lfestivo,
ldomingocero=@lDomingoCero,mDomingo=@mDomingo, lSindicato=@lsindicato
where año = @año and centroCosto = @centroCosto and empresa = @empresa and mes = @mes and noPeriodo = @noPeriodo if (@@error = 0 ) begin set @Retorno = 0 commit tran nConceptosFijos end else begin set @Retorno = 1 rollback tran nConceptosFijos end