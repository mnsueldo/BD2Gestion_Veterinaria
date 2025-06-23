USE Gestion_Veterinaria;
GO

CREATE TRIGGER tr_Mascotas_Inactivas_Eliminar_Dueno ON Dueños
AFTER UPDATE
AS
BEGIN
    -- Solo cuando el dueño fue inactivado
    IF EXISTS (
        SELECT 1 FROM INSERTED AS I 
        INNER JOIN DELETED AS D ON I.IDDueño = D.IDDueño
        WHERE I.Activo = 0 AND D.Activo = 1
    )
    BEGIN
        UPDATE M
        SET Activo = 0
        FROM Mascotas AS M
        INNER JOIN INSERTED AS I ON M.IDDueño = I.IDDueño
    END
END;
