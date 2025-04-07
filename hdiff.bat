@echo off
setlocal enabledelayedexpansion

rem
set "old_path=C:\path\to\old"
set "hdiff_path=C:\path\to\hdiff"
set "output_path=C:\path\to\output"
set "hdiffz_exe=C:\path\to\hdiffz.exe"

if not exist "%output_path%" (
    mkdir "%output_path%"
)

for %%F in ("%hdiff_path%\*.hdiff") do (
    set "full_hdiff=%%~fF"
    set "filename=%%~nF"
    set "old_file=%old_path%\!filename!"
    set "patch_file=%output_path%\!filename!"

    if exist "!old_file!" (
        echo Patching: !filename!
        "%hdiffz_exe%" -f "!old_file!" "!full_hdiff!" "!patch_file!"
        if errorlevel 1 (
            echo ERROR patching !filename!
        )
    ) else (
        echo Skipping %%~nxF: !filename! not found in old path.
    )
)

endlocal
pause
