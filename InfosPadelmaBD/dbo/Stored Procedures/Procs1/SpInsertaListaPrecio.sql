CREATE PROCEDURE [dbo].[SpInsertaListaPrecio] 
@empresa int,
@novedad int,
@registro int,
@precioTerceros money,
@precioContratistas money,
@fechaRegistro datetime,
@modificado bit,
@finca varchar(50),
@usuario varchar(50),
@lote char(10),
@sesion char(10),
@retorno int output
 AS begin tran aNovedad


set @registro = (select max(registro)+1 from aNovedadLotePrecio)

if @registro is null
set @registro = 1

if(exists( select * from aNovedadLotePrecio where empresa=@empresa and novedad=@novedad and finca=@finca
		   and lote like '%'+@lote+'%' and sesion like '%'+@sesion+'%'))
		   begin
		    update aNovedadLotePrecio
				set modificado=1
				 where
				novedad=@novedad and finca=@finca and lote like '%'+@lote+'%' and sesion like '%'+@sesion+'%'
			
				insert aNovedadLotePrecio( empresa,novedad,registro,precioTerceros,precioContratistas,fechaRegistro,modificado,finca,usuario,lote,sesion ) 
				select @empresa,@novedad,@registro,@precioTerceros,@precioContratistas,@fechaRegistro,@modificado,@finca,@usuario,@lote,@sesion
		   end
		   else
		   begin
				insert aNovedadLotePrecio( empresa,novedad,registro,precioTerceros,precioContratistas,fechaRegistro,modificado,finca,usuario,lote,sesion ) 
				select @empresa,@novedad,@registro,@precioTerceros,@precioContratistas,@fechaRegistro,@modificado,@finca,@usuario,@lote,@sesion
		    end
					   




	
--	if exists(select * from aNovedadLotePrecio 
--	where novedad=@novedad and finca=@finca and @sesion is null and @lote is null)
--	begin
--				update aNovedadLotePrecio
--				set modificado=1
--				 where
--				novedad=@novedad and finca=@finca and @sesion is null and @lote is null
				
--				insert aNovedadLotePrecio( empresa,registro,precio,fechaRegistro,modificado,finca,novedad,lote,usuario,sesion ) 
--				select @empresa,@registro,@precio,@fechaRegistro,@modificado,@finca,@novedad,@lote,@usuario,@sesion 
--	end


--	if exists (select * from aNovedadLotePrecio where novedad=@novedad and finca=@finca and sesion=@sesion and @lote is null)
--	begin		
--		update aNovedadLotePrecio
--			set modificado=1
--			where novedad=@novedad and finca=@finca and sesion=@sesion and @lote is null
			

--	insert aNovedadLotePrecio( empresa,registro,precio,fechaRegistro,modificado,finca,novedad,lote,usuario,sesion ) 
--	select @empresa,@registro,@precio,@fechaRegistro,@modificado,@finca,@novedad,@lote,@usuario,@sesion
--	end

--if exists (select * from aNovedadLotePrecio 
--where novedad=@novedad and finca=@finca and sesion=@sesion and lote=@lote
--	)
--	begin
--			update aNovedadLotePrecio
--			set modificado=1
--			where novedad=@novedad and finca=@finca and sesion=@sesion and lote =@lote
			
--	insert aNovedadLotePrecio( empresa,registro,precio,fechaRegistro,modificado,finca,novedad,lote,usuario,sesion ) 
--	select @empresa,@registro,@precio,@fechaRegistro,@modificado,@finca,@novedad,@lote,@usuario,@sesion
				
--	end
	
--if exists (select * from aNovedadLotePrecio 
--where novedad=@novedad and finca=@finca and @sesion is null and lote=@lote
--	)
--	begin
--			update aNovedadLotePrecio
--			set modificado=1
--			where novedad=@novedad and finca=@finca and @sesion is null and lote =@lote
						
--			insert aNovedadLotePrecio( empresa,registro,precio,fechaRegistro,modificado,finca,novedad,lote,usuario,sesion ) 
--			select @empresa,@registro,@precio,@fechaRegistro,@modificado,@finca,@novedad,@lote,@usuario,@sesion 

--	end

--else 
--begin
--insert aNovedadLotePrecio( empresa,registro,precio,fechaRegistro,modificado,finca,novedad,lote,usuario,sesion ) 
--select @empresa,@registro,@precio,@fechaRegistro,@modificado,@finca,@novedad,@lote,@usuario,@sesion 
--end

if (@@error = 0 ) begin set @Retorno = 0 commit tran aNovedad end else begin set @Retorno = 1 rollback tran aNovedad end