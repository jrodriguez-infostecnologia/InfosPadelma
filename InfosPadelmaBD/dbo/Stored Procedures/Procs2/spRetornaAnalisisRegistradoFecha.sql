CREATE proc [dbo].[spRetornaAnalisisRegistradoFecha]
@fecha datetime, 
@jerarquia int, 
@analisis varchar(50),
@tipo varchar(50),
@empresa int
as

declare @concurrencia varchar(2)
 
select @concurrencia=concurrencia from gTipoTransaccionConcurrencia where transaccion=@tipo
and empresa=@empresa 

if @concurrencia='D' or @concurrencia='H'
begin
select valor from pTransaccionJerarquiaAnalisis
where fecha=@fecha and jerarquia=@jerarquia and tipo=@tipo and analisis=@analisis
and empresa=@empresa
end

if(@concurrencia='S')
begin
select valor from pTransaccionJerarquiaAnalisis
where datepart(week,fecha)=datepart(week,@fecha) and jerarquia=@jerarquia and tipo=@tipo and analisis=@analisis
and empresa=@empresa
end