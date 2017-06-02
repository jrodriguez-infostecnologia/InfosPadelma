CREATE TABLE [dbo].[gDiagnostico] (
    [empresa]     INT           NOT NULL,
    [codigo]      VARCHAR (50)  NOT NULL,
    [descripcion] VARCHAR (550) NOT NULL,
    CONSTRAINT [PK_gDiagnostico] PRIMARY KEY CLUSTERED ([empresa] ASC, [codigo] ASC)
);

