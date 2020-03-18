#!/bin/bash

pushd "`dirname "$0"`"
rootdir=`pwd`
tmpdir=/tmp/libsundaowen_zstd
target=linux_x86_32
prefix=$tmpdir/$target
version=`cat version.txt`
rm -rf "$tmpdir/$version"
mkdir -p "$tmpdir/$version"
cp -rf "../$version/"* "$tmpdir/$version"
pushd "$tmpdir/$version"
rm -rf build/cmake/build
mkdir build/cmake/build
cd build/cmake/build
cmake -DBUILD64=OFF -C "$rootdir/CMakeLists.txt" -DZSTD_BUILD_PROGRAMS=OFF -DZSTD_BUILD_CONTRIB=OFF -DZSTD_BUILD_TESTS=OFF -DZSTD_USE_STATIC_RUNTIME=ON -DZSTD_BUILD_STATIC=ON -DZSTD_BUILD_SHARED=OFF -DCMAKE_INSTALL_PREFIX="$prefix" ..
cmake --build . --target install --config Release --clean-first
popd
mkdir -p "../target/include/$target"
cp -rf "$prefix/include/"* "../target/include/$target"
mkdir -p "../target/lib/$target"
cp -f "$prefix/lib/"*.a "../target/lib/$target"
popd
rm -rf "$tmpdir"
