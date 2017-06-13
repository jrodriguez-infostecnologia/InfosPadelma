
CREATE PROCEDURE [dbo].[spSeleccionaCampoTipoEntidad]
	@tipoTransaccion	varchar(50),
	@entidad			varchar(250),
	@empresa			int,
	@campo				varchar(250)
AS
/***************************************************************************
Nombre: spSeleccionaCampoTipoEntidad
Tipo: Procedimiento Almacenado
Desarrollado: Infos Tecnologia SAS


Argumentos de entrada: Tipo transacción, entidad BD
Argumentos de salida: 
Descripción: Selecciona los campos que deben mostrarse segú la entidad y el 
			 tipo de transacción.
*****************************************************************************/

	select campo,tercero,aplicaCliente,aplicaProveedor,aplicaTercero,terceroDefecto,tipoCampo
	from gTipoTransaccionCampo
	where
	tipoTransaccion = @tipoTransaccion and
	entidad = @entidad and
	campo = @campo
	and empresa	 = @empresa
	order by campo