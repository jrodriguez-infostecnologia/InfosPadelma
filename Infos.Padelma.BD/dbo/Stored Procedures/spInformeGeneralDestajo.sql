CREATE proc spInformeGeneralDestajo
 @empresa int , @mes int, @año int
 as
 
declare @tipocausacion varchar(50), @cuentacruce varchar(50),  @conceptoDomingo varchar(50)
select @conceptoDomingo = (select ganaDomingo from nParametrosGeneral where empresa=@empresa)
select  @cuentacruce = cuentaCruce from  cClaseParametroContaNomi
where empresa=@empresa and codigo=1


select b.aCcostoNomina idCcosto,  d.descripcion ccosto  , c.codigo idConcepto, c.descripcion Concepto, Sum(b.debito)  valor, 0  mlc from cContabilizacion a join cContabilizacionDetalle b
on a.tipo=b.tipo and a.numero=b.numero and a.empresa=b.empresa
join nConcepto c on c.codigo=b.codigoConcepto and c.empresa=a.empresa
join cCentrosCosto d on b.aCcostoNomina=d.codigo and d.empresa=a.empresa
where a.anulado=0
and a.tipo='CAU' 
and a.año=@año and a.mes=@mes
and a.empresa=@empresa
and c.codigo=@conceptoDomingo
group by  b.aCcostoNomina ,  d.descripcion   , c.codigo , c.descripcion 
union
select b.aCcostoNomina idCcosto,  d.descripcion ccosto  , c.codigo idNovedad, c.descripcion Novedad, Sum(b.debito)  valor, 0 mlc from cContabilizacion a join cContabilizacionDetalle b
on a.tipo=b.tipo and a.numero=b.numero and a.empresa=b.empresa
join aNovedad c on c.codigo=b.codigoLabor and c.empresa=a.empresa
join cCentrosCosto d on b.aCcostoNomina=d.codigo and d.empresa=a.empresa
where a.anulado=0
and a.tipo='CAU' 
and a.año=@año and a.mes=@mes
and a.empresa=@empresa
and cuentaContable<>@cuentacruce
and codigoLabor is not null
and d.manejaLC=1
group by  b.aCcostoNomina ,  d.descripcion   , c.codigo , c.descripcion 
union
select b.aCcostoNomina idCcosto,  d.descripcion ccosto  , c.codigo idNovedad, c.descripcion Novedad, Sum(b.debito)  valor, d.manejaLC from cContabilizacion a join cContabilizacionDetalle b
on a.tipo=b.tipo and a.numero=b.numero and a.empresa=b.empresa
join nConcepto c on c.codigo=b.codigoConcepto and c.empresa=a.empresa
join cCentrosCosto d on b.aCcostoNomina=d.codigo and d.empresa=a.empresa
where a.anulado=0
and a.tipo='SGS' 
and a.año=@año and a.mes=@mes
and a.empresa=@empresa and d.manejaLC=1
group by  b.aCcostoNomina ,  d.descripcion   , c.codigo , c.descripcion ,d.manejaLC
union
select b.aCcostoNomina idCcosto,  d.descripcion ccosto  , c.codigo idNovedad, c.descripcion Novedad, Sum(b.debito)  valor, d.manejaLC from cContabilizacion a join cContabilizacionDetalle b
on a.tipo=b.tipo and a.numero=b.numero and a.empresa=b.empresa
join nConcepto c on c.codigo=b.codigoConcepto and c.empresa=a.empresa
join cCentrosCosto d on b.aCcostoNomina=d.codigo and d.empresa=a.empresa
where a.anulado=0
and a.tipo='PRO' 
and a.año=@año and a.mes=@mes
and a.empresa=@empresa and d.manejaLC=1
group by  b.aCcostoNomina ,  d.descripcion   , c.codigo , c.descripcion, d.manejaLC