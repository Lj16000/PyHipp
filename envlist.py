#!/usr/bin/env python3
import sys, os
from pathlib import Path
from filelock import FileLock
import hickle

ENVLIST_PATH = Path("/data/picasso/envlist.hkl")
LOCK_PATH = Path(str(ENVLIST_PATH) + ".lock")

def ensure_dir():
    ENVLIST_PATH.parent.mkdir(parents=True, exist_ok=True)

def save_list(lst):
    hickle.dump(lst, str(ENVLIST_PATH), mode="w")

def load_list():
    return hickle.load(str(ENVLIST_PATH))

def main():
    args = sys.argv[1:]
    ensure_dir()
    lock = FileLock(str(LOCK_PATH))
    with lock:
        if len(args) == 2:
            prefix = args[0]
            n = int(args[1])
            lst = [f"{prefix}{i}" for i in range(n)]
            save_list(lst)
        elif len(args) == 0:
            if not ENVLIST_PATH.exists():
                sys.exit(1)
            lst = load_list()
            if not lst:
                sys.exit(1)
            env = lst.pop(0)
            save_list(lst)
            print(env)
        elif len(args) == 1:
            env = args[0]
            lst = load_list() if ENVLIST_PATH.exists() else []
            lst.append(env)
            save_list(lst)
        else:
            sys.exit(2)

if __name__ == "__main__":
    main()
