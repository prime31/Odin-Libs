
all: build build_dynamic_flextgl

build:
	cc -fPIC -c -o flextGL.o flextGL.c

build_dynamic_flextgl:
	cc -I. -framework OpenGL -framework Cocoa  -dynamiclib -o libflextgl.dylib flextGL.o
	cp libflextgl.dylib ../../../projects/
	rm *.o