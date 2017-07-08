CREATE PROCEDURE [dbo].[SpSeleccionaInformaciónConcepto]
	@empresa int,
	@codigo varchar(50)
AS
	 select 
	 a.baseSeguridadSocial, 
	 a.signo, 
	 a.porcentaje, 
	 CASE WHEN a.codigo IN (np.salud, np.pension, np.fondoSolidaridad) THEN CONVERT(bit,1) ELSE CONVERT(bit,0) END calculaSobrePorcentaje,
	 CAST(CASE WHEN COUNT(nov.codigo)>0 THEN 1  ELSE 0 END AS BIT) agrupaLaboresAgronomico 
	 from nConcepto a
	 INNER JOIN dbo.nParametrosGeneral AS np ON np.empresa = a.empresa
	 LEFT JOIN aNovedad AS nov 
	 ON nov.empresa = a.empresa
	 AND nov.concepto = a.codigo
	 where a.empresa = @empresa and a.codigo = @codigo
	 GROUP BY
	 a.codigo,
	 a.empresa,
	 a.baseSeguridadSocial, 
	 a.signo, 
	 a.porcentaje,
	 np.salud, 
	 np.pension, 
	 np.fondoSolidaridad
RETURN 0
