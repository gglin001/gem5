###############################################################################

# for vscode
cat >>/root/.bashrc <<-EOF
export PATH=\${EXT_PATH}:\$PATH
export PYTHONPATH=\${EXT_PYTHONPATH}:\$PYTHONPATH
EOF

cat >>/root/.bashrc <<-EOF
export LD_LIBRARY_PATH=\${CONDA_PREFIX}/lib:\${LD_LIBRARY_PATH}
EOF

###############################################################################

# export CCFLAGS_EXTRA="-I$CONDA_PREFIX/include -I$CONDA_PREFIX/include/python3.11"
# export CCFLAGS_EXTRA="-I/Library/Developer/CommandLineTools/SDKs/MacOSX14.4.sdk/usr/include"

###############################################################################

export PYTHON_CONFIG=$(which python3-config)
export LD_LIBRARY_PATH="$CONDA_PREFIX/lib:$LD_LIBRARY_PATH"
export PKG_CONFIG_PATH="$CONDA_PREFIX/lib/pkgconfig:$PKG_CONFIG_PATH"
export CCFLAGS_EXTRA="-isysroot /Library/Developer/CommandLineTools/SDKs/MacOSX14.4.sdk -L/Users/allen/micromamba/envs/pyenv/lib"
export CC=clang
export CXX=clang++

TARGET=ARM_RISCV
# TARGET=ALL
# TARGET=RISCV

scons -j$(nproc) build/$TARGET/gem5.opt
scons build/$TARGET/compile_commands.json

###############################################################################

# optional: cp files for python type-hint
cp build/$TARGET/python/m5/defines.py src/python/m5/
cp build/$TARGET/python/m5/info.py src/python/m5/
# check more in `./stubgen`

# optional: gen types
gem5.opt util/gem5-stubgen.py

###############################################################################
