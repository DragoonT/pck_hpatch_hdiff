@echo off
setlocal enabledelayedexpansion

set "OLD_PATH=C:\path\to\old"
set "PATCH_PATH=C:\path\to\hdiff"
set "OUTPUT_PATH=C:\path\to\output"
set "HPATCHZ=C:\path\to\hpatchz.exe"

if not exist "%OUTPUT_PATH%" (
    mkdir "%OUTPUT_PATH%"
)

echo ===========================
echo Starting patch process...
echo ===========================

for %%F in ("%OLD_PATH%\*") do (
    set "FILENAME=%%~nxF"
    set "PATCH_FILE=%PATCH_PATH%\!FILENAME!.hdiff"
    set "OUTPUT_FILE=%OUTPUT_PATH%\!FILENAME!"

    if exist "!PATCH_FILE!" (
        echo Patching: !FILENAME!
        "%HPATCHZ%" "%%F" "!PATCH_FILE!" "!OUTPUT_FILE!"
        if errorlevel 1 (
            echo ERROR patching !FILENAME!
        )
    ) else (
        echo Copying (unchanged): !FILENAME!
        copy "%%F" "!OUTPUT_FILE!" >nul
    )
)

echo ===========================
echo Done!
echo ===========================

pause
