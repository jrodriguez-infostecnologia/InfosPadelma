CREATE proc [dbo].[spSeleccionaSeguridadSocialPeriodo]
@año int,
@empresa int,
@mes int
as
--exec spCalculaSeguridadSocialTrabajador @empresa,@mes,@año,'231'

select aa.idTercero Codigo_Empleado, aa.codigoTercero Id_Identificacion,
bb.descripcion nombreTercero,apellido1 , apellido2 , nombre1 , nombre2,
c.razonSocial razonSocial_Pension, aa.dPension Dias_Cotizados_Pension,aa.IBCpension  IBC_Pension, 
aa.valorPension  valor_Pension, aa.valorFondo + aa.valorFondoSub  valor_FondoSolidaridad,
b.razonSocial razonSocial_EPS, aa.dSalud Dias_Cotizados_Salud,
aa.IBCsalud IBC_Salud,aa.valorSalud valor_Salud, e.razonSocial  razonSocial_Arp, aa.IBCarp IBCarl,
aa.valorArp valor_ARP, aa.dArp Dias_Arp, aa.dCaja Dias_Cotizados_Caja, aa.IBCcaja IBC_Caja,aa.valorCaja  valor_Caja,
aa.valorSena valor_Sena, aa.valorIcbf  valor_icbf,ING,RET,TDE,TAE,TDP,TAP,VSP,VTE,VST,SLN,IGE,LMA,VAC,AVP,VCT,IRP,a.salario,
aaa.codigo codCCosto, aaa.descripcion  Ccosto
from  nSeguridadSocial aa
		join cTercero bb on bb.id=aa.idTercero and bb.empresa=@empresa
		join nContratos a on a.tercero=aa.idTercero and a.empresa=@empresa and a.id=(select max(id) from nContratos where tercero=aa.idTercero and empresa=@empresa)
		join cCentrosCosto aaa on a.ccosto=aaa.codigo and aaa.empresa=a.empresa
		left join nCentroTrabajo h on h.codigo=a.centroTrabajo and h.empresa=a.empresa
		left join vEntidadEps b on b.tercero=aa.terceroSalud and b.empresa=a.empresa
		left join vEntidadPension c on c.tercero=aa.terceroPension and c.empresa=a.empresa
		left join vEntidadCaja d on d.tercero=aa.terceroCaja and d.empresa=a.empresa
		left join vEntidadArp e on e.codigo=a.entidadArp and e.empresa=a.empresa
		left join vEntidadSena f on f.tercero=aa.terceroSena and f.empresa=a.empresa
		left join vEntidadIcbf g on g.tercero=aa.terceroIcbf and g.empresa=a.empresa
		where aa.empresa=@empresa and aa.año=@año and aa.mes=@mes
		order by cast(rtrim(ltrim(aa.codigoTercero)) as int)