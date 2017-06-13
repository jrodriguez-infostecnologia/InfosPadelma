CREATE TABLE [dbo].[nTipoNomina] (
    [empresa]       INT            NOT NULL,
    [codigo]        VARCHAR (50)   NOT NULL,
    [descripcion]   VARCHAR (550)  NOT NULL,
    [periocidad]    VARCHAR (50)   NOT NULL,
    [activo]        BIT            NOT NULL,
    [observacion]   VARCHAR (5550) NOT NULL,
    [usuario]       NCHAR (10)     NOT NULL,
    [fechaRegistro] DATETIME       NOT NULL,
    CONSTRAINT [PK_nTipoNomina] PRIMARY KEY CLUSTERED ([empresa] ASC, [codigo] ASC)
);

