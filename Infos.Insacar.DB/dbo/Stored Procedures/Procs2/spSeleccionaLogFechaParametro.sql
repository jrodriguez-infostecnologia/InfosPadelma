
CREATE PROCEDURE [dbo].[spSeleccionaLogFechaParametro]
	@fechaI		datetime,
	@fechaF		datetime,
	@empresa int
AS
/***************************************************************************
Nombre: spSeleccionaLogFechaParametro
Tipo: Procedimiento Almacenado
Desarrollado: Infos Tecnologia SAS
Fecha: 31/10/2014

Argumentos de entrada: Fecha inicial, fecha final
Argumentos de salida: 
Descripción: Selecciona el log de auditoria por rango de fechas y/o 
			 parámetros de consulta
*****************************************************************************/

	select a.usuario,a.fecha,b.descripcion,a.entidad,a.estado,a.mensajeSistema,a.ip,a.empresa,c.razonSocial
	from dbo.sLogRegistros a,soperaciones b,gEmpresa c
	where
	a.operacion = b.codigo and
	a.empresa=c.id and a.empresa=@empresa and 
	Convert( datetime,Convert( varchar(50),fecha,103 ),103 ) between
		Convert( datetime,Convert( varchar(50),@fechaI,103 ),103 ) and
		Convert( datetime,Convert( varchar(50),@fechaF,103 ),103 )
	order by a.fecha ,a.usuario asc