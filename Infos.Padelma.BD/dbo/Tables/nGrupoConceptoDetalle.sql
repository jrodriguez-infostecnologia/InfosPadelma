CREATE TABLE [dbo].[nGrupoConceptoDetalle] (
    [empresa] INT      NOT NULL,
    [grupo]   CHAR (5) NOT NULL,
    [cocepto] CHAR (5) NOT NULL,
    CONSTRAINT [PK_nGrupoConcepto] PRIMARY KEY CLUSTERED ([empresa] ASC, [grupo] ASC, [cocepto] ASC)
);

