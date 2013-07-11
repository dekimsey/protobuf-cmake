
if exist build rmdir /s /q build
mkdir build
cd build
cmake -DPROTOBUF_ROOT=d:/work/protobuf-2.4.1 -DCMAKE_BUILD_TYPE=Release -G "MinGW Makefiles" ..
make
cd ..
