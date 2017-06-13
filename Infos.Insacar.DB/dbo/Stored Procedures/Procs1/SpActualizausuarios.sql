create PROCEDURE [dbo].[SpActualizausuarios]
	@id			varchar(150),
	@idSys		varchar(250),
	@idSysNew	varchar(250),
	@retorno	int	output
AS
/***************************************************************************
Nombre: spActualizaUsuarios
Tipo: Procedimiento Almacenado
Desarrollado: Infos Tecnologia SAS
Argumentos de entrada: Id, id sistema, id sistema nuevo
Argumentos de salida: 0 Transacción satisfactoria,
					  1 Si el idSys no cumple la validación,
					  2 idSys no cumple la longitud,
					  3 Error en la transacción.
Descripción: Actualiza un registro en la tabla usuarios
*****************************************************************************/

		declare @encryptId		varbinary(250),
				@encryptIdNew	varbinary(250)

		set @retorno = 3

		OPEN MASTER KEY DECRYPTION BY PASSWORD = '23987hxJKL969#ghf0%94467GRkjg5k3fd117r$$#1946kcj$n44nhdlj'

		OPEN SYMMETRIC KEY SSN_Key_01
		   DECRYPTION BY CERTIFICATE UsuariosidSys;

		set @encryptIdNew = EncryptByKey( key_GUID( 'SSN_Key_01' ),@idSysNew )				

		if( not exists( select usuario from sUsuarios
						where
						convert( varchar(250),DecryptByKey( clave ) ) = @idSys ) )
		begin
			set @retorno = 1
		end
		else
		begin
			if( len( @idSysNew ) < 4 )
			begin
				set @retorno = 2
			end
			else
			begin

				begin tran ActualizaUsuario

					update susuarios
					set 
					clave = @encryptIdNew
					where
					usuario = @id

				if( @@error = 0 )
				begin
					commit tran ActualizaUsuario
					set @retorno = 0
				end
				else
				begin
					rollback tran ActualizaUsuario
					set @retorno = 3
				end
			end
		end