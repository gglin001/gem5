###############################################################################

mkdir -p _demos/_log

gem5.opt --help >_demos/_log/gem5.opt.help.log
gem5.opt --list-sim-objects >_demos/_log/gem5.opt.list-sim-objects.log
gem5.opt --debug-help >_demos/_log/gem5.opt.debug-help.log
gem5.opt --stats-help >_demos/_log/gem5.opt.stats-help.log

###############################################################################

# git clone git@github.com:pybind/pybind11.git -b v2.12 --single-branch ext/pybind11

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
