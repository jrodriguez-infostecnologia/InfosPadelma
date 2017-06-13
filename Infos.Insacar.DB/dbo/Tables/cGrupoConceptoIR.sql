CREATE TABLE [dbo].[cGrupoConceptoIR] (
    [empresa] INT      NOT NULL,
    [grupo]   CHAR (5) NOT NULL,
    [cocepto] CHAR (5) NOT NULL,
    CONSTRAINT [PK_cGrupoConcepto] PRIMARY KEY CLUSTERED ([empresa] ASC, [grupo] ASC, [cocepto] ASC)
);

