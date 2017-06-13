CREATE proc [dbo].[spSeleccionaPeriodosContabilizacion]
 @año int, @empresa int,
 @tipo varchar(50)
as


if @tipo<>'SS' 
begin

		if @tipo='PS'
		BEGIN
		 select noPeriodo, cast(año as varchar) + ' - ' + cast(noPeriodo as varchar) + ' del ' + CAST(fechaInicial as varchar) + ' al ' +  CAST(fechaFinal as varchar)
		+ case when agronomico=1 then '- Agronomico' else '' end 
		descripcion
		from nPeriodoDetalle
		where año=@año and empresa=@empresa
		END
		ELSE
		BEGIN
		select noPeriodo, cast(año as varchar) + ' - ' + cast(noPeriodo as varchar) + ' del ' + CAST(fechaInicial as varchar) + ' al ' +  CAST(fechaFinal as varchar)
		+ case when agronomico=1 then '- Agronomico' else '' end 
		descripcion
		from nPeriodoDetalle
		where año=@año and empresa=@empresa and cerrado=1
		END
		
end

else
begin 
		select mes noPeriodo, 
			cast(año as varchar) + ' - '  + descripcion
			descripcion
			from cPeriodo
		where año=@año and empresa=@empresa and cerrado=1
end