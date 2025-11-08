# AutoLeague-Tramites.ps1
# Autor: JUÍZ DO LOL 👨‍⚖️
# Descrição:
#  - Detecta o "League of Legends.exe"
#  - Ao detectar, aguarda 10s e fecha: LeagueClient, RiotClientServices, LeagueCrashHandler64
#  - Quando o jogo fecha, reabre o Riot Client automaticamente
#  - Loop infinito real sem recursão (sem gasto de RAM)
#
#  - Apoie: https://pixgg.com/juiz_2026
#  - Twitch: https://twitch.tv/juiz_do_lol_2026

$processoJogo = "League of Legends"
$processosFechar = @("LeagueClient", "RiotClientServices", "LeagueCrashHandler64")
$riotPath = "C:\Program Files\Riot Games\Riot Client\RiotClientServices.exe"
$riotArgs = "--launch-product=league_of_legends --launch-patchline=live"

Write-Host "===================================================" -ForegroundColor Cyan
Write-Host "   AutoLeague - Monitoramento iniciado" -ForegroundColor Cyan
Write-Host "===================================================" -ForegroundColor Cyan

while ($true) {

    Write-Host "$(Get-Date -Format 'HH:mm:ss') - Aguardando o League of Legends iniciar..." -ForegroundColor Yellow

    # Espera o jogo iniciar
    while (-not (Get-Process -Name $processoJogo -ErrorAction SilentlyContinue)) {
        Start-Sleep -Seconds 2
    }

    Write-Host "$(Get-Date -Format 'HH:mm:ss') - Jogo detectado! Aguardando 10s..." -ForegroundColor Yellow
    Start-Sleep -Seconds 10

    # Mata os processos
    foreach ($p in $processosFechar) {
        try {
            Stop-Process -Name $p -Force -ErrorAction Stop
            Write-Host "$(Get-Date -Format 'HH:mm:ss') - Encerrado: $p" -ForegroundColor Green
        } catch {
            Write-Host "$(Get-Date -Format 'HH:mm:ss') - Não encontrado: $p" -ForegroundColor DarkGray
        }
    }

    Write-Host "$(Get-Date -Format 'HH:mm:ss') - Aguardando o jogo fechar..." -ForegroundColor Cyan

    # Espera o jogo fechar
    while (Get-Process -Name $processoJogo -ErrorAction SilentlyContinue) {
        Start-Sleep -Seconds 2
    }

    Write-Host "$(Get-Date -Format 'HH:mm:ss') - Jogo fechado! Reabrindo Riot Client..." -ForegroundColor Cyan

    try {
        Start-Process -FilePath $riotPath -ArgumentList $riotArgs
        Write-Host "$(Get-Date -Format 'HH:mm:ss') - Riot Client iniciado com sucesso!" -ForegroundColor Green
    } catch {
        Write-Host "$(Get-Date -Format 'HH:mm:ss') - Erro ao iniciar Riot Client: $($_.Exception.Message)" -ForegroundColor Red
    }

    Write-Host "$(Get-Date -Format 'HH:mm:ss') - Monitorando novamente..." -ForegroundColor Magenta
    Start-Sleep -Seconds 5
}

