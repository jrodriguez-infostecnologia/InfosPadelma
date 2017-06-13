create proc spSeleccionaDetallePlanoBanco
@empresa int,
@banco varchar(50)
as



select * from nPlanoBancoDetalle
where empresa=@empresa and banco=@banco