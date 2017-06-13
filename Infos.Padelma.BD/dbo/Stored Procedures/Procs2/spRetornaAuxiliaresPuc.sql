CREATE proc [dbo].[spRetornaAuxiliaresPuc]
@empresa int
as

select codigo , codigo +' - '+ nombre  nombre from cPuc
where tipo ='A' 
and empresa = @empresa