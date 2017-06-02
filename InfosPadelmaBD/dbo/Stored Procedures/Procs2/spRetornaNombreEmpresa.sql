create PROCEDURE [dbo].[spRetornaNombreEmpresa]
	@empresa		int,
	@nombreEmpresa		varchar(950) output
AS
/***************************************************************************
Nombre: spVerificaAccesoOperaciones
Tipo: Procedimiento Almacenado
Desarrollado: Infos Tecnologia S.A.S
*****************************************************************************/
		 set @nombreEmpresa = isnull((select razonSocial from gEmpresa 
								where id=@empresa),'')