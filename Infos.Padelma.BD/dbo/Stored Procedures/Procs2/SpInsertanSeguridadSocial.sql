CREATE PROCEDURE [dbo].[SpInsertanSeguridadSocial] @empresa int,@año int,@mes int,
@idTercero int,@IBCsalud int,@IBCpension int,
@IBCarp int,@IBCcaja int,@dSalud int,@dPension int,@dArp int,@dCaja int,@valorSalud int,@valorPension int,
@valorFondo int,@valorFondoSub int,@valorArp int,@valorCaja int,@valorSena int,@valorIcbf int,@IRP int,@pSalud float,
@pPension float,@pArp float,@pCaja float,@pFondo float,@ING varchar(1),@RET varchar(1),
@TDE varchar(1),@TAE varchar(1),@TDP varchar(1),@TAP varchar(1),@VSP varchar(1),@VTE varchar(1),
@VST varchar(1),@SLN varchar(1),@IGE varchar(1),@LMA varchar(1),@VAC varchar(1),@AVP varchar(1),@VCT varchar(1),
@exoneraSalud varchar(1),@Retorno int output  AS begin tran nSeguridadSocial 

declare @salario int,@codigoTercero varchar(50),@registro int,@terceroSalud int, @terceroPension int,@terceroArp int,@terceroCaja int,@terceroSena int,@terceroIcbf int
select @codigoTercero= codigo from cTercero where empresa=@empresa and id=@idTercero
set @registro =  isnull((select max(registro) from nSeguridadSocial where empresa=@empresa and año=@año and mes=@mes),0) + 1 
select @salario = salario from nContratos where empresa=@empresa and tercero=@idTercero 
and id in ( select max(id) from nContratos where empresa=@empresa and tercero=@idTercero)

select	@terceroArp=e.tercero,	@terceroSalud=b.tercero,@terceroCaja=d.tercero,@terceroSena=f.tercero,
				@terceroPension=c.tercero,@terceroIcbf=g.tercero from nContratos a
				join nCentroTrabajo h on h.codigo=a.centroTrabajo and h.empresa=a.empresa
				left join vEntidadEps b on b.codigo=a.entidadEps and b.empresa=a.empresa
				left join vEntidadPension c on c.codigo=a.entidadPension and c.empresa=a.empresa
				left join vEntidadCaja d on d.codigo=a.entidadCaja and d.empresa=a.empresa
				left join vEntidadArp e on e.codigo=a.entidadArp and e.empresa=a.empresa
				left join vEntidadSena f on f.codigo=a.entidadSena and f.empresa=a.empresa
				left join vEntidadIcbf g on g.codigo=a.entidadIcbf and g.empresa=a.empresa
				where a.tercero=@idtercero and a.empresa=@empresa
				and a.id in (select max(id) from nContratos where tercero=@idtercero and empresa=@empresa )



insert nSeguridadSocial( empresa,año,mes,registro,idTercero,salario,IBCsalud,IBCpension,IBCarp,IBCcaja,dSalud,dPension,dArp,dCaja,valorSalud,
valorPension,valorFondo,valorFondoSub,valorArp,valorCaja,valorSena,valorIcbf,IRP,pSalud,pPension,pArp,pCaja,pFondo,codigoTercero,
ING,RET,TDE,TAE,TDP,TAP,VSP,VTE,VST,SLN,IGE,LMA,VAC,AVP,VCT,exoneraSalud,
terceroSalud,terceroPension,terceroCaja,terceroArp,terceroIcbf,terceroSena ) 
select @empresa,@año,@mes,@registro,@idTercero,@salario,@IBCsalud,@IBCpension,@IBCarp,@IBCcaja,@dSalud,@dPension,@dArp,@dCaja,@valorSalud,@valorPension,
@valorFondo,@valorFondoSub,@valorArp,@valorCaja,@valorSena,@valorIcbf,@IRP,@pSalud,@pPension,@pArp,@pCaja,@pFondo,@codigoTercero,@ING,@RET,@TDE,@TAE,@TDP,
@TAP,@VSP,@VTE,@VST,@SLN,@IGE,@LMA,@VAC,@AVP,@VCT,@exoneraSalud,@terceroSalud,@terceroPension,@terceroCaja,@terceroArp,@terceroIcbf,@terceroCaja
if (@@error = 0 ) begin set @Retorno = 0 commit tran nSeguridadSocial end else begin set @Retorno = 1 rollback tran nSeguridadSocial end