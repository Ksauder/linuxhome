from typing import List, Type
import abc
from .utils import sudo_prefix, have_cmd, run_cmd


class PkgManager(abc.ABC):
    install_cmd: list[str] = list("")
    uninstall_cmd: list[str] = list("")
    refresh_cmd: list[str] = list("")

    def refresh(self):
        return run_cmd(sudo_prefix() + self.refresh_cmd)

    def install(self, pkgs: list[str], dry_run=False):
        return run_cmd(sudo_prefix() + self.install_cmd + pkgs, dry_run=dry_run)


class Apt(PkgManager):
    refresh_cmd = ["apt-get", "update", "-y"]
    install_cmd = ["apt-get", "install", "-y", "--no-install-recommends"]
    uninstall_cmd = ["apt-get", "remove", "-y"]


class Dnf(PkgManager):
    refresh_cmd = ["dnf", "makecache", "-y"]
    install_cmd = ["dnf", "install", "-y"]
    uninstall_cmd = ["dnf", "remove", "-y"]


class Yum(PkgManager):
    refresh_cmd = ["yum", "makecache", "-y"]
    install_cmd = ["yum", "install", "-y"]
    uninstall_cmd = ["yum", "remove", "-y"]


class Pacman(PkgManager):
    refresh_cmd = ["pacman", "-Sy", "--noconfirm"]
    install_cmd = ["pacman", "-S", "--noconfirm", "--needed"]
    uninstall_cmd = ["pacman", "-R", "--noconfirm"]


class Zypper(PkgManager):
    refresh_cmd = ["zypper", "--non-interactive", "refresh"]
    install_cmd = ["zypper", "--non-interactive", "install", "--no-confirm"]
    uninstall_cmd = ["zypper", "--non-interactive", "remove", "-y"]


class Apk(PkgManager):
    refresh_cmd = ["apk", "update"]
    install_cmd = ["apk", "add"]
    uninstall_cmd = ["apk", "del"]


class Xbps(PkgManager):
    refresh_cmd = ["xbps-install", "-S"]
    install_cmd = ["xbps-install", "-y"]
    uninstall_cmd = ["xbps-remove", "-R"]


MANAGERS = {
    "apt": Apt,
    "dnf": Dnf,
    "yum": Yum,
    "pacman": Pacman,
    "zypper": Zypper,
    "apk": Apk,
    "xbps": Xbps,
}


def manager_for(
    distro: str, likes: List[str] | None = None, override: str | None = None
) -> Type[PkgManager]:
    if override:
        return MANAGERS[override]
    if likes:
        cands = [distro] + likes
    else:
        cands = [distro]
    # naive mapping by known families
    if any(x in cands for x in ["debian", "ubuntu", "raspbian", "linuxmint", "pop"]):
        return MANAGERS["apt"]
    if any(x in cands for x in ["fedora", "rhel", "centos", "rocky", "almalinux"]):
        # prefer dnf when present, else yum
        return MANAGERS["dnf" if have_cmd("dnf") else "yum"]
    if any(x in cands for x in ["arch", "manjaro", "endeavouros"]):
        return MANAGERS["pacman"]
    if any(x in cands for x in ["opensuse", "sles", "sle"]):
        return MANAGERS["zypper"]
    if any(x in cands for x in ["alpine"]):
        return MANAGERS["apk"]
    if any(x in cands for x in ["void"]):
        return MANAGERS["xbps"]
    # last-ditch: try what exists
    for k in ["apt", "dnf", "yum", "pacman", "zypper", "apk", "xbps"]:
        if have_cmd(k if k != "xbps" else "xbps-install"):
            return MANAGERS[k]
    raise SystemExit("No supported package manager found")
