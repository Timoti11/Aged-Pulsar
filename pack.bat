@echo off
setlocal

set ZIP_NAME=Aged_Pulsar_dev.zip
set MRPACK_NAME=Aged_Pulsar_dev.mrpack
set TMP_DIR=_tmp_pack_dir

if exist "%TMP_DIR%" rmdir /s /q "%TMP_DIR%"

mkdir "%TMP_DIR%"

for %%F in (*) do (
    if /I not "%%F"=="pack.bat" (
        copy "%%F" "%TMP_DIR%\"
    )
)

for /d %%D in (*) do (
    if /I not "%%D"=="%TMP_DIR%" (
        xcopy "%%D" "%TMP_DIR%\%%D\" /E /I /H /Y >nul
    )
)

powershell Compress-Archive -Path "%TMP_DIR%\*" -DestinationPath "%ZIP_NAME%"

rmdir /s /q "%TMP_DIR%"

ren "%ZIP_NAME%" "%MRPACK_NAME%"

echo Архив готов: %MRPACK_NAME%
pause
