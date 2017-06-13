CREATE proc spSeleccionaNovedadesPeriodicasAbiertas
@empresa int
as

select *, convert(int,substring(numero,4,len(numero))) numeroTransaccion, case when liquidada=1 then 'Si' else 'No' end liqui
from vSeleccionaRegistroNovadesNomina
where empresa=@empresa and registroAnulado=0 and anuladaTransaccion=0
and (añoFinal>añoFinal or periodoFinal>periodoInicial)