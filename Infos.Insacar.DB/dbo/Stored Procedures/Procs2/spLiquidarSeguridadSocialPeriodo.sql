CREATE proc [dbo].[spLiquidarSeguridadSocialPeriodo]
@año int,
@empresa int,
@mes int
as
exec spCalculaSeguridadSocialTrabajador @empresa,@mes,@año,''

select aa.año,aa.mes,  aa.registro,  aa.idTercero, aa.codigoTercero Identificacion,bb.descripcion NombreEmpleado, 
 aa.dPension ,aa.IBCpension  , aa.pPension,aa.valorPension vPension, aa.valorFondo vFondo , aa.valorFondoSub vFondoSub,
 aa.dSalud,aa.IBCsalud ,aa.valorSalud vSalud, aa.pSalud, 
 aa.IBCarp IBCarl,aa.pArp,aa.valorArp , aa.dArp ,
  aa.dCaja , aa.IBCcaja ,aa.valorCaja  vCaja,aa.pCaja,
aa.valorSena vSena, aa.valorIcbf  vIcbf,ING,RET,TDE,TAE,TDP,TAP,VSP,VTE,VST,SLN,IGE,LMA,VAC,AVP,VCT,IRP,aa.exoneraSalud ExS,
aa.empresa,pfondo
from  nSeguridadSocial aa
		join cTercero bb on bb.id=aa.idTercero and bb.empresa= aa.empresa
		join nContratos a on a.tercero=aa.idTercero and a.empresa=aa.empresa
		join nCentroTrabajo h on h.codigo=a.centroTrabajo and h.empresa=a.empresa
		left join vEntidadEps b on b.codigo=a.entidadEps and b.empresa=a.empresa
		left join vEntidadPension c on c.codigo=a.entidadPension and c.empresa=a.empresa
		left join vEntidadCaja d on d.codigo=a.entidadCaja and d.empresa=a.empresa
		left join vEntidadArp e on e.codigo=a.entidadArp and e.empresa=a.empresa
		left join vEntidadSena f on f.codigo=a.entidadSena and f.empresa=a.empresa
		left join vEntidadIcbf g on g.codigo=a.entidadIcbf and g.empresa=a.empresa
		where aa.empresa=@empresa and aa.año=@año and aa.mes=@mes
order by aa.registro