###############################################################################
# tested on macos with conda libs
###############################################################################

# be carful of protobuf versions
micromamba install protobuf
micromamba install gperftools
micromamba install capstone
micromamba install libpng
micromamba install hdf5

###############################################################################

export PYTHON_CONFIG=$(which python3-config)
# export LD_LIBRARY_PATH="$CONDA_PREFIX/lib:$LD_LIBRARY_PATH"
export PKG_CONFIG_PATH="$CONDA_PREFIX/lib/pkgconfig:$PKG_CONFIG_PATH"
export CC=/usr/bin/clang
export CXX=/usr/bin/clang++

TARGET=ARM_RISCV
# TARGET=ALL
# TARGET=RISCV

# macos
alias nproc="sysctl -n hw.physicalcpu"

scons --no-colors -j$(nproc) build/$TARGET/gem5.opt
scons build/$TARGET/compile_commands.json

###############################################################################

# optional: cp files for python type-hint
cp build/$TARGET/python/m5/defines.py src/python/m5/
cp build/$TARGET/python/m5/info.py src/python/m5/
# check more in `./stubgen`

# optional: gen types
gem5.opt util/gem5-stubgen.py

###############################################################################
