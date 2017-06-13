CREATE TABLE [dbo].[sysEntidadMetodos] (
    [entidad]      VARCHAR (250) NOT NULL,
    [dBase]        VARCHAR (250) NOT NULL,
    [metodoGet]    VARCHAR (250) NULL,
    [metodoInsert] VARCHAR (250) NULL,
    [metodoUpdate] VARCHAR (250) NULL,
    [metodoDelete] VARCHAR (250) NULL,
    [metodoGetKey] VARCHAR (250) NULL,
    CONSTRAINT [PK_sysEntidadMetodos] PRIMARY KEY CLUSTERED ([entidad] ASC, [dBase] ASC)
);

