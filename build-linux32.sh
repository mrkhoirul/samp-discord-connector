#!/bin/bash
# Linux i386 build for discord-connector (WSL Ubuntu 22.04)
set -euo pipefail

cd "$(dirname "$0")"
rm -rf build-linux32

cmake -S . -B build-linux32 \
  -DCMAKE_BUILD_TYPE=Release \
  -DGH_ACBUILD=TRUE \
  -DUSING_BOOST_NO_CONAN=TRUE \
  -DUSING_OPENSSL_NO_CONAN=TRUE \
  -DBOOST_ROOT=/usr \
  -DOPENSSL_ROOT_DIR=/usr \
  -DCMAKE_C_FLAGS=-m32 \
  -DCMAKE_CXX_FLAGS=-m32 \
  -DCMAKE_EXE_LINKER_FLAGS=-m32 \
  -DCMAKE_SHARED_LINKER_FLAGS=-m32

cmake --build build-linux32 --parallel "$(nproc)"

echo "=== artifact ==="
file build-linux32/artifact/plugins/* 2>/dev/null || find build-linux32 -name '*.so' -exec file {} \;
