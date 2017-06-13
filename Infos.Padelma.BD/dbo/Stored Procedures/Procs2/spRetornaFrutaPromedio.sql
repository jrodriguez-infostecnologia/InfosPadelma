CREATE proc [dbo].[spRetornaFrutaPromedio]
@fechaN date,
@empresa int
as

delete from pFrutaEstimadaTmp
where fecha=@fechaN
and empresa=@empresa

declare @vehiculo varchar(50),@remolque varchar(50), @pesoBruto int,@tiquete varchar(50)

		create table #tabla1 (
		vehiculo varchar(50),
		remolque varchar(50),
		pesoTara int)
		
		create table #tabla2 (
		tiquete varchar(50),
		vehiculo varchar(50),
		remolque varchar(50),
		pesoNeto int)

		declare curMov insensitive cursor for
		select b.vehiculo,b.remolque,b.pesobruto, tiquete
		from bRegistroBascula b where
		b.item = 1 and
		b.tipo = 'EMP' and
		CONVERT( date,b.fecha ) = @fechaN
		and b.empresa=@empresa
		and b.fechaNeto > dateadd(HOUR,14,convert(datetime,dateadd(day,1,CONVERT(date, b.fechaProceso))))
				
		
	open curMov
	fetch curMov into @vehiculo,@remolque,@pesobruto,@tiquete
	
	while( @@FETCH_STATUS = 0 )
	begin
	
		insert #tabla1 (vehiculo,remolque,pesoTara)
		select top 3 vehiculo, remolque, CASE WHEN tipo in ('EMP','PES') then pesoTara
		else pesoBruto end  from bRegistroBascula
		where vehiculo=@vehiculo and remolque=@remolque
		and fechaProceso<@fechaN and tiquete<>'' and empresa=@empresa
		order by fechaProceso desc 
		
		insert #tabla2 (vehiculo,remolque,pesoNeto,tiquete)
		select vehiculo, remolque, @pesobruto - avg(pesoTara),@tiquete from #tabla1
		where vehiculo=@vehiculo and remolque=@remolque 
		group by vehiculo,remolque
		
	
	
		fetch curMov into @vehiculo,@remolque,@pesobruto,@tiquete
	end
	
	close curMov
	deallocate curMov
	
	insert pFrutaEstimadaTmp
	select @empresa,@fechaN, isnull(sum(pesoNeto),0) from #tabla2

			
	drop table #tabla1
	drop table #tabla2