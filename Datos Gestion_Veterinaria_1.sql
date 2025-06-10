USE Gestion_Veterinaria_1;
GO
SET DATEFORMAT YMD;
GO


INSERT INTO Especies (NombreEspecie, Caracteristicas) VALUES
('Perro', 'Canino doméstico'),
('Gato', 'Felino doméstico'),
('Conejo', 'Roedor doméstico');
GO

INSERT INTO Razas (IDEspecie, NombreRaza) VALUES
(1, 'Labrador'),
(1, 'Bulldog'),
(2, 'Siamés'),
(2, 'Persa'),
(3, 'Belier'),
(3, 'Mini Rex');
GO

INSERT INTO Dueños (Dni, Apellido, Nombre, Direccion, Telefono, Email, FechaRegistro, Activo) VALUES
('12345678', 'García', 'María', 'Av. San Martín 123', '3814123456', 'mgarcia@mail.com', '2024-01-10', 1),
('87654321', 'Pérez', 'Carlos', 'Calle Córdoba 456', '3814765432', 'cperez@mail.com', '2023-11-05', 1),
('11223344', 'López', 'Ana', 'Bv. Avellaneda 789', '3814987654', 'alopez@mail.com', '2022-06-20', 1),
('44332211', 'Sosa', 'Lucía', 'Pasaje Belgrano 321', '3814321122', 'lsosa@mail.com', '2021-03-15', 1);
GO

INSERT INTO Mascotas (IDDueño, IDRaza, Nombre, Sexo, Color, Peso, FechaRegistro, Activo) VALUES
(1, 1, 'Rocco', 'Macho', 'Negro', 15.3, '2024-01-15', 1),
(1, 2, 'Luna', 'Hembra', 'Blanca', 12.5, '2024-02-01', 1),
(2, 3, 'Misu', 'Hembra', 'Gris', 4.2, '2023-12-10', 1),
(2, 4, 'Nube', 'Macho', 'Blanco', 4.8, '2023-12-20', 1),
(3, 5, 'Bunny', 'Hembra', 'Marrón', 2.3, '2024-03-05', 1),
(4, 6, 'Coco', 'Macho', 'Crema', 2.5, '2024-04-12', 1);
GO


INSERT INTO EspecialidadesVeterinarios (NombreEspecialidad) VALUES
('Clínica General'),
('Cirugía'),
('Dermatología');
GO

INSERT INTO Veterinarios (Dni, Apellido, Nombre, Direccion, Telefono, Email, MatriculaNacional, MatriculaProvincial, IDEspecialidad, FechaRegistro, Activo) VALUES
('55443322', 'Rodríguez', 'Martín', 'Av. Roca 234', '3814556677', 'mrodriguez@vet.com', 1001, 5001, 1, '2023-05-10', 1),
('66778899', 'Fernández', 'María', 'Calle Rioja 345', '3814778899', 'mfernandez@vet.com', 1002, 5002, 2, '2023-06-15', 1),
('99887766', 'Gómez', 'Luciano', 'Bv. España 567', '3814987766', 'lgomez@vet.com', 1003, 5003, 3, '2023-07-20', 1);
GO

INSERT INTO EstadoTurnos (TipoEstado) VALUES
('En espera'),
('En curso'),
('Atendido'),
('Cancelado');
GO

INSERT INTO MetodosPagos (TipoMetodosPago) VALUES
('Efectivo'),
('Tarjeta Debito'),
('Tarjeta Crédito'),
('Transferencia Bancaria'),
('QR');
GO

INSERT INTO Turnos (FechaHoraTurno, NroHistoriaClinica, IDVeterinario, MotivoConsulta, IDEstadoTurno, FechaRegistro, Activo) VALUES
('2024-05-01 10:00', 1, 1, 'Chequeo anual', 1, '2024-04-20', 1),
('2024-05-02 14:30', 2, 2, 'Limpieza de oído', 1, '2024-04-21', 1),
('2024-05-03 09:00', 3, 3, 'Antiparasitario', 1, '2024-04-22', 1),
('2024-05-04 11:15', 4, 1, 'Vacuna', 1, '2024-04-23', 1),
('2024-05-05 16:00', 5, 2, 'Revisión piel', 1, '2024-04-24', 1),
('2024-05-06 13:00', 6, 3, 'Revisión general', 1, '2024-04-25', 1);
GO

INSERT INTO HistoriasClinicas (NroHistoriaClinica, IDTurno, FechaHoraCita, Sintomas, Diagnostico, Tratamiento, Medicacion, Observaciones, FechaRegistro, Activo) VALUES
(1, 1, '2024-05-01 10:00', 'Letárgico', 'Sin hallazgos', 'Observación', NULL, 'Sin novedades', '2024-05-01', 1),
(2, 2, '2024-05-02 14:30', 'Oído sucio', 'Otitis leve', 'Limpieza + antibiótico', 'Otibiotical', 'Control en 7 días', '2024-05-02', 1),
(3, 3, '2024-05-03 09:00', 'Picazón', 'Gusanos intestinales', 'Desparasitación', 'Nemexit', 'Repetir en 30 días', '2024-05-03', 1),
(4, 4, '2024-05-04 11:15', 'Revisión vacuna', 'Todo OK', 'Aplicar vacuna antirrábica', NULL, 'Próxima vacunación en 1 año', '2024-05-04', 1),
(5, 5, '2024-05-05 16:00', 'Rascado frecuente', 'Dermatitis', 'Shampoo medicado', 'Dermashield', 'Revisar en 15 días', '2024-05-05', 1),
(6, 6, '2024-05-06 13:00', 'Revisión rutina', 'Buen estado general', 'Ninguno', NULL, 'Revisión en 6 meses', '2024-05-06', 1);
GO

INSERT INTO Pagos (IDRegistro, FechaHoraPago, IDMetodosPago, ImporteTotal, Pagado, Detalles, FechaRegistro, Activo) VALUES
(1, '2024-05-01 10:30', 1, 2000.00, 1, 'Pagado en efectivo', '2024-05-01', 1),
(2, '2024-05-02 15:00', 2, 3500.00, 0, 'Tarjeta pendiente', '2024-05-02', 1),
(3, '2024-05-03 09:30', 3, 2500.00, 1, 'Pago MercadoPago', '2024-05-03', 1),
(4, '2024-05-03 11:30', 1, 1500.00, 0, 'Pendiente', '2024-05-04', 1),
(5, '2024-05-05 16:30', 2, 3000.00, 1, 'Tarjeta OK', '2024-05-05', 1);
GO

