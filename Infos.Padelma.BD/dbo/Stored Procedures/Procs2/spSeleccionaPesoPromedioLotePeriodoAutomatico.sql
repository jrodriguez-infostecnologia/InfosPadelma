CREATE proc [dbo].[spSeleccionaPesoPromedioLotePeriodoAutomatico]
@empresa int,
@año int,
@mes int
as

declare @fruta decimal(18,3), @racimos decimal(18,3), @valor decimal(18,3),@fi date, @ff date,
@fip date, @ffp date, @lote varchar(50),@finca varchar(50),@seccion varchar(50)

	select @fi=fechaInicial,@ff=fechaFinal  from cPeriodo 
	where empresa=@empresa and año= case when @mes=12 then @año+1 else @año end and mes= case when @mes=12  then 1 else (@mes+1) end 
	select @fip=fechaInicial,@ffp=fechaFinal  from cPeriodo where empresa=@empresa and año=@año and mes=@mes

	--select @fi,@ff,@fip,@ffp
	declare curLotes insensitive cursor for
	select codigo, finca,seccion  from aLotes 
	where empresa=@empresa and activo=1 --and seccion is not null
	open curLotes
	fetch curLotes into @lote,@finca,@seccion
	while( @@fetch_status = 0 )
	begin
		
		select @fruta= SUM(isnull(a.cantidad,0)), @racimos=sum(isnull(a.racimos,0)) from aTransaccion c 
		join aTransaccionNovedad a on a.tipo=c.tipo and a.numero=c.numero and a.empresa=c.empresa
		join aNovedad b on b.codigo=a.novedad and b.empresa=a.empresa 
		where lote=@lote and b.claseLabor=2 and c.anulado=0
		and a.fecha between @fip and @ffp and a.empresa=@empresa 
	
		if @racimos=0 or @fruta is null
			set @valor=0
		else
			set @valor=   round(@fruta/@racimos,2)

			--select @seccion
		if exists(select * from aLotePesosPeriodo where lote=@lote 
		and empresa=@empresa and año=@año and mes=@mes and finca=@finca )--and seccion in (@seccion,null))
		begin
			update aLotePesosPeriodo set
			pesoRacimo =@valor,
			fechaInicial= @fi,
			fechaFinal=@ff,
			automatico=1
			where lote=@lote and empresa=@empresa 
			and año=@año and mes=@mes
			and finca=@finca --and seccion=@seccion
		end
		else
		begin
			insert aLotePesosPeriodo
			select @empresa, @año,@mes,@finca,@seccion,@lote,@valor,1,@fi,@ff
		end
	fetch curLotes into @lote,@finca,@seccion
	end
	close curLotes
	deallocate curLotes