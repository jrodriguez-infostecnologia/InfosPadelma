CREATE PROCEDURE [dbo].[SpInsertanFuncionario] @fechaNacimiento date,@empresa int,@tercero int,@activo bit,
@contratista bit,@validaTurno bit,@conductor bit,@operadorLogistico bit,@extranjero bit,@declarante bit,@sexo varchar(1),
@codigo varchar(50),@proveedor varchar(50),@cliente varchar(50),@descripcion varchar(950),@rh varchar(50),
@ciduadNacimiento varchar(50),@nivelEducativo varchar(50),@Retorno int output  AS begin tran nFuncionario 
insert nFuncionario( fechaNacimiento,empresa,tercero,activo,validaTurno,conductor,operadorLogistico,extranjero,declarante,
sexo,codigo,proveedor,cliente,descripcion,rh,ciduadNacimiento,nivelEducativo , contratista) 
select @fechaNacimiento,@empresa,@tercero,@activo,@validaTurno,@conductor,@operadorLogistico,@extranjero,@declarante,
@sexo,@codigo,@proveedor,@cliente,@descripcion,@rh,@ciduadNacimiento,@nivelEducativo, @contratista 
if (@@error = 0 ) begin set @Retorno = 0 commit tran nFuncionario end else begin set @Retorno = 1 rollback tran nFuncionario end