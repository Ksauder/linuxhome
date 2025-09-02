from pathlib import Path
import os
from .utils import get_distro, run_cmd
from .pkg_mgrs import manager_for


class Installer:
    def __init__(self, pkgs, dry_run=False, installers_dir="./installers"):
        self.installers_dir = Path(installers_dir)
        self.pkgs_to_install = pkgs
        self.dry_run = dry_run
        self.distro = get_distro()
        self.log(self.distro)
        self.pkgmgr = self.get_pkgmgr()
        self.scripts, self.noscripts = self.get_installers(pkgs)

    def get_pkgmgr(self):
        return manager_for(self.distro["name"].lower())()

    def get_installers(self, pkgs):
        """
        Sort packages into has script and no script for efficiency
        and return a tuple of two lists filled with callables
        """
        has_script = []
        no_script = []

        for pkg in pkgs:
            script = self.get_script(pkg)
            if script is not None:
                has_script.append(script)
            else:
                no_script.append(pkg)
        return has_script, no_script

    def install(self):
        """Needs a path to installers"""
        if self.scripts:
            for script in self.scripts:
                self.install_script(script)
        if self.noscripts:
            self.pkgmgr.refresh()
            for noscript in self.noscripts:
                self.install_pkg(noscript)

    def install_pkg(self, pkg):
        self.pkgmgr.install([pkg], dry_run=self.dry_run)

    def get_script(self, pkg) -> Path | None:
        """
        Currently only supports looking for '.sh' scripts, could support any though
        Takes a package name and checks to see if there is a script for the distro
        """
        pkgscript = pkg + ".sh"
        if not self.installers_dir.exists():
            raise ValueError("self.installers_dir does not exist")
        distro = get_distro()
        common_installer = self.installers_dir / "common" / pkgscript
        distro_installer = self.installers_dir / distro["name"].lower() / pkgscript
        version_installer = (
            distro_installer.parent / distro["version_id"].lower() / pkgscript
        )
        self.log([common_installer, distro_installer, version_installer])
        installer = None
        if version_installer.exists():
            installer = version_installer
        elif distro_installer.exists():
            installer = distro_installer
        elif common_installer.exists():
            installer = common_installer
        else:
            installer = None
        self.log(f"Result from script hunting: {installer}")
        return installer

    def install_script(self, script: Path):
        """
        Just runs a script
        :returns: completed process from subprocess.run, None if dry_run
        """
        return run_cmd(str(script), dry_run=self.dry_run)

    def log(self, msg):
        if self.dry_run:
            print(msg)
