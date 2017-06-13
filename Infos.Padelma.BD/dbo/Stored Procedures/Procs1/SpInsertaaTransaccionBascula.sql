
CREATE PROCEDURE [dbo].[SpInsertaaTransaccionBascula] @empresa int,@empresaExtractora int,@terceroExtractrora int,@pesoBruto int,@pesoTara int,
@pesoNeto int,@sacos int,@racimos int,@codigoConductor varchar(50),@fecha datetime,@interno bit,@tipo varchar(50),@numero varchar(50),@tiquete varchar(50),
@nombreConductor varchar(550),@vehiculo varchar(50),@remolque varchar(50),@Retorno int output  AS begin tran aTransaccionBascula 
insert aTransaccionBascula( empresa,empresaExtractora,terceroExtractrora,pesoBruto,pesoTara,pesoNeto,sacos,racimos,codigoConductor,fecha,interno,tipo,numero,tiquete,nombreConductor,vehiculo,remolque ) 
select @empresa,1,@terceroExtractrora,@pesoBruto,@pesoTara,@pesoNeto,@sacos,@racimos,@codigoConductor,@fecha,@interno,@tipo,@numero,@tiquete,@nombreConductor,@vehiculo,@remolque if (@@error = 0 ) begin set @Retorno = 0 commit tran aTransaccionBascula end else begin set @Retorno = 1 rollback tran aTransaccionBascula end