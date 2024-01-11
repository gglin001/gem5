# docker
docker run -d -it \
    --name gem5_rv_dev_0 \
    -v $PWD:/gem5 \
    -w /gem5 \
    gem5:latest

docker run -d -it \
    --name gem5_all_dev_0 \
    -v $PWD:/gem5 \
    -w /gem5 \
    gem5:latest

# use clang
export CC=clang
export CXX=clang++

# pip install -r requirements.txt
pip install -U scons
apt install libcapstone-dev

# cannot build with conda env
micromamba deactivate

# all
scons -j9 build/ALL/gem5.opt
scons build/ALL/compile_commands.json

# only RISCV
scons -j9 build/RISCV/gem5.fast
scons build/RISCV/compile_commands.json
