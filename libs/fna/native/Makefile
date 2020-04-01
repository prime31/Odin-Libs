TARGET = build

##---------------------------------------------------------------------
## BUILD FLAGS PER PLATFORM
##---------------------------------------------------------------------
UNAME_S := $(shell uname -s)

ifeq ($(UNAME_S), Linux)
	TARGET += copy_linux_shared
else ifeq ($(UNAME_S), Darwin)
	TARGET += copy_mac_shared
endif

TARGET += clean


all: $(TARGET)

copy_mac_shared:
	cp fna3d_git/*.dylib ./

copy_linux_shared:
	cp fna3d_git/*.so ./

build:
	[ -d fna3d_git ] || git clone --recursive --depth 1 https://github.com/FNA-XNA/FNA3D.git fna3d_git
	(cd fna3d_git ; cmake . ; make)

clean:
	rm -rf fna3d_git
