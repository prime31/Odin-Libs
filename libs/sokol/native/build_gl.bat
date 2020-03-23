cl -nologo -MT -TC -O2 -c sokol_gl.c
lib -nologo sokol_gl.obj -out:sokol_gl.lib

del sokol_gl.obj


rem "C:\Program Files (x86)\Windows Kits\10\Lib\10.0.18362.0\um\x64\OpenGL32.Lib"
rem cl clear-sapp.c ..\libs\sokol\sokol.c /DSOKOL_GLCORE33 /I..\..\sokol /I..\libs kernel32.lib user32.lib gdi32.lib