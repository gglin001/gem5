micromamba install scons
micromamba install pybind11

export PYTHON_CONFIG=$(which python3-config)
export LD_LIBRARY_PATH="$CONDA_PREFIX/lib:$LD_LIBRARY_PATH"

scons \
  -j9 \
  build/ALL/gem5.opt
