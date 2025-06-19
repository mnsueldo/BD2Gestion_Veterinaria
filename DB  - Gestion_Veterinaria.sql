
Create Database Gestion_Veterinaria
Collate Latin1_General_CI_AI
Go
USE Gestion_Veterinaria

CREATE TABLE Dueños (
    IDDueño INT NOT NULL PRIMARY KEY IDENTITY (1, 1),
    Dni VARCHAR (10) UNIQUE NOT NULL CHECK (DATALENGTH (Dni) > 0),
    Apellido NVARCHAR (20) NOT NULL,
    Nombre NVARCHAR (20) NOT NULL,
    Direccion NVARCHAR (100) NOT NULL,
    Telefono VARCHAR (20) NOT NULL CHECK (DATALENGTH (Telefono) > 0),
    Email NVARCHAR(100) NOT NULL,
    FechaRegistro DATE NOT NULL DEFAULT (GETDATE()),
    Activo BIT NOT NULL DEFAULT 1
);
GO

CREATE TABLE Especies (
    IDEspecie INT NOT NULL PRIMARY KEY IDENTITY (1, 1),
    NombreEspecie NVARCHAR(100) UNIQUE NOT NULL,
    Caracteristicas NVARCHAR(100) NOT NULL
);
GO

CREATE TABLE Razas (
    IDRaza INT NOT NULL PRIMARY KEY IDENTITY (1, 1),
    IDEspecie INT NOT NULL FOREIGN KEY REFERENCES Especies(IDEspecie),
    NombreRaza NVARCHAR(100) UNIQUE NOT NULL,
    UNIQUE (IDEspecie, NombreRaza)
);
GO

CREATE TABLE Mascotas (                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                      
    NroHistoriaClinica INT NOT NULL PRIMARY KEY IDENTITY (1, 1),
    IDDueño INT NOT NULL FOREIGN KEY REFERENCES Dueños(IDDueño),
    IDRaza INT NOT NULL FOREIGN KEY REFERENCES Razas(IDRaza),    
    Nombre NVARCHAR(50) NOT NULL,
    Sexo NVARCHAR(20) NOT NULL,
    Color NVARCHAR(30) NOT NULL,
    Peso DECIMAL(5,2) NOT NULL CHECK (Peso > 0),    
    FechaRegistro DATE NOT NULL DEFAULT (GETDATE()),
    Activo BIT NOT NULL DEFAULT 1
);
GO

CREATE TABLE EspecialidadesVeterinarios (
    IDEspecialidad INT NOT NULL PRIMARY KEY IDENTITY(1, 1),
    NombreEspecialidad NVARCHAR(100) UNIQUE NOT NULL
);
GO

CREATE TABLE Veterinarios (
    IDVeterinario INT NOT NULL PRIMARY KEY IDENTITY(1, 1),
    Dni BIGINT UNIQUE NOT NULL CHECK (DATALENGTH (Dni) > 0),
    Apellido NVARCHAR(50) NOT NULL,
    Nombre NVARCHAR(50) NOT NULL,
    Direccion NVARCHAR(100) NOT NULL,
    Telefono BIGINT NOT NULL CHECK (DATALENGTH (Telefono) > 0),
    Email NVARCHAR(100) NOT NULL,
    MatriculaNacional BIGINT UNIQUE NOT NULL CHECK (MatriculaNacional > 1),
    MatriculaProvincial BIGINT UNIQUE NOT NULL CHECK (MatriculaProvincial > 1),
    IDEspecialidad INT NOT NULL FOREIGN KEY REFERENCES EspecialidadesVeterinarios(IDEspecialidad),
    FechaRegistro DATE NOT NULL DEFAULT (GETDATE()),
    Activo BIT NOT NULL DEFAULT 1
);
GO

CREATE TABLE EstadoTurnos (
    IDEstadoTurno INT NOT NULL PRIMARY KEY IDENTITY(1, 1),
    TipoEstado NVARCHAR(50) NOT NULL UNIQUE 
);
GO

CREATE TABLE Turnos (
    IDTurno INT NOT NULL PRIMARY KEY IDENTITY(1, 1),
    FechaHoraTurno DATETIME NOT NULL DEFAULT (GETDATE()),
    NroHistoriaClinica INT NOT NULL FOREIGN KEY REFERENCES Mascotas(NroHistoriaClinica),
    IDVeterinario INT NOT NULL FOREIGN KEY REFERENCES Veterinarios(IDVeterinario),
    MotivoConsulta NVARCHAR(300) NOT NULL,
    IDEstadoTurno INT NOT NULL FOREIGN KEY REFERENCES EstadoTurnos(IDEstadoTurno),
    FechaRegistro DATE NOT NULL DEFAULT (GETDATE()),
    Activo BIT NOT NULL DEFAULT 1   
);
GO

CREATE TABLE HistoriasClinicas (
    IDRegistro INT NOT NULL PRIMARY KEY IDENTITY(1, 1),
    NroHistoriaClinica INT NOT NULL FOREIGN KEY REFERENCES Mascotas(NroHistoriaClinica),
    IDTurno INT NOT NULL FOREIGN KEY REFERENCES Turnos(IDTurno),
    FechaHoraCita DATETIME NOT NULL DEFAULT (GETDATE()),
    Sintomas NVARCHAR(255) NOT NULL,
    Diagnostico NVARCHAR(255) NOT NULL,
    Tratamiento NVARCHAR(255) NOT NULL,
    Medicacion NVARCHAR(255),
    Observaciones NVARCHAR(255),
    FechaRegistro DATE NOT NULL DEFAULT (GETDATE()),
    Activo BIT NOT NULL DEFAULT 1   
);
GO

CREATE TABLE MetodosPagos (
    IDMetodosPago INT NOT NULL PRIMARY KEY IDENTITY(1, 1),
    TipoMetodosPago NVARCHAR(50) NOT NULL UNIQUE
);
GO

CREATE TABLE Pagos (
    IDPago INT NOT NULL PRIMARY KEY IDENTITY(1, 1),
    IDRegistro INT NOT NULL FOREIGN KEY REFERENCES HistoriasClinicas(IDRegistro) UNIQUE,
    FechaHoraPago DATETIME NOT NULL DEFAULT (GETDATE()),
    IDMetodosPago INT NOT NULL FOREIGN KEY REFERENCES MetodosPagos(IDMetodosPago),
    ImporteTotal MONEY NOT NULL CHECK (ImporteTotal > 0),
    Pagado BIT NOT NULL DEFAULT 0,
    Detalles NVARCHAR(300),
    FechaRegistro DATE NOT NULL DEFAULT (GETDATE()),
    Activo BIT NOT NULL DEFAULT 1
);
GO