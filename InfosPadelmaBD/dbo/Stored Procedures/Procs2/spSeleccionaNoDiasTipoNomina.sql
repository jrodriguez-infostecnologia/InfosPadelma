create proc spSeleccionaNoDiasTipoNomina
@empresa int,
@tipoNomina varchar(50),
@retorno int output
as
If (select periocidad from nTipoNomina where empresa=@empresa and codigo=@tipoNomina)='Q'
		set @retorno =15
If (select periocidad from nTipoNomina where empresa=@empresa and codigo=@tipoNomina)='S'
		set @retorno =7
If (select periocidad from nTipoNomina where empresa=@empresa and codigo=@tipoNomina)='D'
		set @retorno =10
If (select periocidad from nTipoNomina where empresa=@empresa and codigo=@tipoNomina)='M'
		set @retorno =30