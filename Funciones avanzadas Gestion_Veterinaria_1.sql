USE Gestion_Veterinaria_1;
GO
--VISTAS
1- Mascotas con su dueño y especie
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
SELECT * FROM Vw_VistaCompletaMascotas;

2-Turnos pendientes por veterinario
ALTER VIEW VW_VistaTurnosPendientesVeterinario AS
SELECT 
    T.IDTurno,
    T.FechaHoraTurno,
    V.Nombre + ' ' + V.Apellido AS NombreVeterinario,
    D.Nombre + ' ' + D.Apellido AS NombreDueño,
    M.Nombre AS NombreMascota,
    ET.TipoEstado
FROM Turnos AS T
JOIN Veterinarios AS V ON T.IDVeterinario = V.IDVeterinario
JOIN Mascotas AS M ON T.NroHistoriaClinica = M.NroHistoriaClinica
JOIN Dueños AS D ON M.IDDueño = D.IDDueño
JOIN EstadoTurnos AS ET ON T.IDEstadoTurno = ET.IDEstadoTurno
WHERE ET.TipoEstado = 'En espera'
AND T.Activo = 1;
SELECT * FROM VW_VistaTurnosPendientesVeterinario;

3-Pagos pendientes con datos del turno y paciente:
ALTER VIEW VW_VistaPagosPendientes AS
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
JOIN HistoriasClinicas AS HC ON P.IDRegistro = HC.IDRegistro
JOIN Turnos AS T ON HC.IDTurno = T.IDTurno
JOIN Mascotas AS M ON T.NroHistoriaClinica = M.NroHistoriaClinica
JOIN Dueños AS D ON M.IDDueño = D.IDDueño
JOIN Veterinarios AS V ON T.IDVeterinario = V.IDVeterinario
JOIN MetodosPagos AS MP ON P.IDMetodosPago = MP.IDMetodosPago
WHERE P.Pagado = 0;
SELECT * FROM VW_VistaPagosPendientes;

4-Resumen de pagos realizados
ALTER VIEW VW_VistaPagosRealizados AS
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
JOIN HistoriasClinicas AS HC ON P.IDRegistro = HC.IDRegistro
JOIN Turnos AS T ON HC.IDTurno = T.IDTurno
JOIN Mascotas AS M ON T.NroHistoriaClinica = M.NroHistoriaClinica
JOIN Dueños AS D ON M.IDDueño = D.IDDueño
JOIN MetodosPagos AS MP ON P.IDMetodosPago = MP.IDMetodosPago
WHERE P.Pagado = 1;
SELECT * FROM VW_VistaPagosRealizados;

5- VistaHistoriasClinicas: Unir datos clínicos + detalles de la mascota, veterinario y diagnóstico, útil para revisar el historial
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
SELECT * FROM VW_VistaHistoriasClinicas;

--------------------------------------------------------------------
--Procedimientos almacenados
1-Crear turnos

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
       
        IF NOT EXISTS (SELECT 1 FROM Mascotas WHERE NroHistoriaClinica = @NroHistoriaClinica)
        BEGIN
            RAISERROR('LA MASCOTA NO EXISTE', 16, 1);
            ROLLBACK TRANSACTION
            RETURN;
        END

        IF NOT EXISTS (SELECT 1 FROM Veterinarios WHERE IDVeterinario = @IDVeterinario)
        BEGIN
            RAISERROR('EL VETERINARIO NO EXISTE', 16, 1);
            ROLLBACK TRANSACTION
            RETURN;
        END
        
        INSERT INTO Turnos (FechaHoraTurno, NroHistoriaClinica, IDVeterinario, MotivoConsulta, IDEstadoTurno)
        VALUES (@FechaHoraTurno, @NroHistoriaClinica, @IDVeterinario, @MotivoConsulta, @IDEstadoTurno);

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

EXEC sp_CrearTurno    
    @FechaHoraTurno = '2024-05-06 13:30',
    @NroHistoriaClinica = 6,
    @IDVeterinario = 2,
    @MotivoConsulta = 'Chequeo de rutina',
    @IDEstadoTurno = 1;

SELECT * FROM Turnos
WHERE IDTurno = 7;

2- Registrar Historia clinica y pagar

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
        
        IF NOT EXISTS (
            SELECT 1 FROM Turnos 
            WHERE IDTurno = @IDTurno AND Activo = 1
        )
        BEGIN
            RAISERROR('EL TURNO NO EXISTE O YA FUE ATENDIDO', 16, 1);
            ROLLBACK TRANSACTION
            RETURN;
        END
        
        SELECT @NroHistoriaClinica = NroHistoriaClinica, @IDVeterinario = IDVeterinario
        FROM Turnos
        WHERE IDTurno = @IDTurno;
       
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

        
        IF NOT EXISTS (
            SELECT 1 FROM MetodosPagos 
            WHERE IDMetodosPago = @IDMetodosPago
        )
        BEGIN
            RAISERROR('METODO DE PAGO INVALIDO', 16, 1);
            ROLLBACK TRANSACTION
            RETURN;
        END

        INSERT INTO HistoriasClinicas (NroHistoriaClinica, IDTurno, FechaHoraCita, Sintomas, Diagnostico, Tratamiento, Medicacion, Observaciones)
        VALUES (@NroHistoriaClinica, @IDTurno, @FechaHoraCita, @Sintomas, @Diagnostico, @Tratamiento, @Medicacion, @Observaciones);

        SET @IDRegistro =  @@IDENTITY
        
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

       
        INSERT INTO Pagos (IDRegistro, FechaHoraPago, IDMetodosPago, ImporteTotal,Detalles)
        VALUES (@IDRegistro, @FechaHoraPago, @IDMetodosPago, @ImporteTotal, @Detalles);

        
        UPDATE Turnos
        SET IDEstadoTurno = 3
        WHERE IDTurno = @IDTurno;

        UPDATE Pagos
        SET Pagado = 1
        WHERE IDRegistro = @IDRegistro;

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

