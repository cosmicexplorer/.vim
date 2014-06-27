.vim
==========

personal vim configuration, heavily sourced from Eevee from veekun

## For Use
Alias ```vim``` to ```vim -p ~/.vim/.vimrc``` in your preferred shell. Change ~ to wherever you cloned the git repo to.

## Issues
On systems with limited character support, the lines "set listchars" and "set showbreak" in .vimrc will cause errors. Remove these.

## How to install required packages

### Using [pathogen](https://github.com/tpope/vim-pathogen)

``` bash
cd ~/.vim
mkdir -p bundle && cd bundle
git clone git://github.com/JuliaLang/julia-vim.git
```

### Using [vundle](https://github.com/gmarik/vundle)

Add a new bundle to your `.vimrc`:

``` vim
Bundle 'JuliaLang/julia-vim'
```

Run `vim` and update your bundles:

``` vim
:BundleInstall!
```

### Manually

Copy (or symlink) the contents of this repository into the vim application support directory:

``` bash
git clone git://github.com/JuliaLang/julia-vim.git
cd julia-vim
cp -R * ~/.vim
```

Julia should appear as a file type and be automatically detected for files with the `.jl` extension.
