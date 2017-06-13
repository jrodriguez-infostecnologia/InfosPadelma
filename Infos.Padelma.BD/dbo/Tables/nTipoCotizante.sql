CREATE TABLE [dbo].[nTipoCotizante] (
    [empresa]       INT            NOT NULL,
    [codigo]        VARCHAR (50)   NOT NULL,
    [descripcion]   VARCHAR (550)  NOT NULL,
    [observacion]   VARCHAR (5550) NOT NULL,
    [activo]        BIT            NOT NULL,
    [fechaRegistro] DATETIME       NOT NULL,
    [usuario]       VARCHAR (50)   NOT NULL,
    CONSTRAINT [PK_nTipoCotizante] PRIMARY KEY CLUSTERED ([empresa] ASC, [codigo] ASC)
);

