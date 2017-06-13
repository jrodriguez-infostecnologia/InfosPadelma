CREATE TABLE [dbo].[cEstructuraCCosto] (
    [empresa]     INT           NOT NULL,
    [nivel]       INT           NOT NULL,
    [inicio]      INT           NOT NULL,
    [tamaño]      INT           NOT NULL,
    [total]       INT           NOT NULL,
    [descripcion] VARCHAR (550) NOT NULL,
    [activo]      BIT           NOT NULL,
    CONSTRAINT [PK_cEstructuraCCosto] PRIMARY KEY CLUSTERED ([empresa] ASC, [nivel] ASC)
);

