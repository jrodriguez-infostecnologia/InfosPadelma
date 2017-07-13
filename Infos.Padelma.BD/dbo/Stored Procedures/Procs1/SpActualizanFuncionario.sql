CREATE PROCEDURE [dbo].[SpActualizanFuncionario] @fechaNacimiento date,@empresa int,
@tercero int,@activo bit,@validaTurno bit,@conductor bit,@operadorLogistico bit,@extranjero bit,@otros bit,
@declarante bit,@sexo varchar(1),@codigo varchar(50),@proveedor varchar(50),@cliente varchar(50),@contratista bit,
@descripcion varchar(950),@rh varchar(50),@ciduadNacimiento varchar(50),@nivelEducativo varchar(50), @foto varbinary(max),@Retorno int output  
AS 
begin tran nFuncionario 

declare @idFoto int;
SELECT @idFoto=foto FROM nFuncionario 
WHERE empresa = @empresa and tercero = @tercero; 

declare @error int;

IF @idFoto is not null
begin
	IF @foto is not null
	begin   
		exec SpActualizagFoto @idFoto, @foto,@error output;
	END
end
ELSE
begin
	IF @foto is not null
	begin   
		exec SpInsertagFoto @foto,@error output;
		SET @idFoto = IDENT_CURRENT('gFoto');
	END
end

if (@error = 1 ) 
begin 
	set @Retorno = 1 
	rollback tran nFuncionario 
	return 1
end


update nFuncionario 
set 
fechaNacimiento = @fechaNacimiento,
activo = @activo,
validaTurno = @validaTurno,
conductor = @conductor,
operadorLogistico = @operadorLogistico,
extranjero = @extranjero,
declarante = @declarante,
sexo = @sexo,
codigo = @codigo,
proveedor = @proveedor,
cliente = @cliente,
descripcion = @descripcion,
rh = @rh,
ciduadNacimiento = @ciduadNacimiento,
nivelEducativo = @nivelEducativo, 
contratista=@contratista,
otros=@otros,
foto=@idFoto
where empresa = @empresa and tercero = @tercero

if @activo=0 
begin
	if exists(select * from nContratos where empresa=@empresa and tercero=@tercero and activo=1)
	begin
		update nContratos
		set activo=0,
		fechaRetiro = getdate()
		where empresa=@empresa and tercero=@tercero and activo=1
	end
end

 if (@@error = 0 ) 
 begin set @Retorno = 0 
 commit tran nFuncionario end 
 else 
 begin set @Retorno = 1 
 rollback tran nFuncionario end