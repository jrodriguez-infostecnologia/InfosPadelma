CREATE TABLE [dbo].[gClaseCuenta] (
    [empresa]     INT           NOT NULL,
    [codigo]      VARCHAR (50)  NOT NULL,
    [descripcion] VARCHAR (350) NOT NULL,
    CONSTRAINT [PK_gClaseCuenta] PRIMARY KEY CLUSTERED ([empresa] ASC, [codigo] ASC)
);

