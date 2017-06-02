
create PROCEDURE [dbo].[spSysObtenerParametros]
	@name varchar(250),
	@type int
AS
/***************************************************************************
Nombre: spSysObtenerParametros
Tipo: Procedimiento Almacenado
Desarrollado: Ricardo A. Matíz Gómez
Fecha: 23/01/2010
*****************************************************************************/

	select obj.name,par.name,typ.name,par.max_length,par.is_output 
	from sys.parameters par,sysobjects obj,systypes typ
	where
	par.object_id = obj.id and
	typ.xtype = par.system_type_id and
	obj.name = @name and
	is_output = @type
	order by par.name