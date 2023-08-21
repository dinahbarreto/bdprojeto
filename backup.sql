@echo off
setlocal

rem Configurações do MySQL
set "usuario=root"
set "senha=1234"
set "banco=projeto"
set "caminho_backup=C:\Backups\bkprojeto"
set "data_hora=%date:~10,4%%date:~7,2%%date:~4,2%_%time:~0,2%%time:~3,2%%time:~6,2%"

rem Comando mysqldump para criar o backup
mysqldump -u%usuario% -p%senha% %banco% > "%caminho_backup%\backup_%data_hora%.sql"

rem Verifica se o comando foi executado com sucesso
if %errorlevel% equ 0 (
  echo Backup do banco de dados %banco% criado com sucesso em %caminho_backup%\backup_%data_hora%.sql
) else (
  echo Erro ao criar o backup do banco de dados %banco%.
)

endlocal
