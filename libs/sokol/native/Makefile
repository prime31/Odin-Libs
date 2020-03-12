

all: gl metal cleanup
gl: build_gl build_gl_dynamic cleanup
metal: build_metal build_metal_dynamic cleanup

build_gl:
	cc sokol_gl.c -fPIC -c -o sokol_gl.o

build_gl_dynamic:
	cc -framework OpenGL -framework Cocoa -framework QuartzCore -L../../flextgl/native -lflextgl -dynamiclib -o libsokol_gl.dylib sokol_gl.o
	cp libsokol_gl.dylib ../../../projects/


build_metal:
	clang sokol_metal.c -DSOKOL_METAL `sdl2-config --cflags` -ObjC -fPIC -c -fobjc-arc -o sokol_metal.o

build_metal_dynamic:
	cc -fobjc-arc `sdl2-config --libs` -framework Metal -framework MetalKit -framework Cocoa -framework Foundation -framework QuartzCore -dynamiclib -o libsokol_metal.dylib sokol_metal.o
	cp libsokol_metal.dylib ../../../projects/


cleanup:
	rm *.o
