import csv
import os

fp_mods = "stubgen/m5.mods.csv"
src_dir = os.path.dirname(os.path.dirname(__file__))

m5_objects_dir = "src/python/m5/objects"
m5_objects_init = "src/python/m5/objects/__init__.pyi"
m5_init = "src/python/m5/__init__.pyi"
# TODO: replace with logging module
fp_m5_objects_init = open(m5_objects_init, "w")
fp_m5_init = open(m5_init, "w")


def deal_m5_init(mod: str, abspath: str):
    # deal abspath
    abspath = abspath.replace(src_dir, "")
    abspath = abspath.replace("/", ".")
    if abspath.endswith(".py"):
        abspath = abspath[:-3]

    if abspath.startswith(".src."):
        # deal `.src.*`
        abspath = abspath.replace(".src.", "...")
    elif abspath.startswith(".build"):
        return

    if abspath.endswith(".__init__"):
        abspath = abspath.removesuffix(".__init__")
        # TODO
        imp = f"import {abspath}"
        return
    else:
        # imp = f"from {abspath} import {mod}"
        imp = f"from {abspath} import *"

    print(imp, file=fp_m5_init)


def deal_m5_objects_init(mod: str, abspath: str):
    # deal abspath
    abspath = abspath.replace(src_dir, "")
    abspath = abspath.replace("/", ".")
    if abspath.endswith(".py"):
        abspath = abspath[:-3]

    if abspath.startswith(".src."):
        # deal `.src.*`
        abspath = abspath.replace(".src.", "....")
    elif abspath.startswith(".build"):
        return

    if abspath.endswith(".__init__"):
        abspath = abspath.removesuffix(".__init__")
        # TODO
        # imp = f"import {abspath}"
        return
    else:
        # imp = f"from {abspath} import {mod}"
        imp = f"from {abspath} import *"

        # create `m5.objects.CLASS.pyi`
        class_name = mod.split(".")[-1]
        with open(f"{m5_objects_dir}/{class_name}.pyi", "w") as class_fp:
            print(imp, file=class_fp)

    print(imp, file=fp_m5_objects_init)


def main():
    with open(fp_mods) as f:
        mods = csv.reader(f, delimiter=",")
        for mod in mods:
            if not mod[0].startswith(("gem5.", "m5.")):
                continue
            assert len(mod) == 2
            mod, abspath = mod

            if mod.startswith("m5.objects"):
                deal_m5_objects_init(mod, abspath)
            else:
                deal_m5_init(mod, abspath)

    # special case, hardcode
    imp = f"from ....sim.System import System as System"
    print(imp, file=fp_m5_objects_init)

    # special case, hardcode
    imp_init = """
from . import (
    trace,
    debug,
)
    """
    print(imp_init, file=fp_m5_init)


if __name__ == "__main__":
    main()
