CREATE TABLE [dbo].[nSubTipoCotizante] (
    [empresa]       INT            NOT NULL,
    [codigo]        VARCHAR (50)   NOT NULL,
    [tipoCotizante] VARCHAR (50)   NOT NULL,
    [descripcion]   VARCHAR (550)  NOT NULL,
    [observacion]   VARCHAR (5550) NOT NULL,
    [activo]        BIT            NOT NULL,
    [fechaRegistro] DATETIME       NOT NULL,
    [usuario]       VARCHAR (50)   NOT NULL,
    CONSTRAINT [PK_nSubTipoCotizante] PRIMARY KEY CLUSTERED ([empresa] ASC, [codigo] ASC)
);

