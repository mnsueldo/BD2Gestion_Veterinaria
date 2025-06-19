USE Gestion_Veterinaria;
GO

CREATE TRIGGER tr_Evitar_Superposicion_Turnos ON Turnos
AFTER INSERT
AS
BEGIN
    -- Verificar si ya existe otro turno con el mismo veterinario, fecha y hora
    IF EXISTS (
        SELECT 1
        FROM Turnos AS T
        INNER JOIN INSERTED AS I ON 
            T.IDVeterinario = I.IDVeterinario AND
            T.FechaHoraTurno = I.FechaHoraTurno AND
            T.IDTurno <> I.IDTurno
    )
    BEGIN
        -- Cancela la transacción si hay superposición
        RAISERROR('EL VETERINARIO YA TIENE UN TURNO ASIGNADO A ESA FECHA Y HORA', 16, 1);
        ROLLBACK TRANSACTION;
    END
END;





