CREATE TABLE [dbo].[nVacacionesDetalle] (
    [empresa]             INT             NOT NULL,
    [periodoInicial]      DATE            NOT NULL,
    [periodoFinal]        DATE            NOT NULL,
    [empleado]            INT             NOT NULL,
    [registro]            INT             NOT NULL,
    [concepto]            VARCHAR (50)    NOT NULL,
    [cantidad]            DECIMAL (18, 3) NULL,
    [porcentaje]          DECIMAL (18, 3) NULL,
    [valorUnitario]       MONEY           NULL,
    [valorTotal]          MONEY           NULL,
    [signo]               INT             NULL,
    [saldo]               MONEY           NULL,
    [noDias]              INT             NULL,
    [baseSeguridadSocial] BIT             NULL,
    [baseEmbargos]        BIT             NULL,
    [entidad]             VARCHAR (50)    NULL,
    [noPrestamo]          VARCHAR (50)    NULL,
    CONSTRAINT [PK_nVacacionesDetalle] PRIMARY KEY CLUSTERED ([empresa] ASC, [periodoInicial] ASC, [periodoFinal] ASC, [empleado] ASC, [registro] ASC, [concepto] ASC),
    CONSTRAINT [FK_nVacacionesDetalle_cTercero] FOREIGN KEY ([empresa], [empleado]) REFERENCES [dbo].[cTercero] ([empresa], [id]),
    CONSTRAINT [FK_nVacacionesDetalle_nConcepto] FOREIGN KEY ([empresa], [concepto]) REFERENCES [dbo].[nConcepto] ([empresa], [codigo]),
    CONSTRAINT [FK_nVacacionesDetalle_nVacaciones] FOREIGN KEY ([empresa], [periodoInicial], [periodoFinal], [empleado], [registro]) REFERENCES [dbo].[nVacaciones] ([empresa], [periodoInicial], [periodoFinal], [empleado], [registro])
);

