CREATE PROCEDURE [dbo].[SpInsertanConceptosFijos] @empresa int,@año int,@mes int,@noPeriodo int,@formaPago int,@fechaRegistro datetime,@liquidada bit,@acumulada bit,
@lNovedades bit,@lPresamo bit,@lHoras bit,@lVacaciones bit,@lPrimas bit,@lAusentismo bit,@lEmbargo bit,@lOtros bit,@centroCosto varchar(50),@observacion varchar(2550),
@lDomingoCero bit,@mDomingo bit,@lsindicato bit,
@usuario varchar(50),@lNovedadesCredito bit,@lFondavi bit,@lDomingo bit, @lfestivo bit,@Retorno int output  AS begin tran nConceptosFijos
 insert nConceptosFijos( empresa,año,mes,noPeriodo,formaPago,fechaRegistro,liquidada,acumulada,lNovedades,lPresamo,lHoras,lVacaciones,lPrimas,
 lAusentismo,lEmbargo,lOtros,centroCosto,observacion,usuario,lNovedadesCredito,lFondavi,lDomingo,lFestivo,lDomingoCero,mDomingo,lSindicato ) 
 select @empresa,@año,@mes,@noPeriodo,@formaPago,@fechaRegistro,@liquidada,@acumulada,@lNovedades,@lPresamo,@lHoras,@lVacaciones,@lPrimas,
 @lAusentismo,@lEmbargo,@lOtros,@centroCosto,@observacion,@usuario,@lNovedadesCredito,@lFondavi  ,@ldomingo,@lfestivo,@lDomingoCero,@mDomingo,@lsindicato
 if (@@error = 0 ) begin set @Retorno = 0 commit tran nConceptosFijos end else begin set @Retorno = 1 rollback tran nConceptosFijos end



 exec spSysObtenerParametros 'SpInsertanConceptosFijos',0