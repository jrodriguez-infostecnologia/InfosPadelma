CREATE TABLE [dbo].[cGrupoIR] (
    [empresa]     INT            NOT NULL,
    [codigo]      CHAR (5)       NOT NULL,
    [descripcion] VARCHAR (950)  NOT NULL,
    [observacion] VARCHAR (1550) NOT NULL,
    [activo]      BIT            CONSTRAINT [DF_cGrupoIR_activo] DEFAULT ((0)) NOT NULL,
    CONSTRAINT [PK_cGrupoIR] PRIMARY KEY CLUSTERED ([empresa] ASC, [codigo] ASC)
);

