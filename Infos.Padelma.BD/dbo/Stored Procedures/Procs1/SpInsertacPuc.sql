
CREATE PROCEDURE [dbo].[SpInsertacPuc] @empresa int,@nivel int,@clase varchar(50),@tercero bit,@cCosto bit,@base bit,
@activo bit,@codigo varchar(16),@raiz varchar(16),@nombre varchar(150),@naturaleza char(1),@tipo char(1),@Retorno int output  AS begin tran cPuc 
insert cPuc( empresa,nivel,clase,tercero,cCosto,base,activo,codigo,raiz,nombre,naturaleza,tipo )
 select @empresa,@nivel,@clase,@tercero,@cCosto,@base,@activo,@codigo,@raiz,@nombre,@naturaleza,@tipo 
 if (@@error = 0 ) begin set @Retorno = 0 commit tran cPuc end else begin set @Retorno = 1 rollback tran cPuc end