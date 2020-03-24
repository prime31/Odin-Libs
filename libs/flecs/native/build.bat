IF EXIST flecs_git GOTO SKIP_GIT
git clone --depth 1 https://github.com/SanderMertens/flecs flecs_git
:SKIP_GIT

cd flecs_git
mkdir build
cd build
cl -nologo -MT -TC -O2 -c ..\src\*.c /I..\Include -DFLECS_IMPL
lib -nologo *.obj -out:..\..\flecs.lib

rem https://stackoverflow.com/questions/31763558/how-to-build-static-and-dynamic-libraries-from-obj-files-for-visual-c