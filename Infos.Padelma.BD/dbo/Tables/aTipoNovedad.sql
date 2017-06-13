CREATE TABLE [dbo].[aTipoNovedad] (
    [empresa] INT          NOT NULL,
    [tipo]    VARCHAR (50) NOT NULL,
    [novedad] INT          NOT NULL,
    CONSTRAINT [PK_aTipoNovedad] PRIMARY KEY CLUSTERED ([empresa] ASC, [tipo] ASC, [novedad] ASC)
);

