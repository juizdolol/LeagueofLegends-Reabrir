📌 IMPORTANTE – Diretório Correto de Instalação do LoL

PATCH / LOCAL DE INSTALAÇÃO OBRIGATÓRIO DO LEAGUE OF LEGENDS:

C:\Program Files\Riot Games


⚠️ ATENÇÃO:
O League of Legends não usa esse diretório por padrão.
Para o tramites.ps1 funcionar corretamente:

✔ Instale o LoL em:

C:\Program Files\Riot Games


OU

✔ Edite o arquivo tramites.ps1 e coloque o caminho exato onde seu LoL está instalado.

O script precisa desse caminho correto para limpar o cache, encontrar as pastas internas e funcionar sem erros.

⚙️ League Of Legends – Fechar Cliente ao Iniciar Partida

Reabrir Cliente ao Finalizar Partida
Modo Loop Automático (tramites.ps1)

Autor: JUÍZ DO LOL 👨‍⚖️

📝 Descrição:

Script PowerShell para automatizar o comportamento do client do League of Legends, eliminando travamentos e acelerando o fluxo entre partidas.

Ideal para quem quer:

Evitar bugs de reconexão

Melhorar desempenho

Fechar o client automaticamente ao iniciar o jogo

Reabrir o client ao final da partida

Rodar em loop infinito sem reiniciar o PowerShell

🧠 Funções principais

Detecta automaticamente o processo League of Legends.exe

Aguarda 10 segundos após o início da partida

Fecha automaticamente:

LeagueClient.exe

RiotClientServices.exe

LeagueCrashHandler64.exe

Limpa cache seguro do LoL e do Riot Client

Quando o jogo fecha → reabre o Riot Client automaticamente

Loop infinito e leve, sem aumentar uso de RAM

💻 Como usar

Salve o arquivo como tramites.ps1

Clique com o botão direito → Criar atalho

Em Destino, coloque:

powershell.exe -ExecutionPolicy Bypass -File "C:\CAMINHO\PARA\tramites.ps1"


Vá em Propriedades → Alterar ícone e escolha um ícone do LoL

Execute sempre que for jogar

💜 Apoie o projeto

Pix: https://pixgg.com/juiz_2026

Twitch: https://twitch.tv/juiz_do_lol_2026
