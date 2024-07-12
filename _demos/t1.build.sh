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
# export DYLD_LIBRARY_PATH=/Users/allen/micromamba/envs/pyenv/lib
# export CCFLAGS_EXTRA="-isysroot /Library/Developer/CommandLineTools/SDKs/MacOSX14.4.sdk -L/Users/allen/micromamba/envs/pyenv/lib"
# export LINKFLAGS="-Wl,-rpath=$CONDA_PREFIX/lib"
# export RPATH="$CONDA_PREFIX/lib"
# export CCFLAGS_EXTRA="-isysroot /Library/Developer/CommandLineTools/SDKs/MacOSX14.4.sdk"
# export RPATH="-Wl,-rpath,/Users/allen/micromamba/envs/pyenv/lib"

###############################################################################

export PYTHON_CONFIG=$(which python3-config)
export LD_LIBRARY_PATH="$CONDA_PREFIX/lib:$LD_LIBRARY_PATH"
export PKG_CONFIG_PATH="$CONDA_PREFIX/lib/pkgconfig:$PKG_CONFIG_PATH"
export CC=/usr/bin/clang
export CXX=/usr/bin/clang++

TARGET=ARM_RISCV
# TARGET=ALL
# TARGET=RISCV

# TODO: better way to solve rpath issue
# export DYLD_LIBRARY_PATH="$CONDA_PREFIX/lib:$DYLD_LIBRARY_PATH" # not work

# not work
# mkdir -p build/$TARGET
# mkdir -p build/$TARGET/gem5.build/scons_config
# ln -s $CONDA_PREFIX/lib/libc++.1.dylib build/$TARGET/
# ln -s $CONDA_PREFIX/lib/libpython3.11.dylib build/$TARGET/
# ln -s $CONDA_PREFIX/lib/libz.1.dylib build/$TARGET/
# ln -s $CONDA_PREFIX/lib/libc++.1.dylib build/$TARGET/gem5.build/scons_config
# ln -s $CONDA_PREFIX/lib/libpython3.11.dylib build/$TARGET/gem5.build/scons_config

scons --no-colors -j$(nproc) build/$TARGET/gem5.opt
# scons --no-colors -j$(nproc) build/$TARGET/gem5.opt --verbose
scons build/$TARGET/compile_commands.json

###############################################################################

# optional: cp files for python type-hint
cp build/$TARGET/python/m5/defines.py src/python/m5/
cp build/$TARGET/python/m5/info.py src/python/m5/
# check more in `./stubgen`

# optional: gen types
gem5.opt util/gem5-stubgen.py

###############################################################################

# EXE=build/ARM_RISCV/gem5.build/scons_config/conftest_2176b2d932a60acfa5b4079f6e5ab92b_0_ec29e9f2931517fd22ea214641da1cb9
# otool -L $EXE
# install_name_tool -change "@rpath/libc++.1.dylib" "/Users/allen/micromamba/envs/pyenv/lib/libc++.1.dylib" $EXE
# install_name_tool -change "@rpath/libpython3.11.dylib" "/Users/allen/micromamba/envs/pyenv/lib/libpython3.11.dylib" $EXE
# $EXE

###############################################################################

# EXE=$PWD/build/ARM_RISCV/gem5py
# otool -L $EXE
# install_name_tool -change "@rpath/libc++.1.dylib" "/Users/allen/micromamba/envs/pyenv/lib/libc++.1.dylib" $EXE
# install_name_tool -change "@rpath/libpython3.11.dylib" "/Users/allen/micromamba/envs/pyenv/lib/libpython3.11.dylib" $EXE
# install_name_tool -change "@rpath/libz.1.dylib" "/Users/allen/micromamba/envs/pyenv/lib/libz.1.dylib" $EXE

# EXE=$PWD/build/ARM_RISCV/gem5py_m5
# otool -L $EXE
# install_name_tool -change "@rpath/libc++.1.dylib" "/Users/allen/micromamba/envs/pyenv/lib/libc++.1.dylib" $EXE
# install_name_tool -change "@rpath/libpython3.11.dylib" "/Users/allen/micromamba/envs/pyenv/lib/libpython3.11.dylib" $EXE
# install_name_tool -change "@rpath/libz.1.dylib" "/Users/allen/micromamba/envs/pyenv/lib/libz.1.dylib" $EXE

###############################################################################
