TARGET = build
TARGET += copy_static
TARGET += copy_mac_shared

##---------------------------------------------------------------------
## BUILD FLAGS PER PLATFORM
##---------------------------------------------------------------------
UNAME_S := $(shell uname -s)

ifeq ($(UNAME_S), Linux)
	TARGET += copy_linux_shared
	TARGET += cross_compile_win
else ifeq ($(UNAME_S), Darwin)
	TARGET += copy_mac_shared
endif

TARGET += clean


all: $(TARGET)

copy_static:
	cp flecs_git/build/libflecs_static.a ./

copy_mac_shared:
	# fix the @rpath
	install_name_tool -id @rpath/libflecs_shared.dylib flecs_git/build/libflecs_shared.dylib
	cp flecs_git/build/libflecs_shared.dylib ./

copy_linux_shared:
	cp flecs_git/build/libflecs_shared.so ./

build:
	[ -d flecs_git ] || git clone --depth 1 https://github.com/SanderMertens/flecs flecs_git
	(cd flecs_git ; mkdir build ; cd build ; cmake .. ; make)

build-wasm:
	[ -d flecs_git ] || git clone --depth 1 https://github.com/SanderMertens/flecs flecs_git
	(cd flecs_git ; mkdir build ; cd build ; emconfigure cmake .. ; emconfigure make)
	[ -d $(MODULE_FOLDER)/webgl ] || mkdir $(MODULE_FOLDER)/webgl
	cp flecs_git/build/libflecs_static.a $(MODULE_FOLDER)/webgl

cross_compile_win:
	(cd flecs_git ; rm -rf build ; mkdir build ; cd build ; cmake $(OPTS) -DCMAKE_TOOLCHAIN_FILE=../../../../via/libs/win_build/mingw-w64-x86_64.cmake .. ; make)
	[ -d $(MODULE_FOLDER)/win64 ] || mkdir $(MODULE_FOLDER)/win64
	cp flecs_git/build/libflecs_shared.dll $(MODULE_FOLDER)/win64
	cp flecs_git/build/libflecs_static.a $(MODULE_FOLDER)/win64

clean:
	rm -rf flecs_git
