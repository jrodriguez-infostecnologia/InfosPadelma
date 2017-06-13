CREATE PROCEDURE [dbo].[SpActualizanFuncionario] @fechaNacimiento date,@empresa int,
@tercero int,@activo bit,@validaTurno bit,@conductor bit,@operadorLogistico bit,@extranjero bit,
@declarante bit,@sexo varchar(1),@codigo varchar(50),@proveedor varchar(50),@cliente varchar(50),@contratista bit,
@descripcion varchar(950),@rh varchar(50),@ciduadNacimiento varchar(50),@nivelEducativo varchar(50),@Retorno int output  
AS begin tran nFuncionario update nFuncionario set fechaNacimiento = @fechaNacimiento,activo = @activo,validaTurno = @validaTurno,conductor = @conductor,operadorLogistico = @operadorLogistico,extranjero = @extranjero,declarante = @declarante,sexo = @sexo,codigo = @codigo,proveedor = @proveedor,cliente = @cliente,
descripcion = @descripcion,rh = @rh,ciduadNacimiento = @ciduadNacimiento,nivelEducativo = @nivelEducativo , contratista=@contratista
where empresa = @empresa and tercero = @tercero
 if (@@error = 0 ) begin set @Retorno = 0 commit tran nFuncionario end else begin set @Retorno = 1 rollback tran nFuncionario end