CREATE proc [dbo].[spCargarPeriodoVacacionesEmpleado]
@empresa int,
@empleado int,
@retorno varchar(100) output
as

declare @fechaHoy date = convert(date,getdate()),
@fechaIngreso date, @fechaAño date

if not exists(select * from nvacaciones
where empresa=@empresa and empleado=@empleado 
and anulado<>1)
begin

	-- selecciono la fecha de ingreso en el contrato
	select @fechaIngreso=fechaIngreso from ncontratos
	where tercero=@empleado and empresa=@empresa
	set @fechaAño=dateadd(month,12, @fechaIngreso)
	set @fechaAño=dateadd(day,-1, @fechaAño)
	set @retorno= convert(varchar(500),@fechaIngreso,103) +'-'+convert(varchar(500),@fechaAño,103)



end
else
begin

declare @ultimoPLI date,@ultimoPLF date, @registro int

		select top 1 @ultimoPLI=periodoInicial, @ultimoPLF=periodoFinal from nvacaciones
		where empresa=@empresa and empleado=@empleado 
		and anulado<>1
		order by periodoInicial desc

	
	if exists (select *  from nvacaciones
		where empresa=@empresa and empleado=@empleado and periodoInicial =@ultimoPLI and periodoFinal=@ultimoPLF  and ejecutado=0 and diasPendientes<>0
		and anulado<>1)
		begin

			set @retorno= (select top 1 convert(varchar(500),periodoInicial,103) +'-'+convert(varchar(500),periodoFinal,103)
			from nvacaciones
			where empresa=@empresa and empleado=@empleado 
			and anulado<>1
			order by fechaSalida desc, registro desc
			)
		end
		else
		begin
		
			select @fechaIngreso=periodoFinal from nvacaciones
			where empleado=@empleado and empresa=@empresa
			and periodoInicial=@ultimoPLI and periodoFinal=@ultimoPLF  and diasPendientes=0
			and anulado<>1
			order by periodoInicial desc

		
			
			set @fechaAño=dateadd(month,12, @fechaIngreso)
			set @fechaIngreso = DATEADD(day, 1, @fechaIngreso)
			set @retorno= convert(varchar(500),@fechaIngreso,103) +'-'+convert(varchar(500),@fechaAño,103)
		end
end