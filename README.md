.vim
==========

Personal vim configuration, heavily sourced from Eevee from [veekun](http://veekun.com).

## For Use
Alias ```vim``` to ```vim -u ~/.vim/.vimrc``` in your preferred shell. Change ~ to wherever you cloned the git repo to.

## Issues
* On systems with limited character support, the lines "set listchars" and "set showbreak" in .vimrc will cause errors. Remove these.
* Some package managers (looking at you, pacman) have versions of vim without python support by default, which makes the Gundo and ConqueTerm extensions unusable. I was able to resolve this in Arch by using the [abs](https://wiki.archlinux.org/index.php/Arch_Build_System) to download the vim package, then editing the PKGBUILD's './configure' instructions from '--disable-python*' to '--enable-python*' wherever any line with python was mentioned. After rebuilding and reinstalling as described in the page on the abs (don't forget to actually install with pacman -U), ConqueTerm and Gundo should work.

