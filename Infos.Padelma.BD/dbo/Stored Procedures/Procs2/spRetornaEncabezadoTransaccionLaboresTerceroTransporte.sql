CREATE proc [dbo].[spRetornaEncabezadoTransaccionLaboresTerceroTransporte]
@numero varchar(50),
@tipo varchar(50),
@empresa int 
as

select distinct a.novedad, b.id,b.descripcion razonSocial,a.lote, a.zCuadrilla,a.jornales,a.cantidad  , a.registronovedad  
from  aTransaccionTercero a
join aNovedad bb on a.novedad=bb.codigo and a.empresa=bb.empresa
join ctercero b on a.tercero=b.id and b.empresa=a.empresa
left join ncuadrillafuncionario c on a.tercero=c.funcionario and 
c.empresa=a.empresa
where a.numero = @numero and a.tipo=@tipo and a.empresa = @empresa and bb.claseLabor=4