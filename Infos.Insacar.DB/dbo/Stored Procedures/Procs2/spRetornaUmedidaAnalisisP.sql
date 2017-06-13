create PROCEDURE [dbo].[spRetornaUmedidaAnalisisP]
	@variable		varchar(50),
	@empresa int,
	@uMedida		varchar(50) output
AS
/***************************************************************************
Nombre: spRetornaUmedidaAnalisisP
Tipo: Procedimiento Almacenado
INFOS TECNOLOGIA S.A.S
*****************************************************************************/

	select @uMedida = uMedida
	from lAnalisis
	where
	codigo = @variable
	and 
	empresa=@empresa