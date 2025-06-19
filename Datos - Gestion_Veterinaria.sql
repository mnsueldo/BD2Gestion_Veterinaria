USE Gestion_Veterinaria;
GO
SET DATEFORMAT YMD;
GO

INSERT INTO Especies (NombreEspecie, Caracteristicas) VALUES
('Perro', 'Canino doméstico'),
('Gato', 'Felino doméstico'),
('Conejo', 'Roedor doméstico'),
('Hámster', 'Roedor pequeño de compañía'),
('Tortuga', 'Reptil doméstico de crecimiento lento'),
('Ave', 'Pájaro doméstico de pequeño tamaño');
GO

INSERT INTO Razas (IDEspecie, NombreRaza) VALUES
(1, 'Labrador'),
(1, 'Bulldog'),
(2, 'Siamés'),
(2, 'Persa'),
(3, 'Belier'),
(3, 'Mini Rex'),
(4, 'Sirio'),
(4, 'Enano Ruso'),
(5, 'Mediterránea'),
(5, 'Orejas Rojas'),
(6, 'Canario'),
(6, 'Periquito'),
(1, 'Golden Retriever'),
(2, 'Maine Coon'),
(6, 'Cacatúa');
GO

INSERT INTO Dueños (Dni, Apellido, Nombre, Direccion, Telefono, Email, FechaRegistro, Activo) VALUES
('12345678', 'García', 'María', 'Av. San Martín 123', '3814123456', 'mgarcia@mail.com', '2025-06-01', 1),
('87654321', 'Pérez', 'Carlos', 'Calle Córdoba 456', '3814765432', 'cperez@mail.com', '2025-06-01', 1),
('11223344', 'López', 'Ana', 'Bv. Avellaneda 789', '3814987654', 'alopez@mail.com', '2025-06-01', 1),
('44332211', 'Sosa', 'Lucía', 'Pasaje Belgrano 321', '3814321122', 'lsosa@mail.com', '2025-06-01', 1),
('33445566', 'Romero', 'Julián', 'Calle Salta 789', '3814112233', 'jromero@mail.com', '2025-06-01', 1),
('44556677', 'Benítez', 'Natalia', 'Av. Mitre 1580', '3814998877', 'nbenitez@mail.com', '2025-06-01', 1),
('55667788', 'Ibarra', 'Santiago', 'Pasaje Mendoza 412', '3814223344', 'sibarra@mail.com', '2025-06-01', 1),
('66778811', 'Guzmán', 'Ernesto', 'Calle Rivadavia 1010', '3814001122', 'eguzman@mail.com', '2025-06-01', 1),
('77889900', 'Alvarez', 'Luján', 'Bv. Sarmiento 340', '3814556677', 'lalvarez@mail.com', '2025-06-01', 1),
('88990011', 'Castro', 'Bruno', 'Av. Mitre 780', '3814229900', 'bcastro@mail.com', '2025-06-01', 1);
GO

