CREATE proc [dbo].[spRetornaAuxiliaresPuc]
@empresa int
as

select codigo , codigo +' - '+ descripcion  nombre from cPuc
where tipoDisponible ='A' 
and empresa = @empresa

select * from cPuc