EXEC sp_RegistrarHistoriaClinicaConPago
    @NroHistoriaClinica = 6,
    @IDTurno = 7,
    @FechaHoraCita = '2024-05-01 10:00',
    @Sintomas = 'Le duele la patita',    
    @Diagnostico = 'Tiene una patita lastimada por pisar vidrio',
    @Tratamiento = 'Desinfectar y vendar la patita lastimada',
    @Medicacion = 'Ibuprofeno para mascotas',
    @Observaciones = 'Se va a recuperar al cabo de 1 semana siguiendo el tratamiento indicado',
    @FechaHoraPago = '2024-05-01 10:15',
    @IDMetodosPago = 1,
    @ImporteTotal = 5000,
    @Detalles = 'Pagado en tiempo y forma';

SELECT * FROM HistoriasClinicas AS HC
INNER JOIN Pagos AS P ON HC.IDRegistro = P.IDRegistro
INNER JOIN MetodosPagos AS MP ON P.IDMetodosPago = MP.IDMetodosPago
WHERE NroHistoriaClinica = 6

3- Historias clinicas por mascotas

CREATE PROCEDURE sp_HistoriasClinicasPorMascota
    @NroHistoriaClinica INT
AS
BEGIN
    
    BEGIN TRY
        IF NOT EXISTS (SELECT 1 FROM Mascotas WHERE NroHistoriaClinica = @NroHistoriaClinica)
        BEGIN
            RAISERROR('LA MASCOTA NO EXISTE', 16, 1);
            RETURN;
        END

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

        IF @@ROWCOUNT = 0 
        BEGIN 
            RAISERROR('OCURRIO UN ERROR', 16, 1) 
        END

    END TRY
    BEGIN CATCH
        PRINT ERROR_MESSAGE();
    END CATCH
END;

EXEC sp_HistoriasClinicasPorMascota
@NroHistoriaClinica = 16;

4- Reporte de Turnos por Fecha y Estado
CREATE PROCEDURE sp_ReporteTurnosPorFechaYEstado
    @FechaInicio DATETIME,
    @FechaFin DATETIME,
    @IdEstadoTurno INT = NULL
AS
BEGIN
   
    BEGIN TRY
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

EXEC sp_ReporteTurnosPorFechaYEstado 
    @FechaInicio = '2024-01-01', 
    @FechaFin = '2024-12-15', 
    @IdEstadoTurno = 1;
------------------------------------------------------------------------
--TRIGGERS

CREATE TRIGGER tr_Evitar_Superposicion_Turnos ON Turnos
AFTER INSERT
AS
BEGIN
    IF EXISTS (
        SELECT 1
        FROM Turnos AS T
        INNER JOIN INSERTED AS I ON 
            T.IDVeterinario = I.IDVeterinario AND
            T.FechaHoraTurno = I.FechaHoraTurno AND
            T.IDTurno <> I.IDTurno
    )
    BEGIN
        RAISERROR('EL VETERINARIO YA TIENE UN TURNO ASIGNADO A ESA FECHA Y HORA', 16, 1);
        ROLLBACK TRANSACTION;
    END
END;

CREATE TRIGGER tr_Mascotas_Inactivas_Eliminar_Dueno ON Dueños
AFTER DELETE
AS
BEGIN

    BEGIN TRY
        
        UPDATE M
        SET Activo = 0
        FROM Mascotas AS M
        INNER JOIN DELETED AS D ON M.IDDueño = D.IDDueño;
    END TRY
    BEGIN CATCH        
        RAISERROR('ERROR EN EL BORRADO LOGICO', 16, 1);
    END CATCH
END;

EXEC sp_CrearTurno    
    @FechaHoraTurno = '2025-06-10 13:00',
    @NroHistoriaClinica = 4,
    @IDVeterinario = 1,
    @MotivoConsulta = 'Corte de pelo y uñas',
    @IDEstadoTurno = 1;
SELECT * FROM Turnos


EXEC sp_RegistrarHistoriaClinicaConPago
    @IDTurno = 8,
    @FechaHoraCita = '2025-05-06 13:00',
    @Sintomas = 'Consulta por falta de apetito',
    @Diagnostico = 'Gastritis leve',
    @Tratamiento = 'Dieta blanda y medicación por 5 días',
    @Medicacion = 'Antibiotico 2.0',
    @FechaHoraPago = '2025-05-06 13:30',
    @ImporteTotal = 2500.00,
    @IDMetodosPago = 2,
    @Observaciones = 'Pago realizado en efectivo sin novedades.';

3- Actualizar estado a “En curso” automáticamente al iniciar cita
CREATE TRIGGER tr_ActualizarEstadoTurno ON HistoriasClinicas
AFTER INSERT
AS
BEGIN
    UPDATE Turnos
    SET IDEstadoTurno = (SELECT IDEstadoTurno FROM EstadoTurnos WHERE TipoEstado = 'En curso')
    FROM Turnos AS T
    JOIN INSERTED AS I ON T.IDTurno = I.IDTurno;
END;

DISABLE TRIGGER tr_ActualizarEstadoTurno ON HistoriasClinicas;


