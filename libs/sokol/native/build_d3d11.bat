cl -nologo -MT -TC -O2 -c sokol_d3d11.c
lib -nologo sokol_d3d11.obj -out:sokol_d3d11.lib

del sokol_d3d11.obj
