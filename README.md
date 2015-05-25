.vim
==========

Personal vim configuration, heavily sourced from Eevee from [veekun](http://veekun.com).

## For Use
Alias ```vim``` to ```vim -u ~/.vim/.vimrc``` in your preferred shell. Change ~ to wherever you cloned the git repo to.

Also, if using `sudo vim` or vim from within `su`, you may experience errors like "cannot find pathogen#xxx'. If this occurs, try copying the contents of this repo into `/usr/share/vim`, or even symlinking `/usr/share/vim` to this repo (not recommended for security reasons, but easier). There's a bit of python code in [the init file](.vimrc) that scans `/usr/share/vim` if the user is root.

## Issues
* On systems with limited character support, the lines "set listchars" and "set showbreak" in .vimrc will cause errors. Remove these.
* Some package managers (looking at you, pacman) have versions of vim without python support by default, which makes the Gundo and ConqueTerm extensions unusable. [This link](https://gist.github.com/MicahElliott/3048622) has a description of how to resolve the problem.

