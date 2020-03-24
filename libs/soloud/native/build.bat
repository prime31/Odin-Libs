@echo off
dumpbin /exports soloud_x64.dll > exports.txt
echo LIBRARY soloud_x64 > soloud_x64.def
echo EXPORTS >> soloud_x64.def
for /f "skip=19 tokens=4" %%A in (exports.txt) do echo %%A >> soloud_x64.def

lib /def:soloud_x64.def /out:soloud_x64.lib /machine:x64