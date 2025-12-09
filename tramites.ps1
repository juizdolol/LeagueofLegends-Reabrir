# AutoLeague-Tramites-FIXED.ps1
# Versão corrigida para evitar problemas de parsing ($env:... em strings)
# Salve em UTF-8 BOM. Execute como Administrador.
$processoJogo = "League of Legends"
$processosFechar = @(
    "LeagueClient",
    "RiotClientServices",
    "LeagueCrashHandler64"
)

$riotPath = "C:\Program Files\Riot Games\Riot Client\RiotClientServices.exe"
$riotArgs = "--launch-product=league_of_legends --launch-patchline=live"

# Usar variável intermediária e Join-Path para evitar problemas de parsing
$localApp = $env:LOCALAPPDATA
$cacheRiot = Join-Path $localApp "Riot Games\Riot Client"
$cacheLogs = "C:\Program Files\Riot Games\League of Legends\Logs"
$cacheLoL  = "C:\Program Files\Riot Games\League of Legends\Cache"

function Limpar-Cache {
    Write-Host "Limpando cache do LoL e do Riot Client..." -ForegroundColor Yellow

    $pastas = @($cacheRiot, $cacheLogs, $cacheLoL)

    foreach ($pasta in $pastas) {
        if (Test-Path $pasta) {
            try {
                Remove-Item -Path $pasta -Recurse -Force -ErrorAction Stop
                Write-Host ("Limpou: {0}" -f $pasta) -ForegroundColor Green
            } catch {
                Write-Host ("Erro ao limpar: {0} - {1}" -f $pasta, $_.Exception.Message) -ForegroundColor Red
            }
        } else {
            Write-Host ("Pasta não encontrada (OK): {0}" -f $pasta) -ForegroundColor DarkYellow
        }
    }
}

Write-Host "AutoLeague iniciado. Monitorando o League of Legends..." -ForegroundColor Cyan

while ($true) {
    $jogo = Get-Process -Name $processoJogo -ErrorAction SilentlyContinue

    if ($jogo) {
        Write-Host ("{0} - Jogo detectado! Fechando Riot Client em 10s..." -f (Get-Date -Format 'HH:mm:ss')) -ForegroundColor Yellow
        Start-Sleep -Seconds 10

        foreach ($proc in $processosFechar) {
            $p = Get-Process -Name $proc -ErrorAction SilentlyContinue
            if ($p) {
                try {
                    Stop-Process -Name $proc -Force -ErrorAction Stop
                    Write-Host ("Processo finalizado: {0}" -f $proc) -ForegroundColor Green
                } catch {
                    Write-Host ("Não foi possível finalizar {0}: {1}" -f $proc, $_.Exception.Message) -ForegroundColor Red
                }
            }
        }

        # Limpa cache assim que o client é fechado
        Limpar-Cache
    }

    # Quando o jogo fechar → Reabre Riot Client
    if (-not (Get-Process -Name $processoJogo -ErrorAction SilentlyContinue)) {
        Write-Host ("{0} - Jogo fechado! Reabrindo Riot Client..." -f (Get-Date -Format 'HH:mm:ss')) -ForegroundColor Cyan

        try {
            Start-Process -FilePath $riotPath -ArgumentList $riotArgs
            Write-Host "Riot Client iniciado!" -ForegroundColor Green
        } catch {
            Write-Host ("Erro ao iniciar Riot Client: {0}" -f $_.Exception.Message) -ForegroundColor Red
        }

        Write-Host "Monitorando novamente..." -ForegroundColor Magenta
        Start-Sleep -Seconds 5
    }

    Start-Sleep -Milliseconds 400
}
