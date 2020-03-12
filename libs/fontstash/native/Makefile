

all: build build_static

build:
	cc -fPIC -c -o fontstash.o -c fontstash.c

build_static:
	libtool -static -o libfontstash.a fontstash.o
	rm *.o
