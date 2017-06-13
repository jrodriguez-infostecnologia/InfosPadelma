CREATE PROCEDURE [dbo].[SpInsertanProrroga] @fechaInicial date,@fechaFinal date,
@fechaFinalAnterior date,@fechaRetiro date,@empresa int,@id int,@contrato int,@tercero int,
@dias int,@fechaRegistro datetime,@retirado bit,@tipo varchar(1),@observacion varchar(5550),
@usuario varchar(50),@motivoRetiro varchar(50),@Retorno int output  AS 
begin tran nProrroga 
insert nProrroga( fechaInicial,fechaFinal,fechaFinalAnterior,fechaRetiro,empresa,id,contrato,
tercero,dias,fechaRegistro,retirado,tipo,observacion,usuario,motivoRetiro ) 
select @fechaInicial,@fechaFinal,@fechaFinalAnterior,@fechaRetiro,@empresa,@id,@contrato,@tercero,
@dias,@fechaRegistro,@retirado,@tipo,@observacion,@usuario,@motivoRetiro 

if @tipo ='R'
begin
	update nContratos set
	activo=0,
	fechaRetiro =@fechaRetiro,
	fechaContratoHasta=@fechaRetiro,
	usuario=@usuario
	where tercero=@tercero and id=@contrato and empresa=@empresa

	UPDATE nFuncionario SET
	activo=0
	WHERE empresa=@empresa AND tercero=@tercero 
end
else
begin
	update nContratos set
	activo=1,
	fechaRetiro = null,
	fechaContratoHasta =@fechaFinal,
	usuario=@usuario
	where tercero=@tercero and id=@contrato and empresa=@empresa

	UPDATE nFuncionario SET
	activo=1
	WHERE empresa=@empresa AND tercero=@tercero 

end
if (@@error = 0 ) begin set @Retorno = 0 commit tran nProrroga end else begin set @Retorno = 1 rollback tran nProrroga end