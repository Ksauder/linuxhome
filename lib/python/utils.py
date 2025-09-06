from typing import List, Dict, Union
from pathlib import Path
from subprocess import CompletedProcess, run
import os
import shlex


def read_dotenv(path: Union[Path, str]) -> Dict:
    """Supports basic dotenv VAR=VAL files"""
    if not isinstance(path, Path):
        path = Path(path)
    ret = {}
    with path.open("r") as f:
        for line in f.readlines():
            if line.startswith("#"):
                continue
            var, val = line.split("=", 1)
            ret[var] = val.strip("\"'\n")
    return ret


def get_distro() -> Dict:
    d = read_dotenv("/etc/os-release")
    return {
        "name": d["NAME"],
        "pretty_name": d["PRETTY_NAME"],
        "version": d["VERSION"],
        "version_id": d["VERSION_ID"],
        "version_codename": d["VERSION_CODENAME"],
    }


def run_cmd(cmd: Union[List[str], str], env=None, dry_run=False) -> Union[CompletedProcess, None]:
    if not isinstance(cmd, list):
        cmd = [cmd]
    if dry_run:
        try:
            print("$", " ".join(shlex.quote(c) for c in cmd))
        except:
            print(cmd)
        return None
    return run(cmd, check=True, env=env)


def have_cmd(name: str) -> bool:
    from shutil import which

    return which(name) is not None


def sudo_prefix() -> List[str]:
    if os.geteuid() == 0:
        return []
    return ["sudo"]
