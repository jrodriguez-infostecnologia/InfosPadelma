CREATE TABLE [dbo].[nGrupoConcepto] (
    [empresa]     INT            NOT NULL,
    [codigo]      CHAR (5)       NOT NULL,
    [descripcion] VARCHAR (950)  NOT NULL,
    [observacion] VARCHAR (1550) NOT NULL,
    [activo]      BIT            NOT NULL,
    CONSTRAINT [PK_nGrupoConceptod] PRIMARY KEY CLUSTERED ([empresa] ASC, [codigo] ASC)
);

