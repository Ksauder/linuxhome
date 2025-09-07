from typing import List
from pathlib import Path

from .utils import have_cmd, run_cmd


def bootstrap(stow_pkgs: List[str], dry_run=False):
    if not have_cmd("stow"):
        raise OSError("`stow` is not installed, cannot bootstrap")
    return run_cmd(
        ["stow", "--dotfiles", "-d", "./dotfiles", "-t", Path.home()] + list(stow_pkgs),
        dry_run=dry_run,
    )


def unbootstrap(stow_pkgs: List[str], dry_run=False):
    if not have_cmd("stow"):
        raise OSError("`stow` is not installed, cannot bootstrap")
    return run_cmd(
        ["stow", "-D", "--dotfiles", "-d", "./dotfiles", "-t", Path.home()]
        + list(stow_pkgs),
        dry_run=dry_run,
    )
