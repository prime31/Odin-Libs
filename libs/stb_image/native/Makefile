

all: build build_static

build:
	cc -fPIC -c -o stb_image.o -c stb_image.c

build_static:
	libtool -static -o libstbimage.a stb_image.o
	rm *.o