CREATE TABLE [dbo].[nEntidadCaja] (
    [empresa]        INT             NOT NULL,
    [codigo]         VARCHAR (50)    NOT NULL,
    [descripcion]    VARCHAR (550)   NOT NULL,
    [tercero]        INT             NULL,
    [proveedor]      VARCHAR (50)    NULL,
    [codigoNacional] VARCHAR (50)    NULL,
    [pais]           VARCHAR (50)    NULL,
    [ciudad]         VARCHAR (50)    NULL,
    [pAporte]        DECIMAL (18, 6) NOT NULL,
    [integral]       BIT             NOT NULL,
    [observacion]    VARCHAR (5550)  NOT NULL,
    [activo]         BIT             NOT NULL,
    [fechaRegistro]  DATETIME        NOT NULL,
    [usuario]        VARCHAR (50)    NOT NULL,
    [cuenta]         VARCHAR (50)    NULL,
    CONSTRAINT [PK_nCaja] PRIMARY KEY CLUSTERED ([empresa] ASC, [codigo] ASC)
);

