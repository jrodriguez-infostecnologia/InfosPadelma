CREATE TABLE [dbo].[pProductoMovimiento] (
    [empresa]    INT           NOT NULL,
    [producto]   VARCHAR (50)  NOT NULL,
    [movimiento] VARCHAR (50)  NOT NULL,
    [formula]    VARCHAR (950) NOT NULL,
    [prioridad]  INT           CONSTRAINT [DF_pProductoMovimientos_prioridad] DEFAULT ((0)) NOT NULL,
    [orden]      INT           NOT NULL,
    [resultado]  BIT           NOT NULL,
    [almacena]   BIT           CONSTRAINT [DF_pProductoMovimientos_campoResultado] DEFAULT ((0)) NOT NULL,
    [mCalcular]  BIT           CONSTRAINT [DF_pProductoMovimientos_mostrar] DEFAULT ((0)) NOT NULL,
    [mDecimal]   BIT           CONSTRAINT [DF_pProductoMovimientos_decimal] DEFAULT ((0)) NOT NULL,
    [mInforme]   BIT           CONSTRAINT [DF_pProductoMovimientos_mInforme] DEFAULT ((0)) NOT NULL,
    [activo]     BIT           CONSTRAINT [DF_pProductoMovimiento_activo] DEFAULT ((0)) NOT NULL,
    CONSTRAINT [PK_pProductoMovimientos] PRIMARY KEY CLUSTERED ([empresa] ASC, [producto] ASC, [movimiento] ASC)
);

