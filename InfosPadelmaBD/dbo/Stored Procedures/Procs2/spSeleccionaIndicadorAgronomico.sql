CREATE proc [dbo].[spSeleccionaIndicadorAgronomico]
 @empresa int, @mes int,@año int
 as

declare @añoi int=@año-1, @añof int=@año

select a.empresa,a.año,e.lote,d.descripcion, SUM(e.racimos) cantidad, 'NO. RACIMOS' tipo, 0 codTipo, 'MES ' + upper(dbo.fRetornaNombreMes(@mes)) + ' ' + CONVERT(varchar,@año)  tipoPeriodo,  0 codTipoPeriodo,c.añoSiembra,c.palmasProduccion,c.hNetas from  aTransaccion a 
join aTransaccionNovedad e on e.numero=a.numero and e.empresa=a.empresa and e.tipo=a.tipo
join aLotes c on c.codigo=e.lote and c.empresa=e.empresa
left join aVariedad d on d.codigo=c.variedad and d.empresa=c.empresa
join aNovedad f on f.codigo=e.novedad and f.empresa=e.empresa 
where f.claseLabor  =2 and a.anulado=0 and a.empresa=@empresa and a.año between @añoi and @añof and a.mes=@mes and c.activo=1
group by a.empresa,a.año,e.lote,d.descripcion,c.añoSiembra,c.palmasProduccion,c.hNetas
union
select a.empresa,  a.año,c.codigo,d.descripcion, SUM(b.cantidad) cantidad, 'KILOS' tipo, 1 codTipo, 'MES ' + upper(dbo.fRetornaNombreMes(@mes)) + ' ' + CONVERT(varchar,@año) , 0 codTipoPeriodo,c.añoSiembra,c.palmasProduccion,c.hNetas   from  aTransaccion a 
join aTransaccionNovedad e on e.numero=a.numero and e.empresa=a.empresa and e.tipo=a.tipo
join aTransaccionTercero b on b.numero=a.numero and b.empresa=a.empresa and b.tipo =a.tipo and b.registroNovedad=e.registro
join aLotes c on c.codigo=b.lote and c.empresa=b.empresa
left join aVariedad d on d.codigo=c.variedad and d.empresa=c.empresa
join aNovedad f on f.codigo=b.novedad and f.empresa=b.empresa 
where f.claseLabor  =2 and a.anulado=0 and a.empresa=@empresa and a.año between @añoi and @añof and a.mes=@mes and c.activo=1
group by a.empresa,a.año,c.codigo,d.descripcion,c.añoSiembra,c.palmasProduccion,c.hNetas
union
select b.empresa,año,lote, d.descripcion, avg(pesoRacimo) cantidad, 'PESO PROMEDIO RACIMOS',  2 codTipo,'MES ' + upper(dbo.fRetornaNombreMes(@mes)) + ' ' + CONVERT(varchar,@año), 0 codTipoPeriodo,c.añoSiembra,c.palmasProduccion,c.hNetas from aLotePesosPeriodo b
join aLotes c on c.codigo=b.lote and c.empresa=b.empresa
left join aVariedad d on d.codigo=c.variedad and d.empresa=c.empresa
where b.empresa=@empresa and b.año between @añoi and @añof AND b.mes=@mes  and c.activo=1
group by b.empresa,b.año,b.lote,d.descripcion,c.añoSiembra,c.palmasProduccion,c.hNetas
union
select a.empresa,  a.año,c.codigo,d.descripcion, (SUM(b.cantidad)/hNetas)/1000 cantidad, 'TON/ HECTAREA/ MES' tipo, 3 codTipo, 'MES ' + upper(dbo.fRetornaNombreMes(@mes)) + ' ' + CONVERT(varchar,@año) , 0 codTipoPeriodo,c.añoSiembra,c.palmasProduccion,c.hNetas   from  aTransaccion a 
join aTransaccionNovedad e on e.numero=a.numero and e.empresa=a.empresa and e.tipo=a.tipo
join aTransaccionTercero b on b.numero=a.numero and b.empresa=a.empresa and b.tipo =a.tipo and b.registroNovedad=e.registro
join aLotes c on c.codigo=b.lote and c.empresa=b.empresa
left join aVariedad d on d.codigo=c.variedad and d.empresa=c.empresa
join aNovedad f on f.codigo=b.novedad and f.empresa=b.empresa 
where f.claseLabor  =2 and a.anulado=0 and a.empresa=@empresa and a.año between @añoi and @añof and a.mes=@mes and c.activo=1
group by a.empresa,a.año,c.codigo,d.descripcion,c.añoSiembra,c.palmasProduccion,c.hNetas
union
select a.empresa,a.año,e.lote,d.descripcion, SUM(e.racimos) cantidad, 'NO. RACIMOS' tipo, 0 codTipo, 'ACUMULADOS AÑO' , 1 codTipoPeriodo,c.añoSiembra,c.palmasProduccion,c.hNetas from  aTransaccion a 
join aTransaccionNovedad e on e.numero=a.numero and e.empresa=a.empresa and e.tipo=a.tipo
join aLotes c on c.codigo=e.lote and c.empresa=e.empresa
left join aVariedad d on d.codigo=c.variedad and d.empresa=c.empresa
join aNovedad f on f.codigo=e.novedad and f.empresa=e.empresa
where f.claseLabor =2 and a.anulado=0 and a.empresa=@empresa and a.año between @añoi and @añof and a.mes<=@mes and c.activo=1
group by a.empresa,a.año,e.lote,d.descripcion,c.añoSiembra,c.palmasProduccion,c.hNetas
union
select a.empresa,  a.año,c.codigo,d.descripcion, SUM(b.cantidad) cantidad, 'KILOS' tipo, 1 codTipo, 'ACUMULADOS AÑO' , 1 codTipoPeriodo,c.añoSiembra,c.palmasProduccion,c.hNetas   from  aTransaccion a 
join aTransaccionNovedad e on e.numero=a.numero and e.empresa=a.empresa and e.tipo=a.tipo
join aTransaccionTercero b on b.numero=a.numero and b.empresa=a.empresa and b.tipo =a.tipo and b.registroNovedad=e.registro
join aLotes c on c.codigo=b.lote and c.empresa=b.empresa
left join aVariedad d on d.codigo=c.variedad and d.empresa=c.empresa
join aNovedad f on f.codigo=b.novedad and f.empresa=b.empresa
where f.claseLabor =2 and a.anulado=0 and a.empresa=@empresa and a.año between @añoi and @añof and a.mes<=@mes and c.activo=1
group by a.empresa,a.año,c.codigo,d.descripcion,c.añoSiembra,c.palmasProduccion,c.hNetas
union
select b.empresa,año,lote, d.descripcion, avg(pesoRacimo) cantidad, 'PESO PROMEDIO RACIMOS', 2 codTipo, 'ACUMULADOS AÑO'  ,1 codTipoPeriodo,c.añoSiembra,c.palmasProduccion,c.hNetas from aLotePesosPeriodo b
join aLotes c on c.codigo=b.lote and c.empresa=b.empresa
left join aVariedad d on d.codigo=c.variedad and d.empresa=c.empresa
where b.empresa=@empresa and b.año between @añoi and @añof and b.mes<=@mes and c.activo=1
group by b.empresa,b.año,b.lote,d.descripcion,c.añoSiembra,c.palmasProduccion,c.hNetas
union
select a.empresa,  a.año,c.codigo,d.descripcion,  (SUM(b.cantidad)/hNetas)/1000 cantidad, 'TON/ HECTAREA/ MES' tipo, 3  codTipo, 'ACUMULADOS AÑO' , 1 codTipoPeriodo,c.añoSiembra,c.palmasProduccion,c.hNetas   from  aTransaccion a 
join aTransaccionNovedad e on e.numero=a.numero and e.empresa=a.empresa and e.tipo=a.tipo
join aTransaccionTercero b on b.numero=a.numero and b.empresa=a.empresa and b.tipo =a.tipo and b.registroNovedad=e.registro
join aLotes c on c.codigo=b.lote and c.empresa=b.empresa
left join aVariedad d on d.codigo=c.variedad and d.empresa=c.empresa
join aNovedad f on f.codigo=b.novedad and f.empresa=b.empresa
where f.claseLabor =2 and a.anulado=0 and a.empresa=@empresa and a.año between @añoi and @añof and a.mes<=@mes and c.activo=1
group by a.empresa,a.año,c.codigo,d.descripcion,c.añoSiembra,c.palmasProduccion,c.hNetas

union
select a.empresa,  a.año,c.codigo,d.descripcion,  (((SUM(b.cantidad)/hNetas)/1000)/@mes) *12 cantidad, 'PROYECCION AÑO' tipo, 4  codTipo, 'ACUMULADOS AÑO' , 1 codTipoPeriodo,c.añoSiembra,c.palmasProduccion,c.hNetas   from  aTransaccion a 
join aTransaccionNovedad e on e.numero=a.numero and e.empresa=a.empresa and e.tipo=a.tipo
join aTransaccionTercero b on b.numero=a.numero and b.empresa=a.empresa and b.tipo =a.tipo and b.registroNovedad=e.registro
join aLotes c on c.codigo=b.lote and c.empresa=b.empresa
left join aVariedad d on d.codigo=c.variedad and d.empresa=c.empresa
join aNovedad f on f.codigo=b.novedad and f.empresa=b.empresa
where f.claseLabor =2 and a.anulado=0 and a.empresa=@empresa and a.año = @añof and a.mes<=@mes
group by a.empresa,a.año,c.codigo,d.descripcion,c.añoSiembra,c.palmasProduccion,c.hNetas

order by  añoSiembra, lote,tipo,año,codTipoPeriodo