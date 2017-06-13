CREATE TABLE [dbo].[nEntidadFondoPension] (
    [empresa]        INT             NOT NULL,
    [codigo]         VARCHAR (50)    NOT NULL,
    [descripcion]    VARCHAR (550)   NOT NULL,
    [tercero]        INT             NULL,
    [proveedor]      VARCHAR (50)    NULL,
    [codigoNacional] VARCHAR (50)    NULL,
    [pEmpleado]      DECIMAL (18, 6) NOT NULL,
    [pEmpleador]     DECIMAL (18, 6) NOT NULL,
    [pInactividad]   DECIMAL (18, 6) NOT NULL,
    [pSolidaridad]   DECIMAL (18, 6) NOT NULL,
    [activo]         BIT             NOT NULL,
    [integral]       BIT             NOT NULL,
    [observacion]    VARCHAR (5550)  NOT NULL,
    [fechaRegistro]  DATETIME        NOT NULL,
    [usuario]        VARCHAR (50)    NOT NULL,
    [cuenta]         VARCHAR (50)    NULL,
    CONSTRAINT [PK_nFondoPension] PRIMARY KEY CLUSTERED ([empresa] ASC, [codigo] ASC),
    CONSTRAINT [FK_nEntidadFondoPension_cTercero] FOREIGN KEY ([empresa], [tercero]) REFERENCES [dbo].[cTercero] ([empresa], [id])
);

