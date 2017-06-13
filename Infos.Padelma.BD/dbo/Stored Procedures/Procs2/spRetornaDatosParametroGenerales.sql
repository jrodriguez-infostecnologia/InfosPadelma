CREATE PROCEDURE [dbo].[spRetornaDatosParametroGenerales] 
@empresa int,
@codigo int
AS


 select distinct *, b.descripcion desClase, c.descripcion desCcostoMayor,d.descripcion desCcosto
   from cParametroContaNomi a 
 join cClaseParametroContaNomi b on a.clase = b.codigo and a.empresa=b.empresa 
 left join cCentrosCosto c on c.codigo = a.cCostoMayor and c.empresa=a.empresa
 left join cCentrosCosto d on d.codigo = a.cCosto and d.empresa=a.empresa and d.mayor=a.cCostoMayor
  where a.empresa=@empresa and a.id=@codigo