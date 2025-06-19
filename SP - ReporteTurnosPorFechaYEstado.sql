USE Gestion_Veterinaria;
GO

CREATE PROCEDURE sp_ReporteTurnosPorFechaYEstado
    @FechaInicio DATETIME,
    @FechaFin DATETIME,
    @IdEstadoTurno INT = NULL
AS
BEGIN
   
    BEGIN TRY
        -- Consultar los turnos dentro del rango con opción de filtrar por estado
        SELECT 
            T.IDTurno,
            T.FechaHoraTurno,
            D.Nombre AS NombreDueño,
            M.Nombre AS NombreMascota,
            V.Nombre AS NombreVeterinario,
            ET.TipoEstado AS EstadoTurno
        FROM Turnos AS T
        INNER JOIN Mascotas AS M ON T.NroHistoriaClinica = M.NroHistoriaClinica
        INNER JOIN Dueños AS D ON M.IDDueño = D.IDDueño
        INNER JOIN Veterinarios AS V ON T.IDVeterinario = V.IDVeterinario
        INNER JOIN EstadoTurnos AS ET ON T.IDEstadoTurno = ET.IDEstadoTurno
        WHERE T.FechaHoraTurno BETWEEN @FechaInicio AND @FechaFin
        AND (@IDEstadoTurno IS NULL OR T.IDEstadoTurno = @IDEstadoTurno)
        ORDER BY T.FechaHoraTurno;

        IF @@ROWCOUNT = 0 
        BEGIN 
            RAISERROR('OCURRIO UN ERROR', 16, 1) 
        END
    END TRY
    BEGIN CATCH
        PRINT ERROR_MESSAGE();
    END CATCH
END;
