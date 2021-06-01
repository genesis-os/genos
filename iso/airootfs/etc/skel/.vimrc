" Syntax and file type configurations
set nocompatible
set autochdir
set tabstop=4
set shiftwidth=4
set expandtab
set number
set visualbell
set paste
set mouse=a
filetype plugin indent on
syntax on
let g:airline#extensions#tabline#enabled = 1
let g:airline_powerline_fonts = 1


" Copy
map <C-c> :w !xsel -i -b<CR><CR>

" Init bundle 
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()
" Plugins
Plugin 'VundleVim/Vundle.vim'
Bundle 'Lokaltog/powerline', {'rtp': 'powerline/bindings/vim/'}
Bundle 'tpope/vim-fugitive'
Bundle 'scrooloose/nerdtree'
Bundle 'Lokaltog/vim-easymotion' 
Plugin 'scwood/vim-hybrid'
Plugin 'scrooloose/nerdcommenter'
Plugin 'fatih/vim-go'
call vundle#end()            " required
filetype plugin indent on    " required

" Powerline setup
set guifont=Source\ Code\ Powerline\ 9
set laststatus=2
let g:Powerline_symbols = 'fancy'

" NerdTree mapping
map <S-Tab> :NERDTreeToggle<CR>

