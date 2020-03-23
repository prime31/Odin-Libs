cl -nologo -MT -TC -O2 -c flextGL.c
lib -nologo flextGL.obj -out:flextGL.lib

del flextGL.obj