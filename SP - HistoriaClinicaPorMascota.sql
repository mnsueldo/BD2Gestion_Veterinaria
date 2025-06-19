USE Gestion_Veterinaria;
GO

CREATE PROCEDURE sp_HistoriasClinicasPorMascota
    @NroHistoriaClinica INT
AS
BEGIN
    
    BEGIN TRY

        --Verificar que la mascota exista
        IF NOT EXISTS (SELECT 1 FROM Mascotas WHERE NroHistoriaClinica = @NroHistoriaClinica)
        BEGIN
            RAISERROR('LA MASCOTA NO EXISTE', 16, 1);
            RETURN;
        END

        -- Consultar el historial clínico de la mascota
        SELECT 
            HC.IDRegistro,
            HC.FechaHoraCita,
            HC.Observaciones,
            HC.Diagnostico,
            HC.Tratamiento,
            V.Nombre AS NombreVeterinario
        FROM HistoriasClinicas AS HC
        INNER JOIN Turnos AS T ON HC.IDTurno = T.IDTurno
        INNER JOIN Veterinarios AS V ON T.IDVeterinario = V.IDVeterinario
        WHERE HC.NroHistoriaClinica = @NroHistoriaClinica
        ORDER BY HC.FechaHoraCita DESC;

        -- Verificar si se insertó correctamente
        IF @@ROWCOUNT = 0 
        BEGIN 
            RAISERROR('OCURRIO UN ERROR', 16, 1) 
        END

    END TRY
    BEGIN CATCH
        PRINT ERROR_MESSAGE();
    END CATCH
END;

