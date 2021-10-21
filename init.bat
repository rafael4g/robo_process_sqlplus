:: PROCESS 01
:: Arquivo contendo loop maximo de 10horas.
:: processo realizado a cada 10segundos.
@ECHO OFF
:: Titulo da aplicação
TITLE INICIALIZACAO

set/a a =0
:comeco
cls
echo %a%
set/a a = %a%+1
timeout 10

if %a% GTR 43200 goto end
:: chama proximo arquivo em background
start /min call C:\Dados\colab\monitora\get_file.bat
goto comeco
:end
pause>nul
