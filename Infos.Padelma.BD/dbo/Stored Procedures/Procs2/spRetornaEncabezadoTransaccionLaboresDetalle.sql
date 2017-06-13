
CREATE proc [dbo].[spRetornaEncabezadoTransaccionLaboresDetalle]
@numero varchar(50),
@tipo varchar(50),
@empresa int 
as

select a.tipo, a.numero,a.novedad, b.descripcion, a.lote, c.descripcion,a.racimos,
a.seccion, d.descripcion,a.uMedida,a.cantidad,a.fecha,a.pesoRacimo,a.jornales,a.registro,b.claseLabor,a.precioLabor
 from atransaccionNovedad a join aNovedad b on a.novedad=b.codigo and a.empresa=b.empresa
left join aLotes c on a.lote = c.codigo and a.empresa = c.empresa left join aSecciones d on a.seccion = d.codigo and d.empresa=a.empresa
where numero = @numero and tipo=@tipo and a.empresa = @empresa