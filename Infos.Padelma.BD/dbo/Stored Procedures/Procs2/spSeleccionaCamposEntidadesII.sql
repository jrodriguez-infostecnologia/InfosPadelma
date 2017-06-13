
CREATE PROCEDURE [dbo].[spSeleccionaCamposEntidadesII]
	@id1 varchar(256),
	@id2 varchar(256)
AS
/***************************************************************************
Nombre: spSeleccionaCamposEntidadesII
Tipo: Procedimiento Almacenado
Desarrollado: Infos Tecnologia SAS

Argumentos de entrada: Identificación de la entidad
Argumentos de salida: 
Descripción: Selecciona los campos de las entidades de la base de datos
*****************************************************************************/

	select b.name 
	from sysobjects a,syscolumns b
	where
	a.id = b.id and
	--a.type = 'U' and
	a.name = @id1
	and b.name<>''

	union

	select b.name 
	from sysobjects a,syscolumns b
	where
	a.id = b.id and
	--a.type = 'U' and
	a.name = @id2
	and b.name<>''
	order by b.name