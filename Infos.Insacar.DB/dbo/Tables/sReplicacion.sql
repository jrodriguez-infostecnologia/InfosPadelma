CREATE TABLE [dbo].[sReplicacion] (
    [id]            INT          IDENTITY (1, 1) NOT NULL,
    [empresaA]      INT          NOT NULL,
    [empresaB]      INT          NOT NULL,
    [tabla]         VARCHAR (50) NOT NULL,
    [noRegistro]    INT          NOT NULL,
    [usuario]       VARCHAR (50) NOT NULL,
    [fechaRegistro] DATETIME     NOT NULL,
    CONSTRAINT [PK_sReplicacion] PRIMARY KEY CLUSTERED ([id] ASC)
);

