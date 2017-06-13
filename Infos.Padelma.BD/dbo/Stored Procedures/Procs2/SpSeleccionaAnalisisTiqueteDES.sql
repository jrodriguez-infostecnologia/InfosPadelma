﻿CREATE PROCEDURE [dbo].[SpSeleccionaAnalisisTiqueteDES] 
@tiquete as varchar(50),
@empresa int
AS
/***************************************************************************
Nombre: SpSeleccionaAnalisisTiqueteDES
Tipo: Procedimiento Almacenado
Desarrollado: Infos Tenologia SAS

Argumentos de entrada: Codigo del Tiquete
Argumentos de salida: 
Descripción: Selecciona Los Analisis para impresión de Tiquete Entrada de materia prima
*****************************************************************************/

	select upper(N.descripcion) as nombre,A.valor,upper( C.descripcion ) as nombreUsuario,A.fecha,n.uMedidaConsumo   uMedida
	from lRegistroAnalisis A
	join iItems N on  A.analisis = N.codigo and a.empresa=n.empresa
	join bRegistroBascula B on A.tipo = B.tipo		  and A.numero = B.numero and a.empresa=b.empresa
	join 	 susuarios C on b.usuario = C.usuario
	where
	a.empresa=@empresa
	and B.tiquete = @tiquete