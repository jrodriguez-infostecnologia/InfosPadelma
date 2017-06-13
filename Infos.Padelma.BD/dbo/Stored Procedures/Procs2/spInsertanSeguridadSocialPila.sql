
CREATE proc [dbo].[spInsertanSeguridadSocialPila]
 @empresa	int,
@año	int,
@mes	int,
@registro	int,
@idTercero	int,
@codigoTercero	varchar(50),
@apellido1	varchar(50),
@apellido2	varchar(50),
@nombre1	varchar(50),
@nombre2	varchar(50),
@departamento	varchar(50),
@ciudad	varchar(50),
@tipoCotizante	varchar(50),
@subTipoCotizante	varchar(50),
@horasLaboradas	int,
@extranjero	varchar(50),
@RecidenteExterior	varchar(50),
@fechaRadExterior	date,
@ING	varchar(50),
@fechaIngreso	date,
@RET	varchar(50),
@fechaRetiro	date,
@TDE	varchar(50),
@TAE	varchar(50),
@TDP	varchar(50),
@TAP	varchar(50),
@VSP	varchar(50),
@fechaVSP	date,
@VST	varchar(50),
@SLN	varchar(50),
@fiSLN	date,
@ffSLN	date,
@IGE	varchar(50),
@fiIGE	date,
@ffIGE	date,
@LMA	varchar(50),
@fiLMA	date,
@ffLMA	date,
@VAC	varchar(50),
@fiVAC	date,
@ffVAC	date,
@AVP	varchar(50),
@VCT	varchar(50),
@fiVCT	date,
@ffVCT	date,
@IRL	int,
@fiIRL	date,
@ffIRL	date,
@correciones	varchar(50),
@salario	int,
@salarioIntegral	varchar(50),
@terceroPension	int,
@dPension	int,
@IBCpension	int,
@pPension	float,
@valorPension	int,
@indicadorAltoRiesgo	int,
@cotizacionVoluntariaAfiliado	float,
@cotizacionVoluntariaEmpleador	float,
@valorFondo	float,
@valorFondoSub	float,
@pFondo	float,
@valorRetenido	float,
@totalPension	float,
@AFPdestino	varchar(50),
@terceroSalud	int,
@dSalud	int,
@IBCsalud	int,
@pSalud	float,
@valorSalud	float,
@valorUPC	float,
@noAutorizacionEG	varchar(50),
@valorIncapacidad	float,
@noAutorizacionLMA	varchar(50),
@valorLMA	float,
@saludDestino	nchar,
@terceroArl	int,
@dArl	int,
@IBCarl	int,
@pArl	float,
@claseARL	int,
@centroTrabajo	varchar(50),
@valorArl	float,
@dCaja	int,
@terceroCaja	int,
@IBCcaja	int,
@pCaja	float,
@valorCaja	int,
@IBCCajaOtros	float,
@pSena	float,
@valorSena	int,
@terceroSena	int,
@pICBF	float,
@valorICBF	int,
@terceroIcbf	int,
@pESAP	float,
@valorESAP	float,
@pMEN	float,
@valorMEN	float,
@exoneraSalud	varchar(50),
@tipoIDcotizanteUPC	varchar(50),
@noIDcotizanteUPC	varchar(50),
@contrato int,
@tipoID varchar(50),
@Retorno int output  
as

begin tran  InsertanSeguridadSocialPila

DECLARE @FECHAVALOR DATE ='01/01/1990'

IF (@fechaIngreso=@FECHAVALOR)
	SET @fechaIngreso=NULL
IF (@fechaRadExterior=@FECHAVALOR)
	SET @fechaRadExterior=NULL
IF (@fechaRetiro=@FECHAVALOR)
	SET @fechaRetiro=NULL
IF (@fechaVSP=@FECHAVALOR)
	SET @fechaVSP=NULL
IF (@ffIGE=@FECHAVALOR)
	SET @ffIGE=NULL
IF (@ffIRL=@FECHAVALOR)
	SET @ffIRL=NULL
IF (@ffLMA=@FECHAVALOR)
	SET @ffLMA=NULL
IF (@ffSLN=@FECHAVALOR)
	SET @ffSLN=NULL
IF (@ffVAC=@FECHAVALOR)
	SET @ffVAC=NULL
IF (@ffVCT=@FECHAVALOR)
	SET @ffVCT=NULL
IF (@fiIGE=@FECHAVALOR)
	SET @fiIGE=NULL
IF (@fiIRL=@FECHAVALOR)
	SET @fiIRL=NULL
IF (@fiLMA=@FECHAVALOR)
	SET @fiLMA=NULL
IF (@fiSLN=@FECHAVALOR)
	SET @fiSLN=NULL
IF (@fiVAC=@FECHAVALOR)
	SET @fiVAC=NULL
IF (@fiVCT=@FECHAVALOR)
	SET @fiVCT=NULL

set @registro = isnull((select max(registro) from nSeguridadSocialPila where empresa=@empresa and año=@año and mes=@mes),0)+1

insert  nSeguridadSocialPila 
select @empresa,@año,@mes,@registro,@idTercero,@codigoTercero,@apellido1,@apellido2,@nombre1,
@nombre2,@departamento,@ciudad,@tipoCotizante,@subTipoCotizante,@horasLaboradas,@extranjero,@RecidenteExterior,
@fechaRadExterior,@ING,@fechaIngreso,@RET,@fechaRetiro,@TDE,@TAE,@TDP,@TAP,@VSP,@fechaVSP,@VST,@SLN,@fiSLN,@ffSLN,
@IGE,@fiIGE,@ffIGE,@LMA,@fiLMA,@ffLMA,@VAC,@fiVAC,@ffVAC,@AVP,@VCT,@fiVCT,@ffVCT,@IRL,@fiIRL,@ffIRL,@correciones,@salario,
@salarioIntegral,@terceroPension,@dPension,@IBCpension,@pPension,@valorPension,@indicadorAltoRiesgo,@cotizacionVoluntariaAfiliado,
@cotizacionVoluntariaEmpleador,@valorFondo,@valorFondoSub,@pFondo,@valorRetenido,@totalPension,@AFPdestino,@terceroSalud,@dSalud,
@IBCsalud,@pSalud,@valorSalud,@valorUPC,@noAutorizacionEG,@valorIncapacidad,@noAutorizacionLMA,@valorLMA,@saludDestino,@terceroArl,
@dArl,@IBCarl,@pArl,@claseARL,@centroTrabajo,@valorArl,@dCaja,@terceroCaja,@IBCcaja,@pCaja,@valorCaja,@IBCCajaOtros,@pSena,@valorSena,
@terceroSena,@pICBF,@valorICBF,@terceroIcbf,@pESAP,@valorESAP,@pMEN,@valorMEN,@exoneraSalud,@tipoIDcotizanteUPC,@noIDcotizanteUPC,@contrato,@tipoID

if @@ERROR = 0
begin
	set @retorno = 0
	commit tran InsertanSeguridadSocialPila
end
else
begin
	set @retorno = 1
	rollback tran InsertanSeguridadSocialPila
end