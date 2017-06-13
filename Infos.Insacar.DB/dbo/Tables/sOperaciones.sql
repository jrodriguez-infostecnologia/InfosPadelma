CREATE TABLE [dbo].[sOperaciones] (
    [codigo]      VARCHAR (50)  NOT NULL,
    [descripcion] VARCHAR (150) NOT NULL,
    [activo]      BIT           CONSTRAINT [DF_sOperaciones_activo] DEFAULT ((0)) NOT NULL,
    CONSTRAINT [PK_operaciones] PRIMARY KEY CLUSTERED ([codigo] ASC)
);

