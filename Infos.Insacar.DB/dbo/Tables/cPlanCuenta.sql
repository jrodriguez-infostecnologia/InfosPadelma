CREATE TABLE [dbo].[cPlanCuenta] (
    [empresa]     INT           NOT NULL,
    [codigo]      VARCHAR (50)  NOT NULL,
    [descripcion] VARCHAR (550) NOT NULL,
    [activo]      BIT           NOT NULL,
    CONSTRAINT [PK_cPlanCuenta] PRIMARY KEY CLUSTERED ([empresa] ASC, [codigo] ASC)
);

