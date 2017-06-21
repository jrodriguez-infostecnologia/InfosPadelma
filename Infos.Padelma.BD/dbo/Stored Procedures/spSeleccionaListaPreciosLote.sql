CREATE proc [dbo].[spSeleccionaListaPreciosLote]
@finca varchar(50),
@novedad varchar(50),
@seccion varchar(50),
@empresa int

as

select a.finca,a.novedad,b.añoSiembra, a.precioTerceros, a.precioContratistas, b.mesSiembra ,a.sesion as seccion,a.empresa, b.codigo, b.descripcion from aNovedadLotePrecio a join aLotes b on a.lote=b.codigo
where a.finca=@finca and a.novedad=@novedad and (a.sesion is null or a.sesion like '%'+@seccion+'%')
and modificado=0