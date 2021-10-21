@ECHO OFF

title EXECUTANDO %1 %2

SET VAR_NOMEARQUIVO=%1
SET VAR_ANOMES=%2

set user="user"
set pass="password"
set instancia="instancia"
:: pasta da rede
SET PASTA_REDE=\\minha_pasta_na_rede
:: local de controle das variaveis
SET LOCAL_PATH=C:\Dados\colab\monitora\_data
:: arquivo com as variaveis
SET FILE=%LOCAL_PATH%\controle_data.txt
:: local das queries
SET LOCAL_QUERIES=C:\Dados\colab\queries\GENERAL
:: Start Tratamento para nome do arquivo e anomes
set #=%VAR_NOMEARQUIVO%
set length=0
set less_ext=3
:loop
if defined # (
    rem Encurtar a corda por um caractere
    set #=%#:~1%
    rem incrementa a string contando a variavel %length%
    set /A length += 1
    rem repetir ate string ser null
    goto loop
)
set /A new_length_arquivo=%length% - 3
set /A new_length_ddd=%length% - 2
call set n_arquivo=%%VAR_NOMEARQUIVO:~0,%new_length_arquivo%%%
call set nr_ddd=%%VAR_NOMEARQUIVO:~%new_length_ddd%,2%%
:: nome da querie recebida
SET QUERY_NAME=%LOCAL_QUERIES%\%n_arquivo%.sql

FOR /F "tokens=1-7 delims=|" %%A in ('TYPE %FILE%') DO (
  IF %VAR_ANOMES% EQU %%A CALL :process %%A %%B %%C %%D %%E %%F %%G
)

:process
echo %1
IF %VAR_ANOMES% EQU %1 (
:: conectando via SQLPLUS e chamando a query + variaveis
SQLPLUS %user%/%pass%@%instancia% @%QUERY_NAME% %1 %2 %3 %4 %5 %6 %7 %nr_ddd%
COPY C:\Dados\colab\extractions\%VAR_NOMEARQUIVO%_%VAR_ANOMES%.csv %PASTA_REDE%\%VAR_NOMEARQUIVO%_%VAR_ANOMES%.csv
GOTO end
EXIT
)

:end
exit

::SET ANOMES=%1
::SET DT_INI_TIPO1=%2
::SET DT_FIM_TIPO1=%3
::SET DT_INI_MES_LESS1=%4
::SET DT_INI_MES_PLUS1=%5
::SET DT_FIM_MES_PLUS2=%6
::SET DT_INI_MES_PLUS3_02=%7