INSERT INTO Mascotas (IDDueño, IDRaza, Nombre, Sexo, Color, Peso, FechaRegistro, Activo) VALUES
(1, 1, 'Rocco', 'Macho', 'Negro', 15.3, '2025-06-01', 1),
(1, 2, 'Luna', 'Hembra', 'Blanca', 12.5, '2025-06-02', 1),
(2, 3, 'Misu', 'Hembra', 'Gris', 4.2, '2025-06-03', 1),
(2, 4, 'Nube', 'Macho', 'Blanco', 4.8, '2025-06-03', 1),
(3, 5, 'Bunny', 'Hembra', 'Marrón', 2.3, '2025-06-04', 1),
(4, 6, 'Coco', 'Macho', 'Crema', 2.5, '2025-06-05', 1),
(5, 7, 'Pepito', 'Macho', 'Dorado', 0.25, '2025-06-06', 1),
(5, 8, 'Lili', 'Hembra', 'Blanco y gris', 0.20, '2025-06-06', 1),
(6, 9, 'Manchita', 'Hembra', 'Verde oliva', 1.7, '2025-06-07', 1),
(6, 10, 'Speedy', 'Macho', 'Marrón rojizo', 1.9, '2025-06-07', 0),
(7, 11, 'Piolín', 'Macho', 'Amarillo', 0.1, '2025-06-08', 1),
(7, 12, 'Chiqui', 'Hembra', 'Verde', 0.12, '2025-06-08', 1),
(8, 13, 'Simba', 'Macho', 'Dorado claro', 25.0, '2025-06-09', 1),
(8, 14, 'Zelda', 'Hembra', 'Naranja con gris', 5.0, '2025-06-10', 1),
(9, 15, 'Coco', 'Hembra', 'Blanca', 0.09, '2025-06-11', 1),
(9, 1, 'Thor', 'Macho', 'Negro y marrón', 34.0, '2025-06-11', 1),
(10, 2, 'Fiona', 'Hembra', 'Beige', 10.0, '2025-06-12', 1),
(10, 6, 'Toby', 'Macho', 'Gris oscuro', 2.1, '2025-06-12', 1),
(10, 3, 'Milu', 'Hembra', 'Gris claro', 4.0, '2025-06-12', 1),
(10, 9, 'Rocky', 'Macho', 'Verde', 1.8, '2025-06-12', 1);
GO

INSERT INTO EspecialidadesVeterinarios (NombreEspecialidad) VALUES
('Clínica General'),
('Cirugía'),
('Dermatología'),
('Exóticos'),
('Oftalmología'),
('Cardiología');
GO

INSERT INTO Veterinarios (Dni, Apellido, Nombre, Direccion, Telefono, Email, MatriculaNacional, MatriculaProvincial, IDEspecialidad, FechaRegistro, Activo) VALUES
('55443322', 'Rodríguez', 'Martín', 'Av. Roca 234', '3814556677', 'mrodriguez@vet.com', 1001, 5001, 1, '2025-06-01', 1),
('66778899', 'Fernández', 'María', 'Calle Rioja 345', '3814778899', 'mfernandez@vet.com', 1002, 5002, 2, '2025-06-01', 1),
('99887766', 'Gómez', 'Luciano', 'Bv. España 567', '3814987766', 'lgomez@vet.com', 1003, 5003, 3, '2025-06-01', 1),
('11224488', 'Silva', 'Patricia', 'Av. Mitre 900', '3814000100', 'psilva@vet.com', 1004, 5004, 4, '2025-06-01', 1),
('22113344', 'Cano', 'Esteban', 'Calle Chacabuco 122', '3814551100', 'ecano@vet.com', 1005, 5005, 5, '2025-06-01', 1),
('33442211', 'Luna', 'Verónica', 'Pasaje Alberdi 313', '3814888777', 'vluna@vet.com', 1006, 5006, 6, '2025-06-01', 1);
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
('2025-06-01 10:00', 1, 1, 'Chequeo general', 3, '2025-06-01', 1),
('2025-06-02 14:30', 2, 2, 'Vacuna antirrábica', 3, '2025-06-02', 1),
('2025-06-03 09:00', 3, 3, 'Diarrea leve', 3, '2025-06-03', 1),
('2025-06-04 11:15', 4, 1, 'Control post cirugía', 3, '2025-06-04', 1),
('2025-06-05 16:00', 5, 2, 'Desparasitación', 3, '2025-06-05', 1),
('2025-06-06 13:00', 6, 3, 'Oído inflamado', 3, '2025-06-06', 1),
('2025-06-07 09:30', 7, 4, 'Lesión en caparazón', 3, '2025-06-07', 1),
('2025-06-08 10:30', 8, 4, 'Cambio de hábitat', 3, '2025-06-08', 1),
('2025-06-09 14:00', 9, 5, 'Lagrimeo excesivo', 3, '2025-06-09', 1),
('2025-06-10 11:00', 10, 6, 'Chequeo cardiológico', 3, '2025-06-10', 1),
('2025-06-11 15:15', 11, 1, 'Muda de plumas', 3, '2025-06-11', 1),
('2025-06-12 10:00', 12, 2, 'Cirugía programada', 2, '2025-06-12', 1),
('2025-06-13 09:00', 13, 3, 'Vacunación', 1, '2025-06-13', 1),
('2025-06-14 11:30', 14, 4, 'Control post vacunación', 1, '2025-06-14', 1),
('2025-06-15 08:45', 15, 5, 'Revisión rutinaria', 1, '2025-06-15', 1),
('2025-06-16 13:15', 16, 6, 'Consultorio cancelado', 4, '2025-06-16', 0),
('2025-06-17 12:00', 17, 1, 'Chequeo', 3, '2025-06-17', 1),
('2025-06-18 16:00', 18, 2, 'Herida leve', 3, '2025-06-18', 1),
('2025-06-19 09:15', 19, 3, 'Control digestivo', 3, '2025-06-19', 1),
('2025-06-20 10:00', 20, 4, 'Corte de uñas', 3, '2025-06-20', 1);
GO

