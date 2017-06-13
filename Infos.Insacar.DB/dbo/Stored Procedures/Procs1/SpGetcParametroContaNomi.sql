CREATE PROCEDURE [dbo].[SpGetcParametroContaNomi] AS 
select distinct a.*, b.descripcion desClase, c.descripcion desCcostoMayor, d.descripcion desCcosto, isnull(e.descripcion ,f.descripcion ) desConcepto   from cParametroContaNomi a 
left join cClaseParametroContaNomi b on
a.clase=b.codigo and a.empresa=b.empresa 
left join cCentrosCosto c on a.cCostoMayor=c.codigo and a.empresa=c.empresa
left join cCentrosCosto d on a.cCosto=d.codigo and a.empresa=d.empresa and d.mayor=c.codigo
left join nConcepto e on a.concepto=e.codigo and a.empresa=e.empresa
left join aNovedad f on a.concepto='L'+f.codigo and f.empresa=a.empresa