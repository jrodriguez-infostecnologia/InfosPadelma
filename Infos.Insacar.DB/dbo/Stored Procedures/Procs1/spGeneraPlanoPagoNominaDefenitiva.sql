
CREATE proc [dbo].[spGeneraPlanoPagoNominaDefenitiva]
 @empresa  varchar(50),
 @numero varchar(50),
 @año varchar(50),
 @periodo varchar(50)
 as

declare @tercero varchar(50),@banco varchar(50),@cadena varchar(max),
		@inicio varchar(50), @campo varchar(50),@longitud varchar(50),@valor varchar(50),@mValor bit,@tipo int
		

		create table #plano( datos varchar(max))
		declare curPago insensitive cursor for
		select distinct tercero, codigoBanco from [dbo].[vSeleccionaPagosNomina] a join gFormaPago b on a.formaPago=b.codigo
		where a.empresa=@empresa and noPeriodo=@periodo and año=@año and numero like '%'+@numero+'%'
		and a.anulado=0
		and b.cheque=0
		open curPago			
		fetch curPago into @tercero,@banco
		while( @@fetch_status = 0 )
		begin	
			set @cadena='insert #plano Select '
		declare curPlano insensitive cursor for				
		select  nombreCampo, inicio, longitud, tipoCampo, mValorFijo, valorFijo from nPlanoBancoDetalle
		where empresa=@empresa and banco=@banco
		order by registro asc
		open curPlano			
		fetch curPlano into @campo,@inicio,@longitud,@tipo,@mValor,@valor
		while( @@fetch_status = 0 )
		begin

			set @cadena = @cadena  +  case when @mValor=1 then 
			case when @tipo=1 then  CHAR(39) + RIGHT(replicate('0',@longitud) + Ltrim(Rtrim(@valor)),@longitud) + CHAR(39) 
			else 'convert(char(' + @longitud + '),' + CHAR(39) + @valor +CHAR(39)+ ')' end
			else case when @tipo=1 then  'RIGHT(replicate(' +CHAR(39) + '0' + CHAR(39)+','+@longitud+') + Ltrim(Rtrim(isnull(' + @campo+ ','+char(39)+char(39)+'))),'+@longitud+')' 
			else 'convert(char(' + @longitud + '),isnull(' + @campo+ ','+char(39)+char(39)+'))' end
			end + '+'

		fetch curPlano into @campo,@inicio,@longitud,@tipo,@mValor,@valor
		end
		close curPlano
		deallocate curPlano
		set @cadena = substring(@cadena,1,len(@cadena)-1) + '  from vSeleccionaPago where empresa= ' + @empresa +' and noPeriodo='+@periodo +' and año='+@año +' and anulado=0 and numero like  ' + char(39) + '%'+@numero+'%' + char(39) + ' and tercero ='+ @tercero
		EXECUTE( @cadena )

		fetch curPago into @tercero,@banco
		end
		close curPago
		deallocate curPago

		select distinct * from #plano
		drop table #plano