
CREATE PROCEDURE [dbo].[spVerificaEdicionBorradoTransaccionesLabores]
	@tipo		varchar(50),
	@numero		varchar(50),
	@empresa	int,
	@retorno	int output
AS
/***************************************************************************
Nombre: spVerificaEdicionBorradoAlmacen
Tipo: Procedimiento Almacenado
Desarrollado: INFOS TECNOLOGIA S.A.S
*****************************************************************************/

	set @retorno = 0

	if( exists( select referencia
				from atransaccion
				where
				referencia = @numero  and 
				empresa=@empresa ) )
	begin
		set @retorno = 1
	end				
	else
	begin
		if( exists ( select anulado
					 from atransaccion
					 where
					 tipo = @tipo and
					 numero = @numero and
					 empresa =@empresa and
					 anulado <> 0 ) )
		begin
			set @retorno = 1
		end
		else
		begin
			if( exists ( select *
					 from nLiquidacionPrima pri
					 INNER JOIN nPeriodoDetalle npe
					 ON pri.empresa = npe.empresa
					 ANd pri.periodo = npe.noPeriodo
					 where
					 tipo = @tipo and
					 numero = @numero and
					 pri.empresa =@empresa and
					 npe.cerrado <> 0 ) )
			set @retorno = 2
		end
		
	end