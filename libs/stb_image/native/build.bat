cl -nologo -MT -TC -O2 -c stb_image.c
lib -nologo stb_image.obj -out:stb_image.lib

del stb_image.obj