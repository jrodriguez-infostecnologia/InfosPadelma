create PROCEDURE [dbo].[spSeleccionaProgramacionFuncionariosCuadrilla]
	@cuadrilla	varchar(50),
	@turno		varchar(50),
	@empresa	int,
	@fechaI		datetime,
	@fechaF		datetime
AS
/***************************************************************************
Nombre: spSeleccionaProgramacionFuncionariosCuadrilla
Tipo: Procedimiento Almacenado
Desarrollado: Alirio Noche Arzuza
Fecha: 25/11/2013

Argumentos de entrada: Cuadrilla, turno, fecha inicial, fecha final
Argumentos de salida: 
Descripción: Selecciona la programación de funcionarios por cuadrilla en un 
			 rango de fechas semanal.
*****************************************************************************/

	select distinct b.funcionario,c.descripcion,d.descripcion as cargo,
	case
		when a.funcionario is null then 0
		else 1
	end as programado					
	from nCuadrillaFuncionario b	
	join nFuncionario c on b.funcionario = c.tercero and c.empresa=b.empresa
	join nContratos e on e.tercero=c.tercero and e.empresa=c.empresa and e.activo=1
	join nCargo d on e.cargo = d.codigo and d.empresa=e.empresa
	left join nProgramacion a on a.funcionario=b.funcionario and a.fecha between convert(date,@fechaI) and CONVERT(date, @fechaF) and a.turno = @turno  
	and b.empresa=a.empresa	and a.estado in ('P','E','S')
	where	b.cuadrilla = @cuadrilla and b.empresa=@empresa
	order by c.descripcion