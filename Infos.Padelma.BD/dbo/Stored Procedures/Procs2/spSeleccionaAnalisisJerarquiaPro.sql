
CREATE PROCEDURE [dbo].[spSeleccionaAnalisisJerarquiaPro]
	@jerarquia int,
	@empresa int
AS
/***************************************************************************
Nombre: spSeleccionaAnalisisJerarquiaPro
INFOS TECNOLOGIA S.A.S
*****************************************************************************/

	select c.codigo,c.descripcion ,c.uMedida,a.resultado,a.prioridad,a.formula,a.discreta,c.control,a.campoResul
	,a.resultadoParcial, a.resultadofinal
	from pJerarquiaAnalisis a left join lAnalisis c	 on a.analisis=c.codigo and a.empresa=c.empresa
	where
	a.jerarquia = @jerarquia
	and a.empresa=@empresa
	order by c.descripcion