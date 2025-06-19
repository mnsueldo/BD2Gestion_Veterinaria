USE Gestion_Veterinaria;
GO

CREATE OR ALTER PROCEDURE sp_RegistrarHistoriaClinicaConPago
    @NroHistoriaClinica INT,
    @IDTurno INT,
    @FechaHoraCita DATETIME,
    @Sintomas NVARCHAR(255),    
    @Diagnostico NVARCHAR(500),
    @Tratamiento NVARCHAR(500),
    @Medicacion NVARCHAR(255),
    @Observaciones NVARCHAR(255),
    @FechaHoraPago DATETIME,
    @IDMetodosPago INT,
    @ImporteTotal MONEY,
    @Detalles NVARCHAR (300)
    
    
AS
BEGIN
    
    DECLARE 
        
        @IDVeterinario INT,
        @IDRegistro INT;

    BEGIN TRY
        BEGIN TRANSACTION
        
        --Verificar que el turno exista y este activo
        IF NOT EXISTS (
            SELECT 1 FROM Turnos 
            WHERE IDTurno = @IDTurno AND Activo = 1
        )
        BEGIN
            RAISERROR('EL TURNO NO EXISTE O YA FUE ATENDIDO', 16, 1);
            ROLLBACK TRANSACTION
            RETURN;
        END

        -- Obtener datos del turno
        SELECT @NroHistoriaClinica = NroHistoriaClinica, @IDVeterinario = IDVeterinario
        FROM Turnos
        WHERE IDTurno = @IDTurno;
       
       --Verificar que no exista ya una historia clinica para ese turno
        IF EXISTS (
            SELECT 1 
            FROM HistoriasClinicas AS HC
            JOIN Turnos AS T ON HC.IDTurno = T.IDTurno
            WHERE T.IDTurno = @IDTurno
        )
        BEGIN
            RAISERROR('YA EXISTE UNA HISTORIA CLINICA PARA ESE TURNO', 16, 1);
            ROLLBACK TRANSACTION
            RETURN;
        END

        -- Verificar que el método de pago exista
        IF NOT EXISTS (
            SELECT 1 FROM MetodosPagos 
            WHERE IDMetodosPago = @IDMetodosPago
        )
        BEGIN
            RAISERROR('METODO DE PAGO INVALIDO', 16, 1);
            ROLLBACK TRANSACTION
            RETURN;
        END

        -- Insercion de una nueva historia clínica asociada al turno
        INSERT INTO HistoriasClinicas (NroHistoriaClinica, IDTurno, FechaHoraCita, Sintomas, Diagnostico, Tratamiento, Medicacion, Observaciones)
        VALUES (@NroHistoriaClinica, @IDTurno, @FechaHoraCita, @Sintomas, @Diagnostico, @Tratamiento, @Medicacion, @Observaciones);

        SET @IDRegistro =  @@IDENTITY

        -- Verificar que no haya un pago ya marcado como "Pagado" para esa historia
        IF EXISTS (
            SELECT 1 
            FROM Pagos 
            WHERE IDRegistro = @IDRegistro AND Pagado = 1
        )
        BEGIN
            RAISERROR('YA EXISTE UN PAGO PARA ESA HISTORIA CLINICA', 16, 1);
            ROLLBACK TRANSACTION
            RETURN;
        END

        -- Insertar nuevo pago
        INSERT INTO Pagos (IDRegistro, FechaHoraPago, IDMetodosPago, ImporteTotal,Detalles)
        VALUES (@IDRegistro, @FechaHoraPago, @IDMetodosPago, @ImporteTotal, @Detalles);

        -- Marcar el turno como "Atendido"
        UPDATE Turnos
        SET IDEstadoTurno = 3
        WHERE IDTurno = @IDTurno;

        --Marcar el pago como realizado
        UPDATE Pagos
        SET Pagado = 1
        WHERE IDRegistro = @IDRegistro;

        -- Verificar si se insertó correctamente
        IF @@ROWCOUNT = 0 
        BEGIN 
            RAISERROR('OCURRIO UN ERROR', 16, 1) 
        END

        COMMIT TRANSACTION;
    END TRY
    BEGIN CATCH
        ROLLBACK;
        PRINT ERROR_MESSAGE();
    END CATCH
END;
