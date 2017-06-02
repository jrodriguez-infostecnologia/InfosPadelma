CREATE PROCEDURE [dbo].[spSeleccionaTransaccionAnalisisCab]
	@transaccion	varchar(50),
	@empresa int
AS
/***************************************************************************
Nombre: spSeleccionaTransaccionAnalisisCab
INFOS TECNOLOGIA S.A.S
*****************************************************************************/
											  

select distinct c.jerarquia, e.descripcion,isnull(convert(varchar(50),g.codigo),'')+' - ' + isnull(g.descripcion,'') padre, isnull( convert(varchar(50),h.codigo),'')+' - '+ isnull( h.descripcion,'') abuelo
from gTipoTransaccionProducto a 
join lAnalisisItem b on a.producto=b.item and b.empresa=a.empresa  
join pJerarquiaAnalisis c  on b.analisis = c.analisis and a.empresa=b.empresa
join pJerarquia d on c.jerarquia = d.codigo   and d.empresa=c.empresa
join lAnalisis f on b.analisis= f.codigo and b.empresa=f.empresa
join pJerarquia e on e.codigo=c.jerarquia  and e.empresa=c.empresa
left join pJerarquia g on g.codigo=SUBSTRING(convert(varchar(50),c.jerarquia),1,LEN(c.jerarquia)-1)
left join pJerarquia h on h.codigo=	SUBSTRING(convert(varchar(50),g.codigo),1,LEN(g.codigo)-1)
where a.tipo=@transaccion and f.control=0  and f.activo=1
and f.produccion=1 and c.resultadoFinal=0
and a.empresa=@empresa