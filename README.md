# Data Center Administration Tools

#### Integrantes: *Alejandro Mejía, Julio Prado, Nicolas Cardona.*

## Descripción del Proyecto

Herramientas de administración para data center implementadas en **PowerShell** (Windows) y **BASH** (Linux). Cada herramienta proporciona un menú interactivo con funcionalidades esenciales para facilitar las labores del administrador de sistemas.

## Funcionalidades

Cada una de las herramientas despliega un menú con las siguientes opciones:

### 1. Usuarios del Sistema y Último Login
Despliega los usuarios creados en el sistema, junto con la fecha y hora de su último ingreso (login).

### 2. Discos y Volúmenes Conectados
Despliega los filesystems o discos conectados a la máquina. Incluye para cada disco:
- Tamaño total (en bytes)
- Cantidad de espacio libre (en bytes)

### 3. Top 10 Archivos Más Grandes
Despliega el nombre y tamaño de los diez archivos más grandes almacenados en un disco o filesystem que el usuario especifica. Los archivos se muestran con su trayectoria completa.

### 4. Información de Memoria RAM y Swap
Muestra:
- Cantidad de memoria libre (en bytes y porcentaje)
- Cantidad de espacio de swap en uso (en bytes y porcentaje)

### 5. Backup a USB
Realiza una copia de seguridad de un directorio especificado a una memoria USB. Además de los archivos, se almacena un catálogo (CSV) que contiene:
- Nombres de los archivos
- Ruta completa
- Tamaño en bytes
- Fecha de última modificación

## Uso

### PowerShell (Windows)

#### Configuración Inicial
1. Abrir PowerShell como **Administrador**
2. Habilitar la ejecución de scripts:
```powershell
Set-ExecutionPolicy -ExecutionPolicy RemoteSigned -Scope CurrentUser
```

#### Ejecución
```powershell
cd ruta\al\proyecto\powershell
.\menu.ps1
```

#### Permisos Necesarios
- **Opción 1 (Usuarios)**: Requiere permisos de administrador para leer el log de seguridad
- **Opción 5 (Backup)**: Requiere permisos de lectura en origen y escritura en destino

---

### BASH (Linux)

#### Configuración Inicial
1. Dar permisos de ejecución a los scripts:
```bash
cd ruta/al/proyecto/bash
chmod +x *.sh
```

#### Ejecución
```bash
./menu.sh
```

#### Permisos Necesarios
- **Opción 1 (Usuarios)**: Puede requerir permisos para leer `/var/log/wtmp`
- **Opción 3 (Archivos grandes)**: Puede requerir sudo para acceder a ciertos directorios
- **Opción 5 (Backup)**: Requiere permisos de lectura en origen y escritura en destino

---
