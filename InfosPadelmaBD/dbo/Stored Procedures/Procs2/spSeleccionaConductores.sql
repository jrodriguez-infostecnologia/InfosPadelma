CREATE proc [dbo].[spSeleccionaConductores]
@empresa int
as

create table #Funcionario(
codigo varchar(50), descripcion varchar(550))

insert #Funcionario
select codigo , descripcion from nFuncionario 
where activo=1 and conductor=1 and empresa=@empresa

--insert #Funcionario
--select codigo ,descripcion from nFuncionarioContratista 
--where activo=1 and conductor=1 and empresa=@empresa

select * from #Funcionario

drop table #Funcionario