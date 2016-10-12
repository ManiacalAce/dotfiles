#!/usr/bin/env python3

import os

from settings import DOTFILES_ROOT_DIR
from utils.file_utils import install_dotfiles


def install_neovim_dotfiles():
    install_dotfiles('neovim', 'dotfiles/nvim', '~/.config/nvim')

    # Make directory for persistent undo
    os.makedirs(os.path.join(DOTFILES_ROOT_DIR, 'dotfiles/nvim/undo'), exist_ok=True)


def install_zsh_dotfiles():
    install_dotfiles('zshenv', 'dotfiles/zsh/zshenv', '~/.zshenv')
    install_dotfiles('zshrc', 'dotfiles/zsh/zshrc', '~/.zshrc')


def install_all_dotfiles():
    install_neovim_dotfiles()
    install_dotfiles(
        'vim_plug', 'dotfiles/nvim/vim_plug/plug.vim', '~/.config/nvim/autoload/plug.vim'
    )
    install_zsh_dotfiles()


if __name__ == '__main__':
    install_all_dotfiles()
