CREATE TABLE [dbo].[logCarnetDespacho] (
    [empresa] INT          NOT NULL,
    [codigo]  VARCHAR (50) NOT NULL,
    [estado]  CHAR (1)     NOT NULL,
    CONSTRAINT [PK_logDespachoCarnet] PRIMARY KEY CLUSTERED ([empresa] ASC, [codigo] ASC)
);

