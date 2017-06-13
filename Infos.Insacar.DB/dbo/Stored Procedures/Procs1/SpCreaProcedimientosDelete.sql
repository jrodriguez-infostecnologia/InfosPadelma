
CREATE PROCEDURE [dbo].[SpCreaProcedimientosDelete]
	@dBase	varchar(256)
AS
/***************************************************************************
Nombre: SpCreaProcedimientosDelete
Tipo: Procedimiento Almacenado
Desarrollado: Infos Tecnologia SAS
Fecha: 24/10/2014

Argumentos de entrada: 
Argumentos de salida: 
Descripción: Crea los procedimientos almacenados de las entidades de datos
			 para la eliminación.
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
			@Indice1		int,
			@CountPk		int

	set @Caracter1 = char(39)
	set @Caracter2 = char(64)

	begin tran borraSys
		delete sysEntidadMetodos
		where
		dBase = @dBase
	if( @@error = 0 )
		commit tran borraSys
	else
		rollback tran borraSys

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
		set @Indice1 = 0
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

		--Inicio Crea Delete's

		set @Encabezado1 = 
		'IF EXISTS (SELECT name FROM sysobjects WHERE  name = N' + @Caracter1 + 'SpDelete' + rtrim( @Name ) + 
		@Caracter1 + ' AND type = ' + @Caracter1 + 'P' + @Caracter1 + ') ' + 'DROP PROCEDURE SpDelete' 
		+ rtrim( @Name ) 
	
		execute( @Encabezado1 )			

		set @Encabezado2 = 
		'CREATE PROCEDURE SpDelete' + rtrim( @Name ) + ' '	

		begin tran insertaSys
			insert sysEntidadMetodos(
			entidad,
			dbase,
			metodoGet,
			metodoInsert,
			metodoUpdate,
			metodoDelete )
			select
			rtrim( @name ),
			@dBase,
			null,
			null,
			null,
			'spDelete' + rtrim( @Name )
		if( @@error = 0 )
			commit tran insertaSys
		else
			rollback tran insertaSys

		while( @CountTabla > @Indice )
		begin				

			if( exists( select a.nombre from #tmp_tablas a,#tmp_pk b 
						where 
						a.indice = @Indice and 
						a.nombre = b.nombre ) )
			begin	
				select @Variables1 = @Variables1 + @Caracter2 + a.nombre + ' ' + columna +
				case rtrim( columna )
					when 'varchar' then '(' + rtrim( longitud ) + ')'
					when 'char' then '(' + rtrim( longitud ) + ')'
					else ''
				end + ','
				from #tmp_tablas a,#tmp_pk b
				where
				a.indice = @Indice and
				a.nombre = b.nombre

				set @Indice1 = @Indice1 + 1
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

		set @Retorno = @Caracter2 + 'Retorno int output '
		set @Cuerpo1 = 'begin tran ' + rtrim( @Name ) + ' delete ' + rtrim( @Name )
		set @Cuerpo2 = ' if (' + @Caracter2 + @Caracter2 + 'error = 0 ) begin ' +
					   'set ' + @Caracter2 + 'Retorno = 0 ' + 
					   'commit tran ' + rtrim( @Name ) + ' end ' +
					   'else begin set ' + @Caracter2 + 'Retorno = 1 ' + 
					   'rollback tran ' + rtrim( @Name ) + ' end'

		execute( @Encabezado2 + @Variables1 + @Retorno + ' AS ' + @Cuerpo1 + @Campos1 + @Campos2 + @Campos3 + @Campos4 + 
			   @Campos5 + @Campos6 + @Campos7 + @Variables2 +  ' where ' + @Keys1 + @Keys2 + @Cuerpo2 )

		--Fin Crea Delete's

	fetch cur_objetos into @Name,@Id
	end

	close cur_objetos
	deallocate cur_objetos	

	drop table #tmp_tablas	
	drop table #tmp_pk