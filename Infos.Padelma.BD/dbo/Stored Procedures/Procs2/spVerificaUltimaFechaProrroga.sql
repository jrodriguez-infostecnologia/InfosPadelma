create proc [dbo].[spVerificaUltimaFechaProrroga]
@empresa int,
@tercero int,
@contrato int,
@tipo varchar(1),
@fecha varchar(20) output
as

set @fecha= (
select top 1 fechaFinal from nProrroga
where empresa=@empresa and 
tercero=@tercero
and contrato=@contrato
and tipo=@tipo
order by id desc
)

if @fecha is null
set @fecha=''