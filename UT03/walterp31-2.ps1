# Recibe las fechas de inicio y fin obligatorias al ejecutar el script
param(
    [Parameter(Mandatory=$true)]
    [datetime]$FechaInicio,

    [Parameter(Mandatory=$true)]
    [datetime]$FechaFin
)

# Imprime el título del reporte
Write-Host "Eventos de Inicio de Sesión:"

# Obtiene del registro de Seguridad de Windows los eventos de login exitoso (ID 4624) en el rango de fechas
$eventos = Get-WinEvent -FilterHashtable @{
    LogName   = 'Security'
    ID        = 4624
    StartTime = $FechaInicio
    EndTime   = $FechaFin
} -ErrorAction SilentlyContinue

# Procesa cada evento encontrado
foreach ($evento in $eventos) {
    $xml = [xml]$evento.ToXml()
    $usuario = ($xml.Event.EventData.Data | Where-Object { $_.Name -eq 'TargetUserName' }).'#text'

    # Muestra el resultado ignorando cuentas de sistema (SYSTEM)
    if ($usuario -and $usuario -ne 'SYSTEM' -and $usuario -ne 'NT AUTHORITY\SYSTEM') {
        $fecha = $evento.TimeCreated.ToString("MM/dd/yyyy HH:mm:ss")
        Write-Host "Fecha: $fecha - Usuario: $usuario"
    }
}