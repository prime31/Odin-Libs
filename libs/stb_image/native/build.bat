cl -nologo -MT -TC -O2 -c stb_image.c stb_image_write.c
lib -nologo stb_image.obj stb_image_write.obj -out:stb_image.lib
#lib -nologo stb_image_write.obj -out:stb_image_write.lib

del stb_image.obj stb_image_write.obj