INSERT INTO HistoriasClinicas (NroHistoriaClinica, IDTurno, FechaHoraCita, Sintomas, Diagnostico, Tratamiento, Medicacion, Observaciones, FechaRegistro, Activo) VALUES
(1, 1, '2025-06-01 10:00', 'Sin síntomas', 'Buen estado general', 'Ninguno', NULL, 'Revisión completa', '2025-06-01', 1),
(2, 2, '2025-06-02 14:30', 'Aplicar vacuna', 'OK', 'Vacunación antirrábica', NULL, 'Aplicada con éxito', '2025-06-02', 1),
(3, 3, '2025-06-03 09:00', 'Diarrea', 'Indigestión', 'Dieta blanda', 'Enteroguard', 'Control en 3 días', '2025-06-03', 1),
(4, 4, '2025-06-04 11:15', 'Control postoperatorio', 'Sin complicaciones', 'Reposo', NULL, 'Buena recuperación', '2025-06-04', 1),
(5, 5, '2025-06-05 16:00', 'Parásitos visibles', 'Lombrices', 'Desparasitación oral', 'Prazivet', 'Repetir en 30 días', '2025-06-05', 1),
(6, 6, '2025-06-06 13:00', 'Irritación auditiva', 'Otitis', 'Limpieza y gotas', 'Otibiotical', 'Chequeo en 7 días', '2025-06-06', 1),
(7, 7, '2025-06-07 09:30', 'Fisura leve', 'Impacto menor', 'Desinfección', 'Betadine Vet', 'No exponer al sol', '2025-06-07', 1),
(8, 8, '2025-06-08 10:30', 'Poca actividad', 'Estrés', 'Cambiar hábitat', NULL, 'Revisar en 10 días', '2025-06-08', 1),
(9, 9, '2025-06-09 14:00', 'Lágrimas constantes', 'Conjuntivitis', 'Colirio veterinario', 'Optivet', 'Control en 5 días', '2025-06-09', 1),
(10, 10, '2025-06-10 11:00', 'Chequeo cardíaco', 'Sin anormalidades', 'Ninguno', NULL, 'Control anual', '2025-06-10', 1),
(11, 11, '2025-06-11 15:15', 'Caída de plumas', 'Muda estacional', 'Vitaminas', 'Avesvit Complex', 'Control en 15 días', '2025-06-11', 1),
(12, 12, '2025-06-12 10:00', 'Fiebre y fatiga', 'Infección viral leve', 'Reposo + hidratación + control', 'AntiviralVet 150', 'Reevaluar en 72hs', '2025-06-12', 1),
(13, 13, '2025-06-13 09:00', 'Revisión prevacunación', 'Apto clínicamente', 'Ninguno', NULL, 'Se programará la vacunación para la próxima semana', '2025-06-13', 1),
(14, 14, '2025-06-14 11:30', 'Olor fuerte en orejas', 'Otitis externa leve', 'Limpieza y gotas por 7 días', 'Otibiotical', 'Control en 1 semana', '2025-06-14', 1),
(15, 15, '2025-06-15 08:45', 'Control post operatorio', 'Cicatrización normal', 'Ninguno', NULL, 'Alta clínica otorgada', '2025-06-15', 1),
(16, 16, '2025-06-16 12:00', 'Revisión por caída', 'Esguince leve en pata trasera', 'Reposo y antiinflamatorios por 5 días', 'PetFen ID 200mg', 'Revisar si hay cojera persistente', '2025-06-16', 1),
(17, 17, '2025-06-17 12:00', 'Chequeo simple', 'Sin hallazgos', 'Ninguno', NULL, 'Control de rutina', '2025-06-17', 1),
(18, 18, '2025-06-18 16:00', 'Corte superficial', 'Rasguño', 'Limpieza', 'Cicatrizante', 'Sin infección', '2025-06-18', 1),
(19, 19, '2025-06-19 09:15', 'Falta de apetito', 'Malestar digestivo', 'Probioticos', 'Vetacid', 'Comenzó mejora', '2025-06-19', 1),
(20, 20, '2025-06-20 10:00', 'Corte de uñas', 'Normal', 'Corte completo', NULL, 'Sin incidentes', '2025-06-20', 1);
GO

INSERT INTO Pagos (IDRegistro, FechaHoraPago, IDMetodosPago, ImporteTotal, Pagado, Detalles, FechaRegistro, Activo) VALUES
(1, '2025-06-01 10:30', 1, 2500.00, 1, 'Efectivo, sin reintegro', '2025-06-01', 1),
(2, '2025-06-02 15:00', 2, 3100.00, 1, 'Tarjeta Débito', '2025-06-02', 1),
(3, '2025-06-03 09:30', 3, 3300.00, 1, 'Tarjeta Crédito Visa', '2025-06-03', 1),
(4, '2025-06-04 12:00', 1, 2800.00, 1, 'Efectivo exacto', '2025-06-04', 1),
(5, '2025-06-05 16:30', 4, 3500.00, 1, 'Transferencia Banco Nación', '2025-06-05', 1),
(6, '2025-06-06 13:30', 5, 2900.00, 1, 'Pagado por QR MercadoPago', '2025-06-06', 1),
(7, '2025-06-07 10:00', 1, 2100.00, 1, 'Efectivo', '2025-06-07', 1),
(8, '2025-06-08 11:00', 4, 2400.00, 1, 'Transferencia confirmada', '2025-06-08', 1),
(9, '2025-06-09 14:30', 2, 2000.00, 1, 'Tarjeta débito Banelco', '2025-06-09', 1),
(10, '2025-06-10 11:45', 3, 3800.00, 0, 'Tarjeta rechazada', '2025-06-10', 1),
(11, '2025-06-11 16:00', 1, 1500.00, 1, 'Pagado en mostrador', '2025-06-11', 1),
(12, '2025-06-12 10:30', 2, 3100.00, 1, 'Pago con tarjeta débito', '2025-06-12', 1),
(13, '2025-06-13 09:20', 1, 1900.00, 1, 'Pagado en efectivo sin observaciones', '2025-06-13', 1),
(14, '2025-06-14 12:00', 3, 3400.00, 1, 'Tarjeta de crédito Visa', '2025-06-14', 1),
(15, '2025-06-15 09:00', 4, 2500.00, 1, 'Transferencia online confirmada', '2025-06-15', 1),
(16, '2025-06-16 12:30', 5, 2800.00, 1, 'QR abonado con app bancaria', '2025-06-16', 1),
(17, '2025-06-17 12:30', 4, 3200.00, 1, 'Transferencia 3 cuotas', '2025-06-17', 1),
(18, '2025-06-18 16:30', 5, 2700.00, 1, 'QR abonado', '2025-06-18', 1),
(19, '2025-06-19 09:45', 2, 2950.00, 1, 'Tarjeta débito', '2025-06-19', 1),
(20, '2025-06-20 10:30', 1, 1800.00, 1, 'Efectivo', '2025-06-20', 1);
GO