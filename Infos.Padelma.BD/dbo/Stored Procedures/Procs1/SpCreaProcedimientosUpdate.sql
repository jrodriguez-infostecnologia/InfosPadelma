
CREATE PROCEDURE [dbo].[SpCreaProcedimientosUpdate]
	@dBase	varchar(250)
AS
/***************************************************************************
Nombre: SpCreaProcedimientosUpdate
Tipo: Procedimiento Almacenado
Desarrollado: Infos Tecnologia SAS
Fecha: 24/10/2014

Argumentos de entrada: 
Argumentos de salida: 
Descripción: Crea los procedimientos almacenados de las entidades de datos
			 para la actualizacion.
*****************************************************************************/	

	declare @Name			varchar(256),
			@Tipo			varchar(256),
			@Longitud		varchar(256),
			@Encabezado1	varchar(256),
			@Encabezado2	varchar(256),
			@Cuerpo1		varchar(256),
			@Cuerpo2		varchar(256),
			@Variables1		varchar(1000),
			@Variables2		varchar(1000),
			@Variables3		varchar(1000),
			@Variables4		varchar(1000),
			@Variables5		varchar(1000),
			@Variables6		varchar(1000),
			@Variables7		varchar(1000),
			@Variables8		varchar(1000),
			@Keys1			varchar(1000),
			@Keys2			varchar(1000),
			@Variable		varchar(256),
			@Campos1	    varchar(1000),
			@Campos2		varchar(1000),
			@Campos3		varchar(1000),
			@Campos4		varchar(1000),
			@Campos5		varchar(1000),
			@Campos6		varchar(1000),
			@Campos7		varchar(1000),
			@Retorno		varchar(50),
			@Caracter1		char(1),
			@Caracter2		char(1),
			@Id				int,
			@CountTabla		int,
			@Indice			int,
			@CountPk		int

	set @Caracter1 = char(39)
	set @Caracter2 = char(64)

	create table #tmp_tablas( indice	int identity(0,1) not null,
							  nombre	varchar(256) null,
							  columna	varchar(256) null,
							  longitud	varchar(256) null )

	create table #tmp_pk( indice	int identity(0,1) not null,
						  nombre	varchar(256) null )

	declare cur_objetos insensitive cursor for 
	select name,id from sysobjects
	where 
	type = 'U' and
	name <> 'dtproperties'
	order by name

	open cur_objetos
	fetch cur_objetos into @Name,@Id

	while( @@fetch_status = 0 )
	begin
		truncate table #tmp_tablas
		truncate table #tmp_pk

		set @Indice = 0
		set @Variables1 = ''
		set @Campos1 = ''
		set @Variables2 = ''
		set @Campos2 = ''
		set @Campos3 = ''
		set @Campos4 = ''
		set @Campos5 = ''
		set @Campos6 = ''
		set @Campos7 = ''
		set @Variables3 = ''
		set @Variables4 = ''
		set @Variables5 = ''
		set @Variables6 = ''
		set @Variables7 = ''
		set @Variables8 = ''
		set @Keys1 = ''
		set @Keys2 = ''

		insert #tmp_tablas( 
		nombre,
		columna,
		longitud )
		select 
		col.name,
		typ.name,
		col.length
		from syscolumns col,systypes typ,sysobjects obj
		where 
		col.id = obj.id and
		col.xtype = typ.xtype and
		col.id = @Id and
		obj.name = @Name		
		order by obj.name

		insert #tmp_pk( 
		nombre )
		select
		col.name
		from syscolumns col,sysobjects obj,sysindexkeys ind
		where
		col.id = obj.id and
		obj.type = 'U' and
		col.id = ind.id and
		col.colid = ind.colid and
		obj.name = @Name	
		order by obj.name			

		select @CountTabla = count(*)
		from #tmp_tablas	

		select @CountPk = count(*)
		from #tmp_pk	

		--Inicio Crea Update's

		set @Encabezado1 = 
		'IF EXISTS (SELECT name FROM sysobjects WHERE  name = N' + @Caracter1 + 'SpActualiza' + rtrim( @Name ) + 
		@Caracter1 + ' AND type = ' + @Caracter1 + 'P' + @Caracter1 + ') ' + 'DROP PROCEDURE SpActualiza' 
		+ rtrim( @Name ) 
	
		execute( @Encabezado1 )			

		set @Encabezado2 = 
		'CREATE PROCEDURE SpActualiza' + rtrim( @Name ) + ' '	

		begin tran actualizaSys
			update sysEntidadMetodos
			set
			metodoUpdate = 'SpActualiza' + rtrim( @Name )
			where
			entidad = @Name and
			dBase = @dBase
		if( @@error = 0 )
			commit tran actualizaSys
		else
			rollback tran actualizaSys

		while( @CountTabla > @Indice )
		begin		
			select 
			@Variable = rtrim( tab.nombre ),
			@Tipo = rtrim( tab.columna ),
			@Longitud = rtrim( tab.longitud )
			from #tmp_tablas tab
			where
			tab.indice = @Indice 

			if( @Indice <= 5 )
			begin
				select @Variables1 = @Variables1 + @Caracter2 + @Variable + ' ' + @Tipo +
									 case rtrim( @Tipo )
										when 'varchar' then '(' + rtrim( @Longitud ) + ')'
										when 'char' then '(' + rtrim( @Longitud ) + ')'
										else ''
									  end

				if( not exists( select nombre from #tmp_pk where nombre = @Variable ) )
				begin
					if( @Indice = 0 or @Campos1 = '' )
					begin
						select @Campos1 = @Campos1 + rtrim( @Variable ) + ' = ' +	
						@Caracter2 + rtrim( @Variable )		
					end
					else
					begin
						select @Campos1 = @Campos1 + ',' + rtrim( @Variable ) + ' = ' +	
						@Caracter2 + rtrim( @Variable )		
					end
				end

				if( @Indice < ( @CountTabla - 1 ) and @Indice < 5 )
				begin
					set @Variables1 = @Variables1 + ','											
				end	
			end											
			else
			begin
				if( @Indice between 6 and 10 )
				begin
					select @Variables3 = @Variables3 + ',' + @Caracter2 + @Variable + ' ' + @Tipo +
										 case rtrim( @Tipo )
											when 'varchar' then '(' + rtrim( @Longitud ) + ')'
											when 'char' then '(' + rtrim( @Longitud ) + ')'
											else ''
										  end

					if( not exists( select nombre from #tmp_pk where nombre = @Variable ) )
					begin
						select @Campos2 = @Campos2 + ',' + rtrim( @Variable ) + ' = ' +	
						@Caracter2 + rtrim( @Variable )					
					end
				end
				else
				begin
					if( @Indice between 11 and 15 )
					begin
						select @Variables4 = @Variables4 + ',' + @Caracter2 + @Variable + ' ' + @Tipo +
											 case rtrim( @Tipo )
												when 'varchar' then '(' + rtrim( @Longitud ) + ')'
												when 'char' then '(' + rtrim( @Longitud ) + ')'
												else ''
											  end

						if( not exists( select nombre from #tmp_pk where nombre = @Variable ) )
						begin
							select @Campos3 = @Campos3 + ',' + rtrim( @Variable ) + ' = ' +	
							@Caracter2 + rtrim( @Variable )					
						end
					end
					else
					begin
						if( @Indice between 16 and 20 )
						begin
							select @Variables5 = @Variables5 + ',' + @Caracter2 + @Variable + ' ' + @Tipo +
												 case rtrim( @Tipo )
													when 'varchar' then '(' + rtrim( @Longitud ) + ')'
													when 'char' then '(' + rtrim( @Longitud ) + ')'
													else ''
												  end

							if( not exists( select nombre from #tmp_pk where nombre = @Variable ) )
							begin
								select @Campos4 = @Campos4 + ',' + rtrim( @Variable ) + ' = ' +	
								@Caracter2 + rtrim( @Variable )					
							end
						end
						else
						begin
							if( @Indice between 21 and 25 )
							begin
								select @Variables6 = @Variables6 + ',' + @Caracter2 + @Variable + ' ' + @Tipo +
													 case rtrim( @Tipo )
														when 'varchar' then '(' + rtrim( @Longitud ) + ')'
														when 'char' then '(' + rtrim( @Longitud ) + ')'
														else ''
													  end

								if( not exists( select nombre from #tmp_pk where nombre = @Variable ) )
								begin
									select @Campos5 = @Campos5 + ',' + rtrim( @Variable ) + ' = ' +	
									@Caracter2 + rtrim( @Variable )					
								end
							end
							else
							begin
								if( @Indice between 26 and 30 )
								begin
									select @Variables7 = @Variables7 + ',' + @Caracter2 + @Variable + ' ' + @Tipo +
														 case rtrim( @Tipo )
															when 'varchar' then '(' + rtrim( @Longitud ) + ')'
															when 'char' then '(' + rtrim( @Longitud ) + ')'
															else ''
														  end

									if( not exists( select nombre from #tmp_pk where nombre = @Variable ) )
									begin
										select @Campos6 = @Campos6 + ',' + rtrim( @Variable ) + ' = ' +	
										@Caracter2 + rtrim( @Variable )					
									end
								end
								else
								begin
									if( @Indice between 27 and 31 )
									begin
										select @Variables8 = @Variables8 + ',' + @Caracter2 + @Variable + ' ' + @Tipo +
															 case rtrim( @Tipo )
																when 'varchar' then '(' + rtrim( @Longitud ) + ')'
																when 'char' then '(' + rtrim( @Longitud ) + ')'
																else ''
															  end

										if( not exists( select nombre from #tmp_pk where nombre = @Variable ) )
										begin
											select @Campos7 = @Campos7 + ',' + rtrim( @Variable ) + ' = ' +	
											@Caracter2 + rtrim( @Variable )					
										end
									end
								end
							end
						end
					end
				end
			end
			
		set @Indice = ( @Indice + 1 )
		end

		select @CountTabla = count(*)
		from #tmp_pk
		set @Indice = 0

		while( @CountTabla > @Indice )
		begin
			select 
			@Variable = rtrim( nombre )			
			from #tmp_pk
			where
			indice = @Indice

			select @Keys1 = @Keys1 + @Variable + ' = ' + @Caracter2 + @Variable

			if( @Indice < ( @CountPk - 1 ) )
			begin
				set @Keys1 = @Keys1 + ' and '
			end			

		set @Indice = ( @Indice + 1 )
		end

		set @Retorno = ',' + @Caracter2 + 'Retorno int output '
		set @Cuerpo1 = 'begin tran ' + rtrim( @Name ) + ' update ' + rtrim( @Name ) + ' set '
		set @Cuerpo2 = ' if (' + @Caracter2 + @Caracter2 + 'error = 0 ) begin ' +
					   'set ' + @Caracter2 + 'Retorno = 0 ' + 
					   'commit tran ' + rtrim( @Name ) + ' end ' +
					   'else begin set ' + @Caracter2 + 'Retorno = 1 ' + 
					   'rollback tran ' + rtrim( @Name ) + ' end'

		execute( @Encabezado2 + @Variables1 + @Variables3 + @Variables4 + @Variables5 + @Variables6 + @Variables7 + 
			   @Variables8 + @Retorno + ' AS ' + @Cuerpo1 + @Campos1 + @Campos2 + @Campos3 + @Campos4 + 
			   @Campos5 + @Campos6 + @Campos7 + @Variables2 +  ' where ' + @Keys1 + @Keys2 + @Cuerpo2 )

		--Fin Crea Update's

	fetch cur_objetos into @Name,@Id
	end

	close cur_objetos
	deallocate cur_objetos	

	drop table #tmp_tablas	
	drop table #tmp_pk