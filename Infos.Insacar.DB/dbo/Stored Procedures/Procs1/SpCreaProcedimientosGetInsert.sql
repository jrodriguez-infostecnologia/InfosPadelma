
CREATE PROCEDURE [dbo].[SpCreaProcedimientosGetInsert]
	@dBase	varchar(250)
AS
/***************************************************************************
Nombre: SpCreaProcedimientosGetInsert
Tipo: Procedimiento Almacenado
Desarrollado: Infos Tecnologia SAS
Fecha: 24/10/2014

Argumentos de entrada: 
Argumentos de salida: 
Descripción: Crea los procedimientos almacenados de las entidades de datos
			 para la selección e inserción.
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
			@Variable		varchar(256),
			@Campos1	    varchar(500),
			@Campos2		varchar(500),
			@Retorno		varchar(50),
			@Caracter1		char(1),
			@Caracter2		char(1),
			@Id				int,
			@CountTabla		int,
			@Indice			int

	set @Caracter1 = char(39)
	set @Caracter2 = char(64)

	create table #tmp_tablas( indice	int identity(0,1) not null,
							  nombre	varchar(256) null,
							  columna	varchar(256) null,
							  longitud	varchar(256) null )

	create table #tmp_pk( indice	int identity(0,1) not null,
						  nombre	varchar(256) null )

	set @Indice = 0

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

		set @Indice = 0
		set @Variables1 = ''
		set @Campos1 = ''
		set @Variables2 = ''
		set @Campos2 = ''
		set @Variables3 = ''
		set @Variables4 = ''

		insert #tmp_tablas( 
		nombre,
		columna,
		longitud )
		select 
		col.name,
		typ.name,
		col.length
		from syscolumns col,systypes typ
		where 
		col.id = @Id and
		col.xtype = typ.xtype

		select @CountTabla = count(*)
		from #tmp_tablas		

		--Inicio Crea GET's

		set @Encabezado1 = 
		'IF EXISTS (SELECT name FROM sysobjects WHERE  name = N' + @Caracter1 + 'SpGet' + rtrim( @Name ) + 
		@Caracter1 + ' AND type = ' + @Caracter1 + 'P' + @Caracter1 + ') ' + 'DROP PROCEDURE SpGet' + rtrim( @Name )
	
		execute( @Encabezado1 )

		set @Encabezado2 = 
		'CREATE PROCEDURE SpGet' + rtrim( @Name ) + ' AS '

		begin tran actualizaSys
			update sysEntidadMetodos
			set
			metodoGet = 'SpGet' + rtrim( @Name )
			where
			entidad = @Name and
			dBase = @dBase
		if( @@error = 0 )
			commit tran actualizaSys
		else
			rollback tran actualizaSys

		set @Cuerpo1 =  
		'select * from ' + rtrim( @Name ) + ' GO '

		execute( @Encabezado2 + @Cuerpo1 )	

		--Fin Crea GET's

		--Inicio Crea Insert's

		set @Encabezado1 = 
		'IF EXISTS (SELECT name FROM sysobjects WHERE  name = N' + @Caracter1 + 'SpInserta' + rtrim( @Name ) + 
		@Caracter1 + ' AND type = ' + @Caracter1 + 'P' + @Caracter1 + ') ' + 'DROP PROCEDURE SpInserta' 
		+ rtrim( @Name ) 
	
		execute( @Encabezado1 )			

		set @Encabezado2 = 
		'CREATE PROCEDURE SpInserta' + rtrim( @Name ) + ' '	

		begin tran actualizaSys
			update sysEntidadMetodos
			set
			metodoInsert = 'SpInserta' + rtrim( @Name )
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
			@Variable = rtrim( nombre ),
			@Tipo = rtrim( columna ),
			@Longitud = rtrim( longitud )
			from #tmp_tablas
			where
			indice = @Indice 

			if( @Indice <= 16 )
			begin
				select @Variables1 = @Variables1 + @Caracter2 + @Variable + ' ' + @Tipo +
									 case rtrim( @Tipo )
										when 'varchar' then '(' + rtrim( @Longitud ) + ')'
										when 'char' then '(' + rtrim( @Longitud ) + ')'
										else ''
									  end

				select @Campos1 = @Campos1 + rtrim( @Variable )

				select @Variables2 = @Variables2 + @Caracter2 + rtrim( @Variable )		

				if( @Indice < ( @CountTabla - 1 ) and @Indice < 16 )
				begin
					set @Variables1 = @Variables1 + ','
					set @Campos1 = @Campos1 + ','
					set @Variables2 = @Variables2 + ','
				end	
			end
			else
			begin	
				select @Variables3 = @Variables3 + ',' + @Caracter2 + @Variable + ' ' + @Tipo +
									 case rtrim( @Tipo )
										when 'varchar' then '(' + rtrim( @Longitud ) + ')'
										when 'char' then '(' + rtrim( @Longitud ) + ')'
										else ''
									  end

				select @Campos2 = @Campos2 + ',' + rtrim( @Variable )

				select @Variables4 = @Variables4 + ',' + @Caracter2 + rtrim( @Variable )		

			end						
			
			set @Indice = ( @Indice + 1 )
		end

		set @Retorno = ',' + @Caracter2 + 'Retorno int output '
		set @Cuerpo1 = 'begin tran ' + rtrim( @Name ) + ' insert ' + rtrim( @Name ) + '( '
		set @Cuerpo2 = ' if (' + @Caracter2 + @Caracter2 + 'error = 0 ) begin ' +
					   'set ' + @Caracter2 + 'Retorno = 0 ' + 
					   'commit tran ' + rtrim( @Name ) + ' end ' +
					   'else begin set ' + @Caracter2 + 'Retorno = 1 ' + 
					   'rollback tran ' + rtrim( @Name ) + ' end'

		execute( @Encabezado2 + @Variables1 + @Variables3 + @Retorno + ' AS ' + @Cuerpo1 + @Campos1 + 
				 @Campos2 + ' ) ' + 'select ' + @Variables2 + @Variables4 + @Cuerpo2 )

		--Fin Crea Insert's

	fetch cur_objetos into @Name,@Id
	end

	close cur_objetos
	deallocate cur_objetos	

	drop table #tmp_tablas
	drop table #tmp_pk