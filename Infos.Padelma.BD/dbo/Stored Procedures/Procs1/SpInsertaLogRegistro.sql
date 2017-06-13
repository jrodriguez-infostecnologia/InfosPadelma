CREATE PROCEDURE [dbo].[SpInsertaLogRegistro] 
@usuario varchar(50),
@operacion varchar(50),
@entidad varchar(250),
@mensajeSistema varchar(500),
@ip varchar(50),
@estado char(10),
@empresa int,
@Retorno int output  
AS begin tran log 

if @empresa=0
begin

if exists(	select top 1 empresa from sLogRegistros	where usuario=@usuario
	order by fecha desc )
	begin
		set @empresa=(select top 1 empresa from sLogRegistros
		where usuario=@usuario
		order by fecha desc)
	end
	else
	begin
		set @empresa = (select top 1 empresa from sUsuarioPerfiles
		where usuario=@usuario)
	end
end
	
		

insert sLogRegistros(usuario
      ,fecha
      ,operacion
      ,empresa
      ,entidad
      ,estado
      ,mensajeSistema
      ,ip ) 
      
select @usuario,getdate(),@operacion,@empresa,@entidad,@estado,@mensajeSistema,@ip

if (@@error = 0 ) 
begin 
set @Retorno = 0 
commit tran log 
end 
else 
begin 
set @Retorno = 1 
rollback tran log 
end