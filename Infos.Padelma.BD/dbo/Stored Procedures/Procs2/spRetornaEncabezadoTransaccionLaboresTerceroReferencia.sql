CREATE proc [dbo].[spRetornaEncabezadoTransaccionLaboresTerceroReferencia]
@numero varchar(50),
@empresa int 
as


select distinct a.novedad,a.registro, b.id,b.descripcion razonSocial,a.lote, a.zCuadrilla,a.jornales,a.cantidad, a.registronovedad    from atransaccion aa left join aTransaccionTercero a
on  aa.numero = a.numero and aa.tipo=a.tipo and aa.empresa=a.empresa left join ctercero b on a.tercero=b.id
and b.empresa=a.empresa
left join ncuadrillafuncionario c on a.tercero=c.funcionario and 
c.empresa=a.empresa
where a.numero = @numero and a.empresa = @empresa