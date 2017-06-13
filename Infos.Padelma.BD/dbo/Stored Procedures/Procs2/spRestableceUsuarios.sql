
CREATE PROCEDURE [dbo].[spRestableceUsuarios]
	@usuario		varchar(150),
	@clave		varchar(50),
	@retorno	int	output
AS
/*************************************************************************
Nombre: spRestableceUsuarios
Tipo: Procedimiento Almacenado
Desarrollado: Infos Tecnologia SAS
Fecha: 04/11/2014

*****************************************************************************/

		declare @encryptId		varbinary(250),
				@encryptIdNew	varbinary(250)

		set @retorno = 1
		set @clave='1234567'

		OPEN MASTER KEY DECRYPTION BY PASSWORD = '23987hxJKL969#ghf0%94467GRkjg5k3fd117r$$#1946kcj$n44nhdlj'

		OPEN SYMMETRIC KEY SSN_Key_01
		   DECRYPTION BY CERTIFICATE UsuariosidSys;

		set @encryptIdNew = EncryptByKey( key_GUID( 'SSN_Key_01' ),@clave )				

		if exists(select * from sUsuarios where usuario=@usuario)
		begin
				begin tran ActualizaUsuario

					update susuarios
					set 
					clave = @encryptIdNew
					where
					usuario = @usuario

				if( @@error = 0 )
				begin
					commit tran ActualizaUsuario
					set @retorno = 0
				end
				else
				begin
					rollback tran ActualizaUsuario
					set @retorno = 1
				end
			end
			else
				set @retorno = 1