# micromamba install scons
# micromamba install pybind11
# micromamba install gperftools # for tcmalloc
# micromamba install protobuf # 4.25.3
# micromamba install hdf5
# apt install -y libcapstone-dev

###############################################################################

export PYTHON_CONFIG=$(which python3-config)
export LD_LIBRARY_PATH="$CONDA_PREFIX/lib:$LD_LIBRARY_PATH"
export PKG_CONFIG_PATH="$CONDA_PREFIX/lib/pkgconfig:$PKG_CONFIG_PATH"
export CC=clang
export CXX=clang++

scons -j`nproc` build/RISCV/gem5.opt

# scons -j`nproc` build/ALL/gem5.opt

###############################################################################

# TODO: for python3.12, seems need more latest pybind11 ?
#
# Exception ignored in tp_clear of: <class 'MetaSimObject'>
# TypeError: Missed attribute 'n_fields' of type time.struct_time
#
# TypeError: Missed attribute 'n_fields' of type time.struct_time
# Exception ignored in tp_clear of: <class 'MetaSimObject'>
#

###############################################################################
