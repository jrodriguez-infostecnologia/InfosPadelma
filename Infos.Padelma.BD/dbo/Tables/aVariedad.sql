CREATE TABLE [dbo].[aVariedad] (
    [empresa]     INT           NOT NULL,
    [codigo]      CHAR (5)      NOT NULL,
    [descripcion] VARCHAR (550) NOT NULL,
    [procedencia] VARCHAR (550) NOT NULL,
    [activo]      BIT           CONSTRAINT [DF_aVariedad_activo] DEFAULT ((0)) NOT NULL,
    CONSTRAINT [PK_aVariedad] PRIMARY KEY CLUSTERED ([empresa] ASC, [codigo] ASC),
    CONSTRAINT [FK_aVariedad_gEmpresa] FOREIGN KEY ([empresa]) REFERENCES [dbo].[gEmpresa] ([id])
);

