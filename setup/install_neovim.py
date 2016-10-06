#!/usr/bin/env python3

from plumbum import local, FG
from plumbum import colors
from plumbum.cmd import mkdir, git, make

import settings
from utils.messaging import echo


build_dir = settings.DOTFILES_BUILD_DIR
neovim_repo = 'https://github.com/neovim/neovim'

def install_neovim_from_source():

    mkdir['-p'](build_dir)

    echo('Cloning neovim repo...')

    # TODO: Check if neovim already present on system (use 'which' or shutils.which)
    # TODO: Check for existing directory

    with local.cwd(local.cwd / build_dir):
        git['clone', neovim_repo] & FG

    echo('Building and installing neovim...')

    with local.cwd(local.cwd / build_dir / 'neovim'):
        make & FG
        make['install'] & FG

    echo('Neovim installed!')


if __name__ == '__main__':
    install_neovim_from_source()
