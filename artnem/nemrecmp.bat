@echo off
:init
cd /d %~dp0
:cmp
for /r %cd% %%i in (*.bin) do (
	rem not using forfiles this time
	echo "%%i"
	"%ProgramFiles%\KensSharp\KensSharp" --recompress=Nemesis "%%i"
)
:postcmp
pause > nul | echo Recompression done. Press any key to exit.
:EOF