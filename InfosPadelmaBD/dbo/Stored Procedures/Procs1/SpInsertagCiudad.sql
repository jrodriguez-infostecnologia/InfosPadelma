CREATE PROCEDURE [dbo].[SpInsertagCiudad] @empresa int,@codigo varchar(50),@nombre varchar(150),@pais char(5),@departamento varchar(50),
@Retorno int output  AS begin tran gCiudad 
insert gCiudad( empresa,codigo,nombre,pais,departamento ) 
select @empresa,@codigo,@nombre,@pais,@departamento
 if (@@error = 0 ) begin set @Retorno = 0 commit tran gCiudad end else begin set @Retorno = 1 rollback tran gCiudad end