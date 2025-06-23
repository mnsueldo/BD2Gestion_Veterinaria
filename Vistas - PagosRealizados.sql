USE Gestion_Veterinaria;
GO

CREATE VIEW VW_VistaPagosRealizados AS
SELECT 
    P.IDPago,
    P.FechaHoraPago,
    D.Nombre + ' ' + D.Apellido AS NombreDueño,
    M.Nombre AS NombreMascota,
    MP.TipoMetodosPago,
    P.ImporteTotal,
    P.Detalles,
    P.Pagado
FROM Pagos AS P
INNER JOIN HistoriasClinicas AS HC ON P.IDRegistro = HC.IDRegistro
INNER JOIN Turnos AS T ON HC.IDTurno = T.IDTurno
INNER JOIN Mascotas AS M ON T.NroHistoriaClinica = M.NroHistoriaClinica
INNER JOIN Dueños AS D ON M.IDDueño = D.IDDueño
INNER JOIN MetodosPagos AS MP ON P.IDMetodosPago = MP.IDMetodosPago
WHERE P.Pagado = 1;
