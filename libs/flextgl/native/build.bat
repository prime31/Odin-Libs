cl -nologo -MT -TC -O2 -c flextGL.c /link OpenGL32.lib
lib -nologo flextGL.obj -out:flextGL.lib

del flextGL.obj