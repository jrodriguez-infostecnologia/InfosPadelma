create proc [dbo].[spSeleccionaAnalisisResultado]
@jerarquia int,
@empresa int,
@retorno int output
as


declare @bandera int 

select @bandera= COUNT(*) from pJerarquiaAnalisis a where a.jerarquia=@jerarquia   and
resultado=1 and empresa=@empresa

if	@bandera>0
begin
set @retorno=1
end
else
begin
set @retorno=0
end