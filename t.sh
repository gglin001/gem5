# docker
docker run -d -it \
    --name gem5_dev_0 \
    -v $PWD:/gem5 \
    -w /gem5 \
    gem5:latest

# TODO: use clang
# export CC=clang
# export CXX=clang++

# pip install -r requirements.txt
pip install -U scons
apt install libcapstone-dev

# build
scons -j9 build/ALL/gem5.opt

# RISCV
scons -j9 build/RISCV/gem5.fast
scons build/RISCV/compile_commands.json
