CREATE proc [dbo].[spRetornaDatosEmbargos]
@empresa int,
@empleado int,
@codigo varchar(50),
@tipo varchar(50)

as



select nEmbargos.*, nFuncionario.codigo codEmpleado, nFuncionario.descripcion desempleado,gTipoEmbargo.codigo codEmbargo,gTipoEmbargo.descripcion embargo   
  from nEmbargos join nFuncionario     on nFuncionario.tercero = nEmbargos.empleado  and nEmbargos.empresa= nFuncionario.empresa
  join gTipoEmbargo on gTipoEmbargo.codigo=nEmbargos.tipo  
  where nEmbargos.empresa=@empresa and nEmbargos.empleado=@empleado and nEmbargos.codigo=@codigo
  and nEmbargos.tipo=@tipo