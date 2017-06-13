CREATE TABLE [dbo].[gDepartamento] (
    [empresa]     INT           NOT NULL,
    [codigo]      VARCHAR (50)  NOT NULL,
    [descripcion] VARCHAR (550) NULL,
    CONSTRAINT [PK_gDepartamento] PRIMARY KEY CLUSTERED ([empresa] ASC, [codigo] ASC)
);

