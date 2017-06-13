CREATE PROCEDURE [dbo].spImprimeTiquetePesaje 
@tiquete as varchar(50),
@empresa int
AS
/***************************************************************************
Nombre: SpSeleccionaTiquetePES
Tipo: Procedimiento Almacenado
Desarrollado: Infos Tecnologia

Argumentos de entrada: Codigo del Tiquete
Argumentos de salida: 
Descripción: Selecciona Los datos para impresión de Tiquete Entrada de materia prima
*****************************************************************************/

select B.fechaBruto,
	   B.fechaTara,
	   B.tiquete,
	   B.fechaProceso,
	   upper(T.descripcion) as TipoMovimiento,
	   upper(U.descripcion) as Producto,
	   b.nombreConductor as NombreConductor,
	   b.codigoConductor as CedulaConductor,
	   upper(B.vehiculo)as Vehiculo,
	   B.remolque,
	   B.procedencia,
	   upper(B.bodega) as Destino,
	   B.pesoBruto,
	   B.pesoTara,
	   B.pesoNeto,
	   B.racimos,
	   B.sacos,
	   upper(B.tipoDescargue) as cooperativa,
	   UPPER(S.descripcion) AS Basculero
	 --   k.descripcion as Finca	   
from bRegistroBascula B 
	join gTipoTransaccion T on B.tipo = T.codigo and t.empresa=b.empresa
	join iItems U on  B.item= U.codigo  and b.empresa=u.empresa
	join sUsuarios S on B.usuario=S.usuario 
	--left join  aFinca k on k.codigo=b.finca
    
where B.tiquete=@tiquete
and b.empresa=@empresa