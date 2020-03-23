cl -nologo -MT -TC -O2 -c fontstash.c
lib -nologo fontstash.obj -out:fontstash.lib

del fontstash.obj