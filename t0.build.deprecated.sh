# used in docker env

# for vscode
cat >>/root/.bashrc <<-EOF
export PATH=\$PATH:\${EXT_PATH}
export PYTHONPATH=\$PYTHONPATH:\${EXT_PYTHONPATH}
EOF

# use clang
export CC=clang
export CXX=clang++
# or
cat >>/root/.bashrc <<-EOF
micromamba deactivate
export CC=clang
export CXX=clang++
EOF

# cannot build with conda env
micromamba deactivate

# pip install -r requirements.txt
pip install -U scons
apt install libcapstone-dev

# all
# scons -j9 build/ALL/gem5.debug
scons -j9 build/ALL/gem5.opt
scons build/ALL/compile_commands.json
# only RISCV
# scons -j9 build/RISCV/gem5.debug
# scons -j9 build/RISCV/gem5.opt
# scons build/RISCV/compile_commands.json

# optional: cp files for python type-hint
cp build/ALL/python/m5/defines.py src/python/m5/
cp build/ALL/python/m5/info.py src/python/m5/
# cp build/RISCV/python/m5/defines.py src/python/m5/
# cp build/RISCV/python/m5/info.py src/python/m5/
