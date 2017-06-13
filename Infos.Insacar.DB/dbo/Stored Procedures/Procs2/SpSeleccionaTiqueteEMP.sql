CREATE PROCEDURE [dbo].[SpSeleccionaTiqueteEMP] 
@tiquete as varchar(50),
@empresa int
AS
/***************************************************************************
Nombre: SpSeleccionaTiqueteEMP
Tipo: Procedimiento Almacenado
Desarrollado: Infos Tecnologia

Argumentos de entrada: Codigo del Tiquete
Argumentos de salida: 
Descripción: Selecciona Los datos para impresión de Tiquete Entrada de materia prima
*****************************************************************************/

select distinct B.fechaBruto,
	   B.fechaTara,
	   B.tiquete,
	   B.fechaProceso,
	   upper(T.descripcion) as TipoMovimiento,
	   upper(U.descripcion) as Producto,
	   UPPER(P.nombreConductor) as NombreConductor,
	   P.codigoConductor as CedulaConductor,
	   upper(B.vehiculo)as Vehiculo,
	   B.remolque,
	   B.procedencia,
	   upper(B.bodega) as Destino,
	   B.pesoBruto,
	   b.pesodescuento,
	   B.pesoTara,
	   B.pesoNeto,
	   B.racimos,
	   B.sacos,
	   upper(B.tipoDescargue) as cooperativa,
	   UPPER(S.descripcion) AS Basculero,
	    k.descripcion as Finca	,
		b.sellos   ,
		isnull(tt.razonSocial,tt1.razonSocial) cliente,
		isnull(uu.descripcion,uu1.descripcion)destino,B.remision,B.numero

from bRegistroBascula B 
	join bRegistroPorteria P on B.remision=P.numero and b.empresa=p.empresa
	join gTipoTransaccion T on B.tipo = T.codigo and t.empresa=b.empresa
	join iItems U on  B.item= U.codigo  and b.empresa=u.empresa
	 join sUsuarios S on B.usuario=S.usuario  
	left join logDespacho ss on ss.tiquete=b.tiquete and ss.empresa=b.empresa
	left join logProgramacionVehiculo dd on dd.numero=B.remision and dd.empresa=B.empresa
	left join cTercero tt on ss.cliente =tt.id and ss.empresa=tt.empresa 
	left join cxcCliente uu on ss.cliente=uu.idTercero and uu.empresa=tt.empresa and uu.codigo=ss.lugarEntrega
	left join cTercero tt1 on dd.tercero=tt1.id and dd.empresa=tt1.empresa 
	left join cxcCliente uu1 on dd.tercero =uu1.idTercero and uu1.empresa=tt1.empresa and uu1.codigo=dd.cliente
 left join  aFinca k on k.codigo=b.finca and k.empresa=b.empresa
where B.tiquete=@tiquete and b.empresa=@empresa