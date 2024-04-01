# micromamba install scons
# micromamba install pybind11
# micromamba install gperftools # for tcmalloc
# micromamba install protobuf # 4.25.3
# micromamba install hdf5
# apt install -y libcapstone-dev

# for vscode
cat >>/root/.bashrc <<-EOF
export PATH=\${EXT_PATH}:\$PATH
export PYTHONPATH=\${EXT_PYTHONPATH}:\$PYTHONPATH
EOF

cat >>/root/.bashrc <<-EOF
export LD_LIBRARY_PATH=\${CONDA_PREFIX}/lib:\${LD_LIBRARY_PATH}
EOF

###############################################################################

export PYTHON_CONFIG=$(which python3-config)
export LD_LIBRARY_PATH="$CONDA_PREFIX/lib:$LD_LIBRARY_PATH"
export PKG_CONFIG_PATH="$CONDA_PREFIX/lib/pkgconfig:$PKG_CONFIG_PATH"
export CC=clang
export CXX=clang++

scons -j$(nproc) build/ALL/gem5.opt
scons build/ALL/compile_commands.json
# or
# scons -j`nproc` build/RISCV/gem5.opt
# scons build/RISCV/compile_commands.json

# optional: cp files for python type-hint
cp build/ALL/python/m5/defines.py src/python/m5/
cp build/ALL/python/m5/info.py src/python/m5/
# or
# cp build/RISCV/python/m5/defines.py src/python/m5/
# cp build/RISCV/python/m5/info.py src/python/m5/

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

# skip pre-commit
git commit --no-verify -m "misc: wip"

###############################################################################
