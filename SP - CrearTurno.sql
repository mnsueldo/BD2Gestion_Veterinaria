USE Gestion_Veterinaria;
GO

CREATE OR ALTER PROCEDURE sp_CrearTurno    
    @FechaHoraTurno DATETIME,
    @NroHistoriaClinica INT,
    @IDVeterinario INT,
    @MotivoConsulta NVARCHAR(255),
    @IDEstadoTurno INT
AS
BEGIN
    
    BEGIN TRY
        BEGIN TRANSACTION 

        -- Verificar que la mascota exista
        IF NOT EXISTS (SELECT 1 FROM Mascotas WHERE NroHistoriaClinica = @NroHistoriaClinica)
        BEGIN
            RAISERROR('LA MASCOTA NO EXISTE', 16, 1);
            ROLLBACK TRANSACTION
            RETURN;
        END

        -- Verificar que el veterinario exista
        IF NOT EXISTS (SELECT 1 FROM Veterinarios WHERE IDVeterinario = @IDVeterinario)
        BEGIN
            RAISERROR('EL VETERINARIO NO EXISTE', 16, 1);
            ROLLBACK TRANSACTION
            RETURN;
        END
        
        -- Inserción del nuevo turno
        INSERT INTO Turnos (FechaHoraTurno, NroHistoriaClinica, IDVeterinario, MotivoConsulta, IDEstadoTurno)
        VALUES (@FechaHoraTurno, @NroHistoriaClinica, @IDVeterinario, @MotivoConsulta, @IDEstadoTurno);

        -- Verificar si se insertó correctamente
        IF @@ROWCOUNT = 0 
        BEGIN 
        RAISERROR('OCURRIO UN ERROR', 16, 1) 
        END

        COMMIT TRANSACTION
    END TRY
    BEGIN CATCH
        PRINT ERROR_MESSAGE()
        ROLLBACK TRANSACTION
    END CATCH
END;
