USE Gestion_Veterinaria;
GO

CREATE VIEW VW_VistaCompletaMascotas AS
SELECT 
    M.NroHistoriaClinica,
    M.Nombre AS NombreMascota,
    D.Nombre + ' ' + D.Apellido AS NombreDueño,
    E.NombreEspecie,
    R.NombreRaza,
    M.Sexo,
    M.Color,
    M.Peso,
    M.FechaRegistro
FROM Mascotas AS M
INNER JOIN Dueños AS D ON M.IDDueño = D.IDDueño
INNER JOIN Razas AS R ON M.IDRaza = R.IDRaza
INNER JOIN Especies AS E ON R.IDEspecie = E.IDEspecie;









