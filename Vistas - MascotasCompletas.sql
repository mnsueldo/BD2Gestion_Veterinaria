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
JOIN Dueños AS D ON M.IDDueño = D.IDDueño
JOIN Razas AS R ON M.IDRaza = R.IDRaza
JOIN Especies AS E ON R.IDEspecie = E.IDEspecie;









