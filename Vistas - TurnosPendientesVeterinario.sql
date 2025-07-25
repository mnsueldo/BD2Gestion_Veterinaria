USE Gestion_Veterinaria;
GO

CREATE VIEW VW_VistaTurnosPendientesVeterinario AS
SELECT 
    T.IDTurno,
    T.FechaHoraTurno,
    V.Nombre + ' ' + V.Apellido AS NombreVeterinario,
    D.Nombre + ' ' + D.Apellido AS NombreDueño,
    M.Nombre AS NombreMascota,
    ET.TipoEstado
FROM Turnos AS T
INNER JOIN Veterinarios AS V ON T.IDVeterinario = V.IDVeterinario
INNER JOIN Mascotas AS M ON T.NroHistoriaClinica = M.NroHistoriaClinica
INNER JOIN Dueños AS D ON M.IDDueño = D.IDDueño
INNER JOIN EstadoTurnos AS ET ON T.IDEstadoTurno = ET.IDEstadoTurno
WHERE ET.TipoEstado = 'En espera'
AND T.Activo = 1;

