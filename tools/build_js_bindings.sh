#! /usr/bin/env bash

set -e

tools/cleanup.sh
tools/autogen.sh
./configure --enable-js-wrappers --disable-swig-python --disable-swig-java $DEBUG_WALLY
num_jobs=4
if [ -f /proc/cpuinfo ]; then
    num_jobs=$(grep ^processor /proc/cpuinfo | wc -l)
fi
make -o configure clean
make -o configure -j $num_jobs
# test that make twice works
make -o configure

./tools/cleanup.sh