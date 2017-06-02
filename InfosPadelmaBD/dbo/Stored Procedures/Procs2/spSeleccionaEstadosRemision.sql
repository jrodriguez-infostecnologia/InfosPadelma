CREATE proc [dbo].[spSeleccionaEstadosRemision]
@empresa int
as

select  a.codigo,a.fechaCreacion,a.fechaAsignacion,a.fechaImpresion,a.estado,b.numero,c.vehiculo,c.remolque, c.estado estadoEMP from bRemision a
left join bRegistroBascula b on b.remision=a.codigo and b.empresa=a.empresa
left join bRegistroPorteria c on c.remision=a.codigo and c.empresa=a.empresa
where a.empresa=@empresa and 
(b.estado<>'FP' and c.estado<>'FP') or c.estado is null