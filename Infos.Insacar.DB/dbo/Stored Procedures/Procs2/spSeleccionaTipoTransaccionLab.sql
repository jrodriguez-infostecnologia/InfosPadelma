
CREATE proc [dbo].[spSeleccionaTipoTransaccionLab]
@empresa int
as
select * from gTipoTransaccion
where modulo='labor' and empresa=@empresa