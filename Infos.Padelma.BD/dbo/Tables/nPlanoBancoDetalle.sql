CREATE TABLE [dbo].[nPlanoBancoDetalle] (
    [empresa]     INT           NOT NULL,
    [banco]       VARCHAR (50)  NOT NULL,
    [registro]    INT           NOT NULL,
    [nombreCampo] VARCHAR (500) NULL,
    [inicio]      INT           NOT NULL,
    [longitud]    INT           NOT NULL,
    [mValorFijo]  BIT           NOT NULL,
    [valorFijo]   VARCHAR (50)  NULL,
    [tipoCampo]   INT           NOT NULL,
    CONSTRAINT [PK_nPlanoBancoDetalle] PRIMARY KEY CLUSTERED ([empresa] ASC, [banco] ASC, [registro] ASC)
);

