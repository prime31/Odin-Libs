cl -nologo -MT -TC -O2 -c sokol_gl.c
lib -nologo sokol_gl.obj -out:sokol_gl.lib

del sokol_gl.obj
