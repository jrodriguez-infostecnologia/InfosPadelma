CREATE proc [dbo].[spSeleccionaBalancePerdidasTipo]
@periodo varchar(6),
@tipo varchar(50),
@empresa int
as

declare @mes varchar(2), @año varchar(4), @fechaTransaccion datetime

set @mes = substring(@periodo,5,len(@periodo))
set @año = substring(@periodo,1,4)

create table #tmpInforme(
jerarquia int,
descripcion varchar(500),
analisis varchar(50),
nombre varchar(500),
orden int,
valor float,
fecha datetime,
resultadoFinal bit,
resultadoParcial bit)
	
 insert #tmpInforme
 select a.jerarquia, d.descripcion, a.analisis,c.descripcion, c.orden,b.valor,b.fecha, a.resultadoFinal, a.resultadoParcial
 from pJerarquiaAnalisis a 
 left join pTransaccionJerarquiaAnalisis b on a.analisis=b.analisis and a.empresa =b.empresa and a.jerarquia =b.jerarquia
 join pTransaccionJerarquia cc on cc.año=b.año and cc.mes=b.mes and cc.numero=b.numero and cc.tipo=b.tipo and cc.anulado=0 and cc.empresa=b.empresa
 left join lAnalisis c on a.analisis = c.codigo  and a.empresa=c.empresa
 left join pJerarquia d on a.jerarquia=d.codigo and d.empresa=a.empresa
 where c.informe=1   and b.tipo =@tipo
 and DATEPART(month,b.fecha)=@mes 
 and DATEPART(year,b.fecha)=@año
 and a.empresa=@empresa
 --order by orden
 insert #tmpInforme
 select distinct a.jerarquia, c.descripcion , a.analisis, d.descripcion, d.orden,null, f.fecha, a.resultadoFinal, a.resultadoParcial  from pJerarquiaAnalisis a
 join lAnalisisItem b on a.analisis=b.analisis  and a.empresa=b.empresa
 join pJerarquia  c on a.jerarquia=c.codigo and a.empresa=b.empresa
 join lAnalisis d on a.analisis=d.codigo and a.empresa=d.empresa ,
 #tmpInforme f
 where 
  b.item in (select producto from gTipoTransaccionProducto c
			where c.tipo = @tipo)
			and a.resultadoFinal=1
			and a.empresa=@empresa

--order by orden


	
	declare cursorLab cursor for 
	select fecha from #tmpInforme

	open  cursorLab
	FETCH NEXT FROM cursorLab
	 INTO @fechaTransaccion


	
	WHILE @@FETCH_STATUS = 0
	BEGIN
	
	update #tmpInforme
	set valor=(	
	select SUM(valor) from #tmpInforme
	where fecha=@fechaTransaccion
	and resultadoParcial=1
	)
	where resultadoFinal=1 and fecha=@fechaTransaccion

	
	FETCH NEXT FROM cursorLab
	 INTO @fechaTransaccion
	end


    CLOSE cursorLab
    DEALLOCATE cursorLab

select * from #tmpInforme
order by analisis
 

drop table #tmpInforme