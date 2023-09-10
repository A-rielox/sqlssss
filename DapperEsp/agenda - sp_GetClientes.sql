CREATE PROC sp_GetClientes
AS
BEGIN
	SELECT * FROM Cliente;
END
GO



CREATE PROC sp_GetClienteId
(
	@ClienteId INT
)
AS
BEGIN
	SELECT * FROM Cliente
	WHERE IdCliente = @ClienteId;
END
GO





CREATE PROC sp_CrearCliente
(
	@ClienteId INT OUTPUT,
	@Nombres VARCHAR(MAX),
	@Apellidos VARCHAR(MAX),
	@Telefono VARCHAR(MAX),
	@Email VARCHAR(MAX),
	@Pais VARCHAR(MAX)
)
AS
BEGIN
	INSERT INTO Cliente (Nombres, Apellidos, Telefono, Email, Pais, FechaCreacion)
	VALUES(@Nombres, @Apellidos, @Telefono, @Email, @Pais, CURRENT_TIMESTAMP);

	SELECT @ClienteId = SCOPE_IDENTITY();
END
GO



CREATE PROC sp_ActualizarCliente
(
	@ClienteId INT OUTPUT,
	@Nombres VARCHAR(MAX),
	@Apellidos VARCHAR(MAX),
	@Telefono VARCHAR(MAX),
	@Email VARCHAR(MAX),
	@Pais VARCHAR(MAX)
)
AS
BEGIN
	UPDATE Cliente
    SET Nombres = @Nombres, Apellidos = @Apellidos, Telefono = @Telefono, Email = @Email, Pais = @Pais
    WHERE IdCliente = @ClienteId;
END
GO




CREATE PROC sp_BorrarCliente
(
	@ClienteId INT
)
AS
BEGIN
	DELETE FROM Cliente
	WHERE IdCliente = @ClienteId;
END
GO


