CREATE proc [dbo].[spInformeTransaccionesLaboratorioxTipo]
 @fechaI date, 
 @fechaF date, 
 @tipo varchar(50),
 @empresa int
 as
 select b.numero, b.tipo, a.jerarquia, d.descripcion desJerarquia, a.analisis,c.descripcion desAnalisis, c.orden,b.valor,b.fecha, cc.anulado,
 cc.usuario, cc.observacion, c.uMedida
 from pJerarquiaAnalisis a 
 left join pTransaccionJerarquiaAnalisis b on a.analisis=b.analisis and a.empresa =b.empresa and a.jerarquia =b.jerarquia
 join pTransaccionJerarquia cc on cc.año=b.año and cc.mes=b.mes and cc.numero=b.numero and cc.tipo=b.tipo and cc.anulado=0
 and cc.empresa=b.empresa
 left join lAnalisis c on a.analisis = c.codigo  and c.empresa=a.empresa
 left join pJerarquia d on a.jerarquia=d.codigo and d.empresa=a.empresa
 where c.informe=1   and b.tipo =@tipo
 and  CONVERT(date, b.fecha) between   @fechaI and @fechaF
 and a.empresa=@empresa
 and cc.anulado=0