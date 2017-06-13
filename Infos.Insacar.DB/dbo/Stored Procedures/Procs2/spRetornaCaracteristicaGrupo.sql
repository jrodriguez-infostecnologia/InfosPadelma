CREATE proc [dbo].[spRetornaCaracteristicaGrupo]
@gCaracteristica int,
@empresa int
as


select * from acaracteristica
where grupoCaracteristica = @gCaracteristica
and empresa=@empresa