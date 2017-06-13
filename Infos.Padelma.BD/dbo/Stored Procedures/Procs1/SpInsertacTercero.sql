﻿CREATE PROCEDURE [dbo].[SpInsertacTercero] @empresa int,@id int,@tipo int,@foto int,@fechaRegistro datetime,@activo bit,@comercializadora bit,
@cliente bit,@proveedor bit,@empleado bit,@accionista bit,@contratista bit,@extractora bit,@nit varchar(25),@razonSocial varchar(550),
@apellido1 varchar(250),@apellido2 varchar(250),@nombre1 varchar(550),@nombre2 varchar(250),@descripcion varchar(950),@ciudad varchar(50),
@contacto varchar(550),@telefono varchar(50),@direccion varchar(550),@barrio varchar(550),@fax varchar(50),@email varchar(250),@departamento varchar(50),
@codigo varchar(15),@tipoDocumento char(3),@dv char(3),@Retorno int output  AS begin tran cTercero 
insert cTercero( empresa,id,tipo,foto,fechaRegistro,activo,cliente,proveedor,empleado,accionista,contratista,extractora,nit,razonSocial,
apellido1,apellido2,nombre1,nombre2,descripcion,ciudad,contacto,telefono,direccion,barrio,fax,email,codigo,tipoDocumento,dv,comercializadora,departamento ) 
select @empresa,@id,@tipo,@foto,@fechaRegistro,@activo,@cliente,@proveedor,@empleado,@accionista,@contratista,@extractora,@nit,@razonSocial,
@apellido1,@apellido2,@nombre1,@nombre2,@descripcion,@ciudad,@contacto,@telefono,@direccion,@barrio,@fax,
@email,@codigo,@tipoDocumento,@dv ,@comercializadora,@departamento
if (@@error = 0 ) begin set @Retorno = 0 commit tran cTercero end else begin set @Retorno = 1 rollback tran cTercero end