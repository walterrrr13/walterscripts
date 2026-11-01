# Bucle principal para mantener el menú abierto hasta pulsar 0
do {
    Clear-Host
    Write-Host "=============================="
    Write-Host "   MENU DE REGISTROS DE EVENTOS"
    Write-Host "=============================="
    
    # Obtener los registros que tienen eventos
    $logs = Get-WinEvent -ListLog * | Where-Object { $_.RecordCount -gt 0 }
    
    # Mostrar el menú de forma sencilla
    for ($i = 0; $i -lt $logs.Count; $i++) {
        $num = $i + 1
        Write-Host "$num. $($logs[$i].LogName)"
    }
    
    Write-Host "0. Salir"
    Write-Host "------------------------------"
    
    # Leer la opción introducida por el usuario
    $opcion = Read-Host "Elige una opcion"
    
    # Si pulsa 0, salimos del script
    if ($opcion -eq "0") {
        Write-Host "Saliendo del programa..."
        break
    }
    
    # Comprobar si la opción es un número válido del menú
    if ($opcion -match '^[0-9]+$' -and [int]$opcion -ge 1 -and [int]$opcion -le $logs.Count) {
        # Obtener el nombre del registro elegido (restando 1 porque los arrays empiezan en 0)
        $nombreLog = $logs[[int]$opcion - 1].LogName
        
        Clear-Host
        Write-Host "--- Registro: $nombreLog ---"
        
        # Obtener todos los eventos de ese registro para contar cuántos hay
        $todos = Get-WinEvent -LogName $nombreLog
        $totalEventos = $todos.Count
        
        Write-Host "Total de eventos: $totalEventos"
        Write-Host "Ultimos 12 registros:"
        Write-Host "----------------------------------------"
        
        # Mostrar los últimos 12 eventos de forma sencilla
        Get-WinEvent -LogName $nombreLog -MaxEvents 12 | ForEach-Object {
            Write-Host "Fecha: $($_.TimeCreated) | ID: $($_.Id)"
        }
        
        Write-Host "----------------------------------------"
        Read-Host "Pulsa ENTER para volver al menu"
    } 
    else {
        # Si escribe algo incorrecto
        Write-Host "Opcion no valida. Pulsa ENTER para continuar."
        Read-Host
    }

} while ($true)