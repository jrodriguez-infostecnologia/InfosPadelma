
create PROCEDURE [dbo].[spSeleccionaCentroCostoSiigoNivel]
	@nivel int,
	@empresa int	
AS
	select * from cCentrosCostosigo
	where nivel = @nivel and
	empresa=@empresa and auxiliar=0