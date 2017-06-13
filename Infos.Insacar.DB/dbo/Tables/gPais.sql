CREATE TABLE [dbo].[gPais] (
    [empresa]     INT           NOT NULL,
    [codigo]      VARCHAR (50)  NOT NULL,
    [descripcion] VARCHAR (150) NOT NULL,
    CONSTRAINT [PK_p_países] PRIMARY KEY CLUSTERED ([empresa] ASC, [codigo] ASC)
);

