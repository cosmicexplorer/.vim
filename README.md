.vim
==========

Personal vim configuration, heavily sourced from Eevee from [veekun](http://veekun.com).

## For Use
Alias ```vim``` to ```vim -u ~/.vim/.vimrc``` in your preferred shell. Change ~ to wherever you cloned the git repo to.

## Issues
* On systems with limited character support, the lines "set listchars" and "set showbreak" in .vimrc will cause errors. Remove these.
* Some package managers (looking at you, pacman) have versions of vim without python support by default, which makes the Gundo and ConqueTerm extensions unusable. [This link](https://gist.github.com/MicahElliott/3048622) has a description of how to resolve the problem.

