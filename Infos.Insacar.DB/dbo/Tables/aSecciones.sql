CREATE TABLE [dbo].[aSecciones] (
    [empresa]     INT             NOT NULL,
    [finca]       VARCHAR (50)    NOT NULL,
    [codigo]      VARCHAR (50)    NOT NULL,
    [descripcion] VARCHAR (550)   NOT NULL,
    [hBrutas]     DECIMAL (18, 2) NULL,
    [activo]      BIT             CONSTRAINT [DF_aSecciones_activo] DEFAULT ((0)) NOT NULL,
    CONSTRAINT [PK_aSecciones] PRIMARY KEY CLUSTERED ([empresa] ASC, [finca] ASC, [codigo] ASC),
    CONSTRAINT [FK_aSecciones_aFinca] FOREIGN KEY ([empresa], [finca]) REFERENCES [dbo].[aFinca] ([empresa], [codigo]),
    CONSTRAINT [FK_aSecciones_gEmpresa] FOREIGN KEY ([empresa]) REFERENCES [dbo].[gEmpresa] ([id])
);

