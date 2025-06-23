USE Gestion_Veterinaria;
GO

CREATE VIEW VW_VistaPagosPendientes AS
SELECT 
    P.IDPago,
    D.Nombre + ' ' + D.Apellido AS NombreDueño,
    M.Nombre AS NombreMascota,
    V.Nombre + ' ' + V.Apellido AS NombreVeterinario,
    HC.FechaHoraCita,
    MP.TipoMetodosPago,
    P.ImporteTotal,
    P.Pagado

FROM Pagos AS P
INNER JOIN HistoriasClinicas AS HC ON P.IDRegistro = HC.IDRegistro
INNER JOIN Turnos AS T ON HC.IDTurno = T.IDTurno
INNER JOIN Mascotas AS M ON T.NroHistoriaClinica = M.NroHistoriaClinica
INNER JOIN Dueños AS D ON M.IDDueño = D.IDDueño
INNER JOIN Veterinarios AS V ON T.IDVeterinario = V.IDVeterinario
INNER JOIN MetodosPagos AS MP ON P.IDMetodosPago = MP.IDMetodosPago
WHERE P.Pagado = 0;
