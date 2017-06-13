CREATE PROCEDURE [dbo].[spInsertaUsuarios]
	@id			varchar(150),
	@nombre		varchar(250),
	@idSys		varchar(250),
	@correo		varchar(250),
	@activo		bit,
	@fecha		datetime,
	@retorno	int	output
AS
/***************************************************************************
Nombre: spInsertaUsuarios
Tipo: Procedimiento Almacenado
Desarrollado: Infos Tecnologia 
Fecha: 31/10/2014

Argumentos de entrada: Id, nombre, id sistema, activo
Argumentos de salida: 0 Transacción satisfactoria,
					  1 Registro existente,
					  2 idSys no cumple la longitud,
					  3 Error en la transacción.
Descripción: Inserta un registro en la tabla usuarios
~~*****************************************************************************/

		declare @encryptId	varbinary(250)

		set @retorno = 3

		if( exists( select usuario from susuarios
					where
					usuario = @id ) )
		begin
			set @retorno = 1
		end
		else
		begin
			if( len( @idSys ) < 4 )
			begin
				set @retorno = 2
			end
			else
			begin
				OPEN MASTER KEY DECRYPTION BY PASSWORD = '23987hxJKL969#ghf0%94467GRkjg5k3fd117r$$#1946kcj$n44nhdlj'
				OPEN SYMMETRIC KEY SSN_Key_01
				   DECRYPTION BY CERTIFICATE UsuariosidSys;

				begin tran insertaUsuario

					set @encryptId = EncryptByKey( key_GUID( 'SSN_Key_01' ),@idSys )				

					insert susuarios(
					usuario,
					descripcion,
					clave,
					activo,
					fechaRegistro,
					email )
					select
					@id,
					@nombre,
					@encryptId,
					@activo,
					@fecha,
					@correo

				if( @@error = 0 )
				begin
					commit tran insertaUsuario
					set @retorno = 0
				end
				else
				begin
					rollback tran insertaUsuario
					set @retorno = 3
				end
			end
		end