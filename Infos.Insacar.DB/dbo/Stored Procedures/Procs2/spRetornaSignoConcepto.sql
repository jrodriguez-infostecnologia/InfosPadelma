create proc [dbo].[spRetornaSignoConcepto]
@empresa int,
@concepto varchar(50),
@signo varchar(1) output
as

declare  @s int=0

select @s=signo from nconcepto
where codigo=@concepto and empresa=@empresa

if @s =1
set @signo='+'
if @s=2
set @signo='-'