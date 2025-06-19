USE Gestion_Veterinaria;
GO

CREATE VIEW VW_VistaHistoriasClinicas AS
SELECT 
    HC.IDRegistro,
    HC.FechaHoraCita,
    HC.Sintomas,
    HC.Diagnostico,
    HC.Tratamiento,
    HC.Medicacion,
    HC.Observaciones,
    M.Nombre AS NombreMascota,
    R.NombreRaza AS Raza,
    E.NombreEspecie AS Especie,
    D.Nombre + ' ' + D.Apellido AS Dueño,
    V.Nombre + ' ' + V.Apellido AS Veterinario
   
FROM HistoriasClinicas AS HC
INNER JOIN Mascotas AS M ON HC.NroHistoriaClinica = M.NroHistoriaClinica
INNER JOIN Razas AS R ON M.IDRaza = R.IDRaza
INNER JOIN Especies AS E ON R.IDEspecie = E.IDEspecie
INNER JOIN Dueños AS D ON M.IDDueño = D.IDDueño
INNER JOIN Turnos AS T ON HC.IDTurno = T.IDTurno
INNER JOIN Veterinarios AS V ON T.IDVeterinario = V.IDVeterinario;
