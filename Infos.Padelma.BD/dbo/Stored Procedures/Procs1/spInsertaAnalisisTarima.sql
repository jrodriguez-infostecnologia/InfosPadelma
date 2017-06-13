

CREATE PROCEDURE [dbo].[spInsertaAnalisisTarima]
	@tipo			varchar(50),
	@numero			varchar(50),
	@producto		varchar(50),
	@usuario	varchar(50),
	@bodega			varchar(50),
	@cooperativa	varchar(50),
	@sacos			int,
	@pTenera		float,
	@pDura			float,
	@pVerde			float,
	@pMadura		float,
	@pSobreMadura	float,
	@pPodridos		float,
	@pEnfermos		float,
	@pPedunculo		float,
	@pesoSacos		float,
	@empresa		int,
	@retorno		int output
AS
/***************************************************************************
Nombre: spSeleccionaVehicluosPropiosTipo
Tipo: Procedimiento Almacenado
Desarrollado: Infos Tecnologia SAS

Argumentos de entrada: Datos Tarima
Argumentos de salida: 0 Si es exitoso,
					  1 Si no es exitoso
Descripción: Inserta los análisis de tarima en la entidad lRegistroAnalisis
*****************************************************************************/

	declare @analisis	varchar(50),
			@fecha		datetime,
			@error		int
			
	set @error = 0			
	set @fecha = getdate()

		begin tran Inserta
		update bRegistroBascula
		set
		sacos = @sacos,
		analisisRegistrado = 1,
		bodega = @bodega,
		pesoSacos = @pesoSacos,
		tipoDescargue = @cooperativa
		where
		tipo = @tipo and
		numero = @numero
		and empresa=@empresa
		
		set @error = ( @error + @@ERROR )
		
	if( @error = 0 )
	begin
		commit tran Inserta
		set @retorno = 0
	end
	else
	begin
		rollback tran Inserta
		set @retorno = 1
	end