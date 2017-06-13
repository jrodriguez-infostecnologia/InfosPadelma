CREATE proc [dbo].[spSeleccionContratosVencer]
@empresa int
as

declare @tercero int, @fechaIngreso date, @fechaTerminacion date, @diasContrato int,@nombreTercero varchar(550),@nombreClaseContrato varchar(550),
@prorroga1 date,@prorroga2 date,@prorroga3 date,@preAviso date,@diasAviso int=0,@codTercero varchar(50),@noContrato int

create table #venceContrato(
tercero int, 
codTercero varchar(50),
nombretercero varchar(250),
fechaIngreso date, diasContrato int,fechaTerminacion date,
prorroga1 date,prorroga2 date,prorroga3 date, fechaPreaviso date, diasAviso int,noContrato int,nombreClaseContrato varchar(550)
)
	declare curContratos insensitive cursor for
	select tercero,fechaIngreso,diasContrato,b.descripcion, b.codigo,a.id,c.descripcion
	 from nContratos a
	join cTercero b on b.id=a.tercero and b.empresa=a.empresa
	join nClaseContrato c on c.codigo=a.claseContrato and c.empresa=a.empresa
	where a.empresa=@empresa and terminoFijo=1 and a.activo=1
	open curContratos			
	fetch curContratos into @tercero,@fechaIngreso,@diasContrato,@nombreTercero,@codTercero,@noContrato,@nombreClaseContrato
	while( @@fetch_status = 0 )
	begin	
		
		set @fechaTerminacion = dateadd(day,-1,dateadd(MONTH,(@diasContrato/30),@fechaIngreso))
		set @prorroga1 =dateadd(MONTH,(@diasContrato/30),@fechaTerminacion)
		set @prorroga2 =dateadd(MONTH,(@diasContrato/30),@prorroga1)
		set @prorroga3 =dateadd(MONTH,(@diasContrato/30),@prorroga2)
		
		while @prorroga3<GETDATE()
		begin
			set @prorroga1 =dateadd(YEAR,1,@prorroga3)
			set @prorroga2 =dateadd(YEAR,1,@prorroga1)
			set @prorroga3 =dateadd(YEAR,1,@prorroga2)
		end

		set @preAviso =dateadd(DAY,-30,@prorroga1)
		set @diasAviso = DATEDIFF(day,getdate(),@preAviso)
		if DATEDIFF(day,getdate(),@preAviso)<0
		begin
			set @preAviso =dateadd(DAY,-30,@prorroga2)
			set @diasAviso = DATEDIFF(day,getdate(),@preAviso)
			if DATEDIFF(day,getdate(),@preAviso)<0
			begin
				set @preAviso =dateadd(DAY,-30,@prorroga3)
				set @diasAviso = DATEDIFF(day,getdate(),@preAviso)
			end
		end



		insert #venceContrato
		select @tercero,@codTercero,@nombreTercero,	@fechaIngreso,@diasContrato,@fechaTerminacion,@prorroga1,@prorroga2,@prorroga3,@preAviso,@diasAviso,@noContrato,@nombreClaseContrato
						
	fetch curContratos into @tercero,@fechaIngreso,@diasContrato,@nombreTercero,@codTercero,@noContrato,@nombreClaseContrato
	end
	close curContratos
	deallocate curContratos
	
	select * from #venceContrato
	where diasAviso>0
	order by diasAviso 

	drop table #venceContrato