CREATE PROCEDURE [dbo].[SpInsertalRegistroSellos] @empresa int,@fecha datetime,@tipo varchar(50),@numero varchar(50),@Sello varchar(50),@usuario varchar(50),@Retorno int output  AS begin tran 
lRegistroSellos 

if not exists (select * from lRegistroSellos where numero=@numero and tipo=@tipo and Sello=@Sello and empresa=@empresa)
begin
insert lRegistroSellos( empresa,fecha,tipo,numero,Sello,usuario ) 
select @empresa,@fecha,@tipo,@numero,@Sello,@usuario
end


 if (@@error = 0 ) 
 begin
  set @Retorno = 0 
  commit tran lRegistroSellos 
  end 
  else 
  begin 
  set @Retorno = 1 rollback 
  tran lRegistroSellos 
  end