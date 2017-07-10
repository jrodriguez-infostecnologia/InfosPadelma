CREATE PROCEDURE [dbo].[SpSeleccionaInformaciónConcepto]
	@empresa int,
	@codigo varchar(50)
AS
	 select 
	 a.baseSeguridadSocial, 
	 a.signo, 
	 a.porcentaje, 
	 CASE WHEN a.codigo IN (np.salud, np.pension, np.fondoSolidaridad) THEN CONVERT(bit,1) ELSE CONVERT(bit,0) END calculaSobrePorcentaje,	 
	 a.habilitaValorTotal
	 from nConcepto a
	 INNER JOIN dbo.nParametrosGeneral AS np ON np.empresa = a.empresa
	 where a.empresa = @empresa and a.codigo = @codigo
RETURN 0