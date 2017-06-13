--update nVacaciones
--set liquidada=1
--where  año=2015
create proc [dbo].spverificaVacacionesLiquidadas
@empresa int,
@empleado int,
@periodoInicial date,
@periodoFinal date,
@registro int,
@usuario varchar(50),
@retorno int output
as

if exists ( select * from nVacaciones
where empleado=@empleado and empresa=@empresa and periodoInicial=@periodoInicial
and periodoFinal=@periodoFinal and registro=@registro
and liquidada=1
)
begin
set @Retorno = 1 
end
else 
begin
set @retorno=0
end