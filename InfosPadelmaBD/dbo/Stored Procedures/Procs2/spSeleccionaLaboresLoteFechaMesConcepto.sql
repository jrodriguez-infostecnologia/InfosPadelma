CREATE proc [dbo].[spSeleccionaLaboresLoteFechaMesConcepto]
@fi date,
@ff date,
@empresa int
as


select distinct nombreLabor,codLabor
from vSeleccionaTransaccionesAgronomico a join aLotes  b on a.codLote=b.codigo and a.codEmpresa=b.empresa
where fechaLabor between @fi and @ff and codEmpresa=@empresa 
order by nombreLabor