IF EXIST cimgui_git GOTO SKIP_GIT
git clone --recursive --depth 1 --single-branch --branch docking_inter https://github.com/cimgui/cimgui.git cimgui_git
:SKIP_GIT

cd cimgui_git
mkdir build
cd build
cmake ..



rem none of this works
cmake -DCIMGUI_DEFINE_ENUMS_AND_STRUCTS=1 -DIMGUI_IMPL_API= -DIMPL_SDL=yes -DIMPL_OPENGL3=yes ..


cl -nologo -MT -TC -O2 -c ..\imgui\examples\imgui_impl_sdl.cpp ..\imgui\examples\imgui_impl_opengl3.cpp /I..\imgui
lib -nologo *.obj -out:..\..\flecs.lib

lib -nologo *.o -out:imgui_impl.lib
