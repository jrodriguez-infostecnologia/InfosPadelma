CREATE TABLE [dbo].[nMotivoRetiro] (
    [empresa]       INT            NOT NULL,
    [codigo]        VARCHAR (50)   NOT NULL,
    [descripcion]   VARCHAR (550)  NOT NULL,
    [activo]        BIT            NOT NULL,
    [observacion]   VARCHAR (5550) NOT NULL,
    [usuario]       VARCHAR (50)   NOT NULL,
    [fechaRegistro] DATETIME       NOT NULL,
    CONSTRAINT [PK_nMotivoRetiro] PRIMARY KEY CLUSTERED ([empresa] ASC, [codigo] ASC)
);

