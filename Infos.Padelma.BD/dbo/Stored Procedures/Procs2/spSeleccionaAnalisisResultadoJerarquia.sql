
CREATE PROCEDURE [dbo].[spSeleccionaAnalisisResultadoJerarquia]
	@jerarquia		int,
	@transaccion	varchar(50),
	@empresa int
AS
/***************************************************************************
Nombre: spSeleccionaAnalisisResultadoJerarquia
INFOS TECNOLOGIA S.A.S
*****************************************************************************/

	select distinct a.analisis,a.prioridad
	from pJerarquiaAnalisis a join lAnalisisitem b on
	a.analisis = b.analisis and  a.empresa=b.empresa
	where
	a.resultado = 1 and	
	a.jerarquia = @jerarquia 
	and a.empresa=@empresa
	and
	b.item in ( select producto
					from gTipoTransaccionProducto
					where
					tipo = @transaccion )		
	and a.resultadoFinal =0
	order by a.prioridad,a.analisis