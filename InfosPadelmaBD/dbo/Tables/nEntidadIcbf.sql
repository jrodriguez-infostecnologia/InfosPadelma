CREATE TABLE [dbo].[nEntidadIcbf] (
    [empresa]        INT             NOT NULL,
    [codigo]         VARCHAR (50)    NOT NULL,
    [descripcion]    VARCHAR (550)   NOT NULL,
    [tercero]        INT             NOT NULL,
    [proveedor]      VARCHAR (50)    NOT NULL,
    [codigoNacional] VARCHAR (50)    NULL,
    [pais]           VARCHAR (10)    NULL,
    [ciudad]         VARCHAR (10)    NULL,
    [pAporte]        DECIMAL (18, 6) NOT NULL,
    [observacion]    VARCHAR (5550)  NOT NULL,
    [integral]       BIT             NOT NULL,
    [activo]         BIT             NOT NULL,
    [fechaRegistro]  DATETIME        NOT NULL,
    [usuario]        VARCHAR (50)    NOT NULL,
    [cuenta]         VARCHAR (50)    NULL,
    CONSTRAINT [PK_nEntidadIcbf] PRIMARY KEY CLUSTERED ([empresa] ASC, [codigo] ASC),
    CONSTRAINT [FK_nEntidadIcbf_cTercero] FOREIGN KEY ([empresa], [tercero]) REFERENCES [dbo].[cTercero] ([empresa], [id])
);

