

all: build build_dynamic

build:
	cc -fPIC -c -o sokol.o -framework OpenGL -framework Cocoa -framework QuartzCore -c sokol.c

build_dynamic:
	cc -framework OpenGL -framework Cocoa -framework QuartzCore -L../../flextgl/native -lflextgl -dynamiclib -o libsokol.dylib sokol.o
	cp libsokol.dylib ../../../projects/