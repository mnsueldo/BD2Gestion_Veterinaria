USE Gestion_Veterinaria;
GO

CREATE TRIGGER tr_Mascotas_Inactivas_Eliminar_Dueno ON Dueños
AFTER UPDATE
AS
BEGIN
    -- Solo cuando el dueño fue inactivado
    IF EXISTS (
        SELECT 1 FROM INSERTED i 
        JOIN DELETED d ON i.IDDueño = d.IDDueño
        WHERE i.Activo = 0 AND d.Activo = 1
    )
    BEGIN
        UPDATE M
        SET Activo = 0
        FROM Mascotas M
        JOIN INSERTED i ON M.IDDueño = i.IDDueño
    END
END;
