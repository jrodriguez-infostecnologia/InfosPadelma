
CREATE PROCEDURE [dbo].[spModificaUsuarios]
	@id			varchar(150),
	@nombre		varchar(250),
	@correo		varchar(250),
	@activo		bit,
	@retorno	int	output
AS
/***************************************************************************
Nombre: spModificaUsuarios
Tipo: Procedimiento Almacenado
Desarrollado: Infos Tecnologia 
Fecha: 31/10/2014

Argumentos de entrada: Id, nombre, activo, vigencia
Argumentos de salida: 0 Transacción satisfactoria,
					  1 Error en la transacción.
Descripción: Modifica un registro en la tabla usuarios
~~*****************************************************************************/

	begin tran Actualiza

		update sUsuarios
		set
			descripcion = @nombre,
			activo = @activo,
			email=@correo
		where
		usuario = @id

	if( @@error = 0 )
	begin
		commit tran Actualiza
		set @retorno = 0
	end
	else
	begin
		rollback tran Actualiza
		set @retorno = 1
	end