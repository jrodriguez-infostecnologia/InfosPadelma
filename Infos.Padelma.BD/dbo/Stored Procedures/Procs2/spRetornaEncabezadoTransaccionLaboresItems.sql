
create proc [dbo].[spRetornaEncabezadoTransaccionLaboresItems]
@numero varchar(50),@tipo varchar(50),@empresa int 
as
select a.item, b.descripcion, a.uMedida, a.dosis, a.mBulto, a.pBulto, a.noPalmas, a.registro, a.lote, a.registror
 from atransaccion aa 
 join aTransaccionItem a on  aa.numero = a.numero and aa.tipo=a.tipo and aa.empresa=a.empresa 
 join iitems b on a.item=b.codigo and a.empresa=b.empresa
where a.numero = @numero and a.tipo=@tipo and a.empresa = @empresa