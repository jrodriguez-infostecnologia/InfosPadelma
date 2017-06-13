CREATE proc [dbo].[spSeleccionaCicloCorteAñoMes]
@empresa int,
@año int,
@mes int
as

declare @fecha date = '1/' + convert(varchar, @mes) +'/'+ convert(varchar, @año) ,
@fi date,@ff date,@dia int

set @fi = DATEADD(mm,DATEDIFF(mm,0,@fecha),0)
set @ff = DATEADD(ms,-3,DATEADD(mm,0,DATEADD(mm,DATEDIFF(mm,0,@fecha)+1,0)))

create table #clicos(
lote varchar(50),
racimos float,
dia int,
mes int,
nombreMes varchar(50),
año int,
añoSiembra int
)
while (@fi<=@ff)
begin
		
		set @dia = day(@fi)
		if exists(select lote,sum(b.racimos) racimos,day(b.fecha) dia,MONTH(b.fecha) mes, dbo.fRetornaNombreMes(month(b.fecha)) nombreMes, YEAR(b.fecha) año,c.añoSiembra
		from aTransaccion a
		join aTransaccionNovedad b on b.numero=a.numero and  b.tipo=a.tipo and b.empresa=a.empresa
		join aLotes c on c.codigo=b.lote and c.empresa=b.empresa
		join aNovedad d on d.codigo=b.novedad and d.empresa=b.empresa
		where a.empresa=@empresa and year(b.fecha) =@año and MONTH(b.fecha)=@mes  and d.claseLabor='2' and DAY(b.fecha)=@dia
		group by lote,day(b.fecha),MONTH(b.fecha) , YEAR(b.fecha) ,c.añoSiembra)
		begin
				insert #clicos
				select lote,sum(b.racimos) racimos,day(b.fecha) dia,MONTH(b.fecha) mes, dbo.fRetornaNombreMes(month(b.fecha)) nombreMes, YEAR(b.fecha) año,c.añoSiembra
				from aTransaccion a
				join aTransaccionNovedad b on b.numero=a.numero and  b.tipo=a.tipo and b.empresa=a.empresa
				join aLotes c on c.codigo=b.lote and c.empresa=b.empresa
				join aNovedad d on d.codigo=b.novedad and d.empresa=b.empresa
				where a.empresa=@empresa and year(b.fecha) =@año and MONTH(b.fecha)=@mes  and d.claseLabor='2' and DAY(b.fecha)=@dia
				group by lote,day(b.fecha),MONTH(b.fecha) , YEAR(b.fecha) ,c.añoSiembra

		end
		else
		begin	
			insert #clicos
			select codigo,0 racimos,@dia,@mes, dbo.fRetornaNombreMes(@mes) nombreMes, @año,añoSiembra
			from aLotes 
			where empresa=@empresa
		end
	set @fi = DATEADD(day,1,@fi)
end

select * from #clicos
order by añoSiembra
drop table #clicos