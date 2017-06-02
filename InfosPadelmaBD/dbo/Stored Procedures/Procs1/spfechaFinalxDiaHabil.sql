CREATE proc [dbo].[spfechaFinalxDiaHabil]
@fechaInicial date,
@empresa int,
@noDias int,
@empleado int,
@retorno varchar(50) output

as

declare @de int , @hasta int, @contador int=0, @fechaParcial date,  @dia int

select  @de=de, @hasta=hasta from ncontratos a join nDiasHabilesCC b on 
a.ccosto=b.ccosto and a.empresa=b.empresa
where tercero=@empleado and b.activo=1 and a.activo=1
and a.empresa=@empresa

set @contador=@noDias
set @fechaParcial = @fechaInicial

if @de is null or @hasta is null
begin
	set @de = 1
	set @hasta = 6
end

select @de, @hasta

while @contador<>0
begin
	set @dia=  datepart(WEEKDAY,@fechaParcial)
	if  @dia between @de and @hasta
	begin
		if not exists(select * from nfestivo where fecha=@fechaParcial and empresa=@empresa)
		begin	
			set @fechaParcial = dateadd(day,1,@fechaParcial)	
			set @contador=@contador-1
		end	
		else
		begin
			set @fechaParcial = dateadd(day,1,@fechaParcial)	
		end	
	end
		else
		begin
			set @fechaParcial = dateadd(day,1,@fechaParcial)	
		end
end

while exists(select * from nfestivo where fecha=@fechaParcial and empresa=@empresa)
begin
	set @fechaParcial =DATEADD(day,1,@fechaParcial)
end

set @retorno = convert(varchar(50), @fechaParcial,103)