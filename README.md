.vim
==========

personal vim configuration, heavily sourced from Eevee from veekun

## For Use
Alias ```vim``` to ```vim -p ~/.vim/.vimrc``` in your preferred shell. Change ~ to wherever you cloned the git repo to.

## Issues
* On systems with limited character support, the lines "set listchars" and "set showbreak" in .vimrc will cause errors. Remove these.
* Some packages managers (looking at you, pacman) have versions of vim without python support by default, which makes the gundo extension unusable. I was able to resolve this in Arch by using the [abs](https://wiki.archlinux.org/index.php/Arch_Build_System) to download the vim package, then edited the PKGBUILD's './configure' instructions from '--disable-python*' to '--enable-python*' wherever any line with python was mentioned.

