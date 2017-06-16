CREATE PROCEDURE [dbo].[SpSeleccionaInformaciónConcepto]
	@empresa int,
	@codigo varchar(50)
AS
	 select *, 
	 CASE WHEN a.codigo IN (np.salud, np.pension, np.fondoSolidaridad) THEN CONVERT(bit,1) ELSE CONVERT(bit,0) END calculaSobrePorcentaje 
	 from nConcepto a
	 JOIN dbo.nParametrosGeneral AS np ON np.empresa = a.empresa
	 where a.empresa = @empresa and codigo = @codigo
RETURN 